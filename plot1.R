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
globalactivepower <- as.numeric(datarange$Global_active_power)

# plot 1 - Global Active Power
png("plot1.png", width=480, height=480)
hist(globalactivepower, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="", col="red")
# closing devices
dev.off()
