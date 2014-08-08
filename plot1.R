# This script creates a histogram of the global active power consumption
# from February 1st to February 2nd 2007

# Read the textfile, convert missing values and define column type 
# for numeric columns. The Date and Time column will have to be dealt
# with separately outside of read.table.
alldata <- read.table(file="./household_power_consumption.txt", 
                   header = TRUE, sep=";", 
                   na.strings="?", 
                   colClasses = c("character", "character", "numeric", 
                                  "numeric", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric"))

# Convert Date and Time column into apropiate format 
alldata$Date <- as.Date(alldata$Date, format="%d/%m/%Y")
alldata$Time <- strptime(alldata$Time, format="%H:%M:%S")

# Build the subset for the dates of interest
start <- as.Date("2007-02-01")
end <- as.Date("2007-02-02")
data <- subset(alldata, Date >= start & Date <= end)

# Create png-Device, draw histogram, and close png-Device
png(file="plot1.png")
hist(data$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")
dev.off()