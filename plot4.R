filename <- "household power consumption.zip"

## Download and unzip the dataset

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}  
if (!file.exists("household power consumption.txt")) { 
  unzip(filename) 
}

## load the data into R and filter wanted data
data <- read.table("household_power_consumption.txt",header = TRUE, sep = ";",nrow = 300000,
                   stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format = ("%d/%m/%Y"))
data2 <- subset.data.frame(data, data$Date >= "2007-2-1" & data$Date <="2007-2-2")

## plot 4
png("plot4.png", width=480, height=480)
par(mfcol = c(2,2))
data2$Global_active_power <- as.numeric(data2$Global_active_power)
TimeNdate <- paste(data2$Date, data2$Time, sep = " ")
TimeNdate <- as.POSIXct(TimeNdate)
plot(TimeNdate, data2$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(TimeNdate, data2$Global_active_power)

data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3 <- as.numeric(data2$Sub_metering_3)
TimeNdate <- paste(data2$Date, data2$Time, sep = " ")
TimeNdate <- as.POSIXct(TimeNdate)
plot(TimeNdate, data2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(TimeNdate, data2$Sub_metering_2, type = "l",col = "red")
lines(TimeNdate, data2$Sub_metering_3, type = "l",col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, col = c("black","red", "blue"))

data2$Voltage <- as.numeric(data2$Voltage)
plot(TimeNdate, data2$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(TimeNdate, data2$Voltage)

data2$Global_reactive_power <- as.numeric(data2$Global_reactive_power)
plot(TimeNdate, data2$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(TimeNdate, data2$Global_reactive_power)

dev.off()

