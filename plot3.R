
##########################################################################################################
## Coursera - Exploratory Data Analysis - Plotting Assignment 1
# Course Project
# Sathyanarayanan Shanmugavelu
# 2016-03/26

## plot3.R - generates plot3.png

# Refs
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Output/Results
# 1. plot3.png
##########################################################################################################


## First of all, we make sure we have the downloaded data available, we will
## put it in a file in the local working directory
filename = "exdata-data-household_power_consumption.zip"
if (!file.exists(filename)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                         destfile = filename)
}

# Cleanup 
rm(list = ls())

# Fetch and unzip the data set
baseDir <- "."

# Create data sub-directory if necessary
dataDir <- paste(baseDir, "data", sep="/")
if(!file.exists(dataDir)) {
  dir.create(dataDir)
}

# Download original data if necessary (skip if exists already as it takes time)
zipFilePath <- paste(dataDir, "exdata-data-household_power_consumption.zip", sep="/")
if (!file.exists(zipFilePath)) {
  zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file (zipFileUrl, zipFilePath)
  dateDownloaded <- date()
  cat ("Dataset downloaded on:", dateDownloaded,"\n")
}

# Unzip and creates dataSetDir if necessary
dataSetDir <-  paste (baseDir, "Electric power consumption", sep="/")
if (!file.exists(dataSetDir)) {
  unzip (zipFilePath, exdir=baseDir)
}
list.files(baseDir)


## Reading the data from the contents of the zipped file
df.power = read.csv("household_power_consumption.txt", header=T,
                    sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## Formatting the date and time and subseting the data only on 2007-02-01 and 2007-02-02
df.power$timestamp = strptime(paste(df.power$Date, df.power$Time),
                              format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df.power = df.power[df.power$timestamp >= startDate & df.power$timestamp <= endDate, ]

## Creating the plot
png(filename="plot3.png", width=480, height=480)
plot(df.power$timestamp, df.power$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(df.power$timestamp, df.power$Sub_metering_2, col="red")
lines(df.power$timestamp, df.power$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off()