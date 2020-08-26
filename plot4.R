# getting the data
if (!(file.exists("data"))) {
  dir.create("data")
}
if (!(file.exists("data/powerconsumption.zip"))) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile ="data/powerconsumption.zip", method="curl")
}
if (!(file.exists("data/household_power_consumption.txt"))) {
  unzip("data/powerconsumption.zip",exdir="data")
}

# reading
data <- read.table("./data/household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# extracting specific information for the graphics
datarange <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

# creating a time series
timeseries <- strptime(paste(datarange$Date, datarange$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# subsetting 
globalactivepower <- as.numeric(datarange$Global_active_power)
globalreactivepower <- as.numeric(datarange$Global_reactive_power)
voltage <- as.numeric(datarange$Voltage)

# submetering data
submetering1 <- as.numeric(datarange$Sub_metering_1)
submetering2 <- as.numeric(datarange$Sub_metering_2)
submetering3 <- as.numeric(datarange$Sub_metering_3)

# plot 4 - Multiple Plots
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
# plot #1
plot(timeseries, globalactivepower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# plot #2
plot(timeseries, voltage, type="l", xlab="datetime", ylab="Voltage")
# plot #3
plot(timeseries, submetering1, type="l", xlab="", ylab="Energy Submetering")
lines(timeseries, submetering2, type="l", col="red")
lines(timeseries, submetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# plot #4
plot(timeseries, globalreactivepower, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
# closing devices
dev.off()
