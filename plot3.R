library(readr)
library(dplyr)

setwd("E:/R/C4/week1/course_project")
## Download zip file if not exists
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.zip")){
    download.file(zipUrl, destfile = "household_power_consumption.zip")
}
## Unzip zip file if target directory didn't exist
if (!dir.exists("household_power_consumption")){
    unzip("household_power_consumption")
}

## Read if household_power_compsumption.txt has been read yet.
if (!exists("houseCompData")){
    ## Read data from 2007-02-01 to 2007-02-02 into houseCompData
    houseCompData <- read_delim("./household_power_consumption/household_power_consumption.txt",
                                delim=";",col_names = TRUE,
                                col_types = "ctddddddd", na ="?") 
    houseCompData <- filter(houseCompData, 
                            Date=="1/2/2007" |  Date =="2/2/2007" )
    ##  convert the Date and Time variables to Date/Time classes
    houseCompData$Date <- as.Date(houseCompData$Date,"%d/%m/%Y")
    datetime <- paste(houseCompData$Date, houseCompData$Time)
    houseCompData$Time <- strptime(datetime, "%Y-%m-%d %H:%M:%S")
}
##plot3
with(houseCompData, plot(Time,Sub_metering_1, 
                         type="l", col= "black",
                         xlab = "", ylab = "Energy sub metering"))
with(houseCompData, points(Time,Sub_metering_2, 
                           type="l", col= "red"))
with(houseCompData, points(Time,Sub_metering_3, 
                           type="l", col= "blue"))
legend("topright", legend=c("Sub_metering_1",
                            "Sub_metering_2",
                            "Sub_metering_3"),
       col = c("black", "red", "blue"), pch ="-")
dev.copy(png, file = "plot3.png")
dev.off()