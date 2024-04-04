# update the readme file

#1 Use data(federalistPapers, package='syllogi') to get the federalist paper data
# Create a data frame that paper number, author, journal, date
# Determine the day of the week that each paper was published.
# Get the count of papers by day of the week and author
# create a new data frame that has authors as column names and dates of publication as the values


data(federalistPapers, package='syllogi')
sapply(federalistPapers, is.null) #check for NULL elements

# Extract information from each element in the list
#These aren't being extracted correctly
paperNum <- sapply(federalistPapers, function(x) x$paper)
author <- sapply(federalistPapers, function(x) x$author)
journal <- sapply(federalistPapers, function(x) x$journal)
date <- sapply(federalistPapers, function(x) as.Date(x$date, format = "%Y-%m-%d"))

# Create a data frame with paper number, author, journal, and date
######this is where the error is############
papersDF <- data.frame(
  paperNum = paperNum,
  author = author,
  journal = journal,
  date = date
)

# Determine the day of the week for each paper
papersDF$weekDay <- wday(papersDF$date, label=TRUE) 
#papersDF$weekDay <- weekdays(papersDF$date)

# Get the count of papers by day of the week and author
papersCount <- table(papersDF$weekDay, papersDF$author)
papersCount 
# Create a new data frame with authors as column names and dates of publication as the values
datesByAuthor <- split(papersDF$date, papersDF$author)
datesByAuthor
##Not working but I'm not sure why yet... still troubleshooting
