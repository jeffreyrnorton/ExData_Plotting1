
# getData -- Function that reads the data (from wherever we have it last) and subsets down the the dates
# we want to process.
getData <- function() {
  # Download the file into a new directory
  data.dir <- "PowerConsumptionDataSet"
  data.zip <- "PowerConsumption.zip"
  data.file <- "household_power_consumption.txt"
  if( !dir.exists(data.dir) || !file.exists(file.path(data.dir,data.zip)) ) {
    dir.create(data.dir)
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile=file.path(data.dir,data.zip))
  }
  # Unzip
  setwd(data.dir)
  if( !file.exists(data.file) )
    unzip(data.zip)
  
  # Read the file.  Assume that the data does not change (a safe assumption)
  # and skip to the data that we need for Feb 1-2, 2007.  We read some lines on
  # either side with this (just for safety)
  data <- read.csv(data.file, sep=";", skip=66635, nrows=2883)
  colnames(data) <-c("Date", "Time", "Global_active_power", "Global_reactive_power",
                     "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  # Convert the first column to class Date
  data[["Date"]] <- strptime(data$Date, format="%d/%m/%Y")
  # Subset from here
  data <- subset(data,
                 Date>=strptime("1/2/2007", format="%d/%m/%Y") &
                 Date<=strptime("2/2/2007", format="%d/%m/%Y"))
  
  setwd("..")
  data
}


## Add.Datetime.Column - Add a POSIXct column called "Datetime" for doing the time-series plots.
Add.Datetime.Column <- function(data) {
  # After reading the data, it would be nice to have a real POSIXct to work with in the data.frame
  data[["Datetime"]] <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
  data
}


## Get the data in a form that we can process it for any plot...
extractData <- function() {

  # Read the file...
  power.data <- getData()

  # Generate a column of POXIXct
  Add.Datetime.Column(power.data)
}




