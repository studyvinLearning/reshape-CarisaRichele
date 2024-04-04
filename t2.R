
#2 Download and read in the bloodPressure.RDS file
# each row is a person
# blood pressure is measure with two values: systolic and diastolic
# each persons blood pressure was measured every day for a month
# reshape the data to only have 4 columns: person, date, systolic/diastolic, and the value
# fix the date to be in the nice format for R
# calculate the mean diastolic and the mean systolic by the days of the week

# You should be turning in 2 separate R files. If you do not understand something then ask the instructor before the due date.
library(dplyr)
library(tidyr)
path <- "~/Documents/R/STAT4880_DataWrangling/Wk11"
path
list.files(path)
data2 <- readRDS(file.path(path,'bloodPressure.RDS'))
glimpse(data2)

# First, pivot the data to long format with separate columns for each measurement type
dataLong <- pivot_longer(data2, 
                          cols = -person, 
                          names_to = "measurement_type", 
                          values_to = "value")

# Then, separate the measurement type into systolic/diastolic and date
dataLong <- separate(dataLong, 
                      measurement_type, 
                      into = c("systolic | diastolic", "date"), 
                      sep = " ")


dataLong$date <- as.Date(dataLong$date, format = "%Y-%m-%d")  # Adjust the format

library(lubridate)
# Add a new column for the day of the week
dataLong$weekDay <- wday(dataLong$date, label=TRUE) #weekdays(dataLong$date)

#Calculate the mean diastolic and the mean systolic by the days of the week
dataLongSum <- dataLong %>%
  group_by(weekDay) %>%
  summarise(avg=mean(value), sd=sd(value), n=n())
dataLongSum
