# This script creates a two by two matrix of base plot of the energy data
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

# Create png-Device, specify number and arangement of base plots, draw
# the four base plots, and close png-Device
png(file="plot4.png")

# Display four base plots in two columns with two plots each
par(mfcol=c(2,2))

# Firt base plot (top left): Global Active Power
with(data, plot(Date, Global_active_power, xlab="", 
                ylab="Global Active Power", type="n"))
with(data, lines(Date, Global_active_power))

# Second base plot (bottom left): Sub meterings:
with(data, plot(c(Date, Date, Date), 
     c(Sub_metering_1, Sub_metering_2, Sub_metering_3), 
     xlab="", ylab="Energy sub metering", type="n"))
with(data, lines(Date, Sub_metering_1, col="black"))
with(data, lines(Date, Sub_metering_2, col="red"))
with(data, lines(Date, Sub_metering_3, col="blue"))
legend("topright", lwd=1, bty="n", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Third base plot (top right): Voltage
with(data, plot(Date, Voltage, xlab="datetime", 
                ylab="Voltage", type="n"))
with(data, lines(Date, Voltage))

# Forth base plot (bottom right): Global Reactive Power
with(data, plot(Date, Global_reactive_power, xlab="datetime", type="n"))
with(data, lines(Date, Global_reactive_power))

# Close device
dev.off()