# ---
# title: "Week1-Assignment"
# author: "Ross Lockwood"
# date: "2/5/2020"
# output: html_document
# ---

library(tidyverse)
library(lubridate)

setwd("~/R/Coursera/ExploratoryDataAnalysis")

data_filename <- "household_power_consumption.txt"


raw_data <- read.delim(data_filename,sep=";")

raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")

raw_data$Time <- format(strptime(raw_data$Time, format="%H:%M:%S"), "%H:%M:%S")

raw_data$Global_active_power <- as.numeric(raw_data$Global_active_power)

sub_data <- raw_data %>% filter(Date %in% as.Date(c("13/02/2007","14/02/2007"), "%d/%m/%Y"))

sub_data <- sub_data %>% mutate(date_time=as.POSIXct(paste(sub_data$Date,sub_data$Time), "%d/%m/%Y %H:%M:%S"))


# plot 3

plot(sub_data$date_time, sub_data$Sub_metering_1, type="l", xlab="Date/Time", ylab="Energy Sub Metering")
lines(sub_data$date_time, sub_data$Sub_metering_2, col="red")
lines(sub_data$date_time, sub_data$Sub_metering_3, col="blue")
legend("topright", c("Sub Metering 1", "Sub Metering 2" ,"Sub Metering 3"), col=c("black", "red", "blue"))

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
