## Read full data
dataFile <- "./data/household_power_consumption.txt"

data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

#Change date format
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

##Subset the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#remove the full data from memory
rm(data_full)

## add new column called "Datetime" which combines "Date" and "Time" columns
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## forming the plot
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", xlab="")
})

##copy the plot to a png file named plot4.png with resolution 480 x 480
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()