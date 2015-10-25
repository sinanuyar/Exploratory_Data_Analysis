## Read full data
dataFile <- "./data/household_power_consumption.txt"

data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

##Change date format
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

##Subset the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##remove the full data from memory
rm(data_full)

## add new column called "Datetime" which combines "Date" and "Time" columns
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## forming the plot. type = 1 is for having continuous line instead of dots. y-axis label defined.
### Other dimensions are added one-by-one
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

##add legend
legend("topright", col=c("black", "red", "blue"), lty=1,  
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##copy the plot to a png file named plot3.png with resolution 480 x 480
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()