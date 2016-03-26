
##########################################################################################################
## Coursera - Exploratory Data Analysis - Plotting Assignment 1
# Course Project
# Sathyanarayanan Shanmugavelu
# 2016-03/26

## plot1.R - generates plot1.png

# Refs
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Output/Results
# 1. plot1.png
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

## Formatting the date and subseting the data only on 2007-02-01 and 2007-02-02
df.power$Date = as.Date(df.power$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
df.power = df.power[df.power$Date >= startDate & df.power$Date <= endDate, ]

## Creating the plot
png(filename="plot1.png", width=480, height=480)
hist(df.power$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()
