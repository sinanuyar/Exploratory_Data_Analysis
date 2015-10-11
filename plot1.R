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

##forming the plot label for x-axis, bar color and Main title defined.
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

##copy the plot to a png file named plot1.png with resolution 480 x 480
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()