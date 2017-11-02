library(readr)
library(dplyr)

setwd("E:/R/C4/week1/course_project1")
## Download zip file if not exists
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.zip")){
    download.file(zipUrl, destfile = "household_power_consumption.zip")
}
## Unzip zip file if target directory didn't exist
if (!dir.exists("household_power_consumption")){
    unzip("household_power_consumption")
}

## Read if household_power_compsumption.txt hasn't been read yet.
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

##plot4
par(mfcol= c(2,2))
##plot4.1(same with plot2)
with(houseCompData ,plot(Time,Global_active_power,
                         type = "l", xlab = "", 
                         ylab = "Global Active Power(kilowatts)"))
##plot4.2
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
       col = c("black", "red", "blue"), 
       lty =1, lwd=2.5,
       bty = "n", cex= 0.8)
##plot4.3
with(houseCompData, plot(Time, Voltage,
                         type ="l", 
                         xlab = "datetime", 
                         ylab = "Voltage"))
##plot4.4
with(houseCompData, plot(Time, Global_reactive_power, 
                         type ="l",xlab = "datetime", 
                         ylab = "Global_reactive_power"))
dev.copy(png, file = "plot4.png")
dev.off()
par(mfcol = c(1,1))