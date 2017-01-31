library(ggplot2)

# Get the current directory - it would be nice to put everything in the subdirectory where things are running...
current.directory <- getSrcDirectory(function(x) {x})
setwd(current.directory)

# Source R code which gets the data
source("extractData.R")

# Get the data
power.data <- extractData()


p <- ggplot(data=power.data, aes(Datetime)) +
  geom_line(aes(y=Sub_metering_1, color="black")) +
  geom_line(aes(y=Sub_metering_2, color="red")) +
  geom_line(aes(y=Sub_metering_3, color="green")) +
  ylab("Energy sub metering") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a") +
  scale_color_manual(name="",
                     labels=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     values=c("black", "red", "green")) +
  theme(legend.position=c(1, 1), legend.justification=c(1,1))

  print(p)