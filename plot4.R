## 
# Exploratory Data Aanalysis / Johns Hopkins / Coursera
# Project 1
# June 2015
##

library(tidyr)
library(dplyr)

## Loading the dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
datafn <- "household_power_consumption.txt"
pngfn <- "plot4.png"

if (!file.exists(datafn))
{
    tmp <- tempfile()
    download.file(url, tmp)
    datafn <- unz(tmp, datafn)
}

data <- read.csv(datafn, sep=";", stringsAsFactors=FALSE)
data <- tbl_df(data)

## Tidying Date & Time
data <- unite(data, "DateTime", Date, Time, sep=" ")
data$DateTime <- as.POSIXct(strptime(data$DateTime, "%d/%m/%Y %T"))

## Filtering by date
data <- filter(data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")

## Tidying numeric columns
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Plotting to screen
par(mfrow = c(2,2))

with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data, plot(DateTime, Voltage, type="l", xlab="datetime"))

with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")

with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

## Plotting to PNG
png(file=pngfn, bg="transparent")
par(mfrow = c(2,2))

with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data, plot(DateTime, Voltage, type="l", xlab="datetime"))

with(data, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty="n")

with(data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))
dev.off()

par(mfrow = c(1,1))
