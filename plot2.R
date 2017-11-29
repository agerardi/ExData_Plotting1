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

# Draw the plot:
plot(hpc$timestamp,
     hpc$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab=""
)

# Copy my plot to a PNG file:
dev.copy(png, file = "plot2.png", width = 480, height = 480) 
# Close the PNG device:
dev.off()
