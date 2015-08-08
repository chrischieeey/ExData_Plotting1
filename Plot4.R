##Plot4.R
##4 charts of Global Active Power in Kilowatts
##--------------------------------------------------------------
##0: Check if file is exists
##1: Get file/ data and read date information as.date
##2: Subset data by timeframe (2007-02-01 to 2007-02-02); "Tidy" for the purpose of this assignment
##3: Convert date and time
##4: Set global values for charting device
##5: Create chart and PNG file
##--------------------------------------------------------------

#0: Check if data and plot exists
if(!file.exists("household_power_consumption.txt")) {
        stop("Error: Household Power Consumption data not found!")
} else if(file.exists("Plot4.png")) {
        stop("Congratulations, Plot4.png already exists.")
}       

#1: Get file/ data and read date information as.date
#Note: Not comma but semicolon separated
Raw_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ';', na.strings = "?", check.names = FALSE, stringsAsFactors = FALSE, comment.char="", quote='\"')
Raw_data$Date <- as.Date(Raw_data$Date, format="%d/%m/%Y")

#2: Subset data by timeframe (2007-02-01 to 2007-02-02); "Tidy" for the purpose of this assignment
Tidy_data <- subset(Raw_data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(Raw_data)

#3: Convert date and time
Date_And_Time <- paste(as.Date(Tidy_data$Date), Tidy_data$Time)
Tidy_data$Datetime <- as.POSIXct(Date_And_Time)


#4: Set global values for charting device
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 2))


#5: Create Histogram and PNG file
with(Tidy_data,{
#Chart 1, topleft
plot(Global_active_power~Datetime, type = "l", ylab = "Global Active Power", xlab = "")
#Chart 2, topright
plot(Voltage~Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
#Chart 3, including legend, bottomleft
plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2~Datetime, col = 'Red')
lines(Sub_metering_3~Datetime, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pt.cex=1, cex = 0.5)
#Chart 4, bottomright
plot(Global_reactive_power~Datetime, type = "l", ylab = "Global_reactive_power (kilowatts)", xlab = "datetime")
})
#PNG
dev.copy(png, file = "Plot4.png", height = 480, width = 480)
dev.off() #Don't forget to close the device!