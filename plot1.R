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


##plot1 
hist(houseCompData$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power(kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()





