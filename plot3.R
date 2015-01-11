file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip.file.name  <- "household_power_consumption.zip"
file.name <- "household_power_consumption.txt"

if (!file.exists(file.name))
{
	# download the dataset
	download.file(file.url, destfile=zip.file.name, method="curl")

	#unzip the dataset
	unzip(zip.file.name)
}
# read the dataset
data <- read.csv(file.name, sep=";", 
								 colClasses="character", header=TRUE)


# merge Date and Time columns to one column named DateTime in the POSIXlt format
data <- transform(data, Time=paste(Date, Time))
data <- transform(data, Time=strptime(Time, format="%d/%m/%Y %H:%M:%S"))
data <- data[,2:9]
colnames(data)[1]  <- "DateTime"


# filter the dataset according to the desired time period
data <- subset(data, as.Date(data$DateTime) >= as.Date("2007-02-01") & 
							 as.Date(data$DateTime) <= as.Date("2007-02-02"))

#plot time series
with(data, {
	plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
	lines(DateTime, Sub_metering_1)
	lines(DateTime, Sub_metering_2, col="red")
	lines(DateTime, Sub_metering_3, col="blue")
})
legend("topright", col=c("black", "red", "blue"),  lty=c(1,1,1),
			 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# save png file
dev.copy(png, file="plot3.png")
dev.off()

