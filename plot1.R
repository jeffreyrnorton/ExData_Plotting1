
# Get the current directory - it would be nice to put everything in the subdirectory where things are running...
current.directory <- getSrcDirectory(function(x) {x})
setwd(current.directory)

# Source R code which gets the data
source("extractData.R")

# Get the data
power.data <- extractData()

# Create a histogram plot (Plot 1)
histogram <- hist(x=power.data$Global_active_power, xlab="Global Active Power (kilowatts)",
                  main="Global Active Power", col="red")
