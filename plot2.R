# Declare libraries used
if(!require(data.table))
        install.packages("data.table")

if(!require(lubridate))
        install.packages("lubridate")

require(data.table)
require(lubridate)

# Download the data file if it doesn't already exist
if(!file.exists("exdata-data-household_power_consumption.zip"))
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      "exdata-data-household_power_consumption.zip")

# Unzip the data file if it doesn't already exist
if(!file.exists("./data/household_power_consumption.txt"))
        unzip("exdata-data-household_power_consumption.zip", 
              "household_power_consumption.txt",
              exdir="./data")

filename <- "./data/household_power_consumption.txt"

# Grab the column names from the file
colnames <- colnames(read.table(filename, sep=";", header=TRUE, nrow=2))

# Read in only the rows from the dates 1/2/2007 and 2/2/2007
datafile <- file(filename, "r")
data <- read.table(text=grep("^[12]/2/2007", readLines(datafile), value=TRUE), 
                   sep=";", 
                   col.names=colnames, 
                   stringsAsFactors=FALSE)
close(datafile)

# Merge Data and Time fields and create a Timestamp field
data$datetime <- dmy_hms(paste(data$Date, data$Time))

# Set up the PNG graphic device, setting size and transparent background
plotfile <- png("plot2.png", 
                width=480, height=480, units="px", 
                bg="transparent")

# Plot the Global Active Power vs datetime
with(data, {
        plot(datetime, Global_active_power,
             type="l",
             xlab="", ylab="Global Active Power (kilowatts)")
})

# Close the graphic device to allow it to write to disk
dev.off()


