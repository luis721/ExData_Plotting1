# import libraries
library(dplyr)
# CONFIG
Sys.setlocale("LC_ALL","English")

# Dataset file name
file <- "household_power_consumption.txt"
# Columns
columns <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
# Reading the data. Only the needed columns for this plot are read
datos <- read.csv(file,sep = ";", col.names = columns,na.strings = c("?"),
                  colClasses = c(rep("character", 2), rep("double", 7)))
# Format the date column
datos <- mutate(datos, date=as.POSIXct(paste(date, time),format="%d/%m/%Y%H:%M:%S"))
# Pick the needed date range
datos <- subset(datos, date >= "2007-02-01 " & date < "2007-02-03")

## PLOTTING
# Plot the data using lines type plot and save to a file
png("plot4.png", width = 480, height = 480)

# Create 4-plots canvas
par(mfrow = c(2, 2))
# Plot 1
plot(datos$date, datos$global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="l")
# Plot 2
plot(datos$date, datos$voltage, ylab = "Voltage", xlab="datetime", type="l")
# Plot 3
plot(datos$date, datos$sub_metering_1, ylab = "Energy Sub Metering", xlab="", type="n")
lines(datos$date, datos$sub_metering_1, lty=1, col=1)
lines(datos$date, datos$sub_metering_2, lty=1, col=2)
lines(datos$date, datos$sub_metering_3, lty=1, col="blue")
legend("topright", col=c(1, 2, "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)
# Plot 4
plot(datos$date, datos$global_reactive_power, ylab = "Global_rective_power", xlab="datetime", type="l")
dev.off()
