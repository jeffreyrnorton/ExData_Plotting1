library(ggplot2)

# Get the current directory - it would be nice to put everything in the subdirectory where things are running...
current.directory <- getSrcDirectory(function(x) {x})
setwd(current.directory)

# Source R code which gets the data
source("extractData.R")

# Get the data
power.data <- extractData()

df <- data.frame(x=power.data$Datetime, y=power.data$Global_active_power)

p <- ggplot(data=df, aes(x=x, y=y)) + geom_line() +
  ylab("Global Active Power (kilowatts)") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

print(p)