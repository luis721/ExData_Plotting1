library(dplyr)
# Dataset file name
file <- "household_power_consumption.txt"
# Columns
columns <- c("date", "time", "global_active_power", "global_reactive_power", "voltage", "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")
# Reading the data. Only the needed columns for this plot are read
datos <- read.csv(file,sep = ";", col.names = columns,na.strings = c("?"),
                  colClasses = c("character", "NULL", "double", rep("NULL", 6)))

# Format the date column
datos <- mutate(datos, date=as.Date(date,format="%d/%m/%Y"))
# Pick the needed date range
datos <- subset(datos,date >= "2007-02-01" & date <= "2007-02-02")
# Plot the data using an histogram and save to a file
png("plot1.png", width = 480, height = 480)
hist(datos$global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",col="brown1")
dev.off()
