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

#plot the histogram
with(data, hist(as.numeric(Global_active_power), col="red", 
		xlab="Global Active Power (kilowatts)", main="Global Active Power"))

# save png file
dev.copy(png, file="plot1.png")
dev.off()

