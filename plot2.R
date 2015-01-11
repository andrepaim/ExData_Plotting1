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
with(data, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# save png file
dev.copy(png, file="plot2.png")
dev.off()

