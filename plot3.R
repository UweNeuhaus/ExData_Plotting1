# This script creates a plot of the three different energy sub-meterings
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

# Combine Date and Time and convert into Posix format
alldata$Date <- strptime(paste(alldata$Date, alldata$Time, sep=" "), 
                         format="%d/%m/%Y %H:%M:%S")

# Build the subset for the dates of interest
start <- strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S")
end <- strptime("2007-02-02 23:59:59", format="%Y-%m-%d %H:%M:%S")
data <- subset(alldata, Date >= start & Date <= end)

# Set English locale, so desired names of weekdays are displayed
Sys.setlocale("LC_TIME", "en_GB.utf8")

# Create png-Device, draw plot without data, add lines for submeterings,
# add legend, and close png-Device
png(file="plot3.png")
with(data, plot(c(Date, Date, Date), 
     c(Sub_metering_1, Sub_metering_2, Sub_metering_3), 
     xlab="", ylab="Energy sub metering", type="n"))
with(data, lines(Date, Sub_metering_1, col="black"))
with(data, lines(Date, Sub_metering_2, col="red"))
with(data, lines(Date, Sub_metering_3, col="blue"))
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()