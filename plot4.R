### Exploratory Data Analysis, Week1

## Load data (set wd to data location)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                   colClasses = c("character","character","numeric","numeric","numeric",
                                  "numeric","numeric","numeric","numeric"))

## Date column change to Date type; current format is d/m/y
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Time column change type
#data$Time <- as.POSIXct(data$Time, format = "%H:%M:%s")

## Subset only dates we want
dataSubset <- subset(data, data$Date == '2007-02-01' | data$Date == '2007-02-02')

## Combine Date and Time columns into one so that we can use POSIXlt for days of week
DateTime <- paste(dataSubset$Date, dataSubset$Time)

## Now convert DateTime column
dataSubset$DateTime <- as.POSIXlt(DateTime)

## Reorder data file to include new DateTime, exclude original Date and Time
dataSubset <- dataSubset[,c(10,3:9)]

######################################

## Create fourth plot
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(dataSubset, {
     plot(dataSubset$DateTime, dataSubset$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
     plot(dataSubset$DateTime, dataSubset$Voltage, xlab = "datetime", ylab = "Voltage", type='l')
     plot(dataSubset$DateTime, dataSubset$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
     lines(dataSubset$DateTime, dataSubset$Sub_metering_2, col = "red")
     lines(dataSubset$DateTime, dataSubset$Sub_metering_3, col = "blue")
     legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, 
            bty = "n", col=c("black", "red", "blue"))
     plot(dataSubset$DateTime, dataSubset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type='l')
})
dev.off()
