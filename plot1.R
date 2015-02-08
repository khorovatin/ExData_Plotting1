# Declare libraries used
if(!require(data.table))
        install.packages("data.table")

require(data.table)

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

# Set up the PNG graphic device, setting size and transparent background
plotfile <- png("plot1.png", 
                width=480, height=480, units="px", 
                bg="transparent")

# Plot the histogram of Global Active Power
hist(data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     col="red")

# Close the graphic device to allow it to write to disk
dev.off()

