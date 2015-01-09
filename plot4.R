# read the dataset
data <- read.csv("household_power_consumption.txt", sep=";", 
								 colClasses="character", header=TRUE)
# merge Date and Time columns to one column named DateTime in the POSIXlt format
data <- transform(data, Time=paste(Date, Time))
data <- transform(data, Time=strptime(Time, format="%d/%m/%Y %H:%M:%S"))
data <- data[,2:9]
colnames(data)[2]  <- "DateTime"


# filter the dataset according to the desired time period
data <- subset(data, as.Date(data$Time) >= as.Date("2007-02-01") & 
							 as.Date(data$Time) <= as.Date("2007-02-02"))

#plot data
par(mfrow=c(2,2))

with(data, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))

with(data, plot(Time, Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(data, {
	plot(Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
	lines(Time, Sub_metering_1)
	lines(Time, Sub_metering_2, col="red")
	lines(Time, Sub_metering_3, col="blue")
})
legend("topright", col=c("black", "red", "blue"), bty="n", lty=c(1,1,1),
			 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(data, plot(Time, Global_reactive_power, type="l", xlab="datetime"))

# save png file
dev.copy(png, file="plot4.png")
dev.off()

