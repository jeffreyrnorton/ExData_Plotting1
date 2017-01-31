library(ggplot2)
library(gridExtra)

# Get the current directory - it would be nice to put everything in the subdirectory where things are running...
current.directory <- getSrcDirectory(function(x) {x})
setwd(current.directory)

# Source R code which gets the data
source("extractData.R")

# Get the data
power.data <- extractData()

p1.1 <- ggplot(data=power.data, aes(x=Datetime, y=Global_active_power)) + geom_line() +
  ylab("Global Active Power") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

p1.2 <- ggplot(data=power.data, aes(x=Datetime, y=Voltage)) + geom_line() +
  ylab("Voltage") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

p2.1 <- ggplot(data=power.data, aes(Datetime)) +
  geom_line(aes(y=Sub_metering_1, color="black")) +
  geom_line(aes(y=Sub_metering_2, color="red")) +
  geom_line(aes(y=Sub_metering_3, color="green")) +
  ylab("Energy sub metering") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a") +
  scale_color_manual(name="",
                     labels=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     values=c("black", "red", "green")) +
  theme(legend.position=c(1, 1), legend.justification=c(1,1), legend.text=element_text(size=8),
        legend.key.height=unit(3, units="mm"))

p2.2 <- ggplot(data=power.data, aes(x=Datetime, y=Global_reactive_power)) + geom_line() +
  ylab("Global reactive power") + xlab("") +
  scale_x_datetime(date_breaks = "1 day", date_labels = "%a")

mp <- gridExtra::grid.arrange(p1.1, p1.2, p2.1, p2.2, ncol=2)

