# Read the input file into a dataframe:
hpc <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", 
                  skip=66636, nrows=2880, stringsAsFactors=FALSE, 
                  col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                  colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# Build a vector containing the timestamp of Date and Time fields and add it to the dataframe:
timestamp <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
hpc <- cbind(timestamp, hpc)

# Set language to English for x-axis label:
Sys.setlocale("LC_ALL", "English")

# Prepare for 4 plots in the same slide:
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

with(hpc, {
     # Draw the first plot:
     plot(timestamp, Global_active_power, type="l", ylab="Global Active Power", xlab="")
     # Draw the second plot:
     plot(timestamp, Voltage, type="l", ylab="Voltage", xlab="datetime")
     # Draw the third plot:     
     plot(timestamp, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
     lines(timestamp, Sub_metering_2, type="l", col="red")
     lines(timestamp, Sub_metering_3, type="l", col="blue")
     legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", cex=0.4)
     # Draw the fourth plot:      
     plot(timestamp, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})

# Copy my plot to a PNG file:
dev.copy(png, file = "plot4.png", width = 480, height = 480) 
# Close the PNG device:
dev.off()
