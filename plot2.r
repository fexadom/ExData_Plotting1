# I will use data.table instead of data.frame, they are much faster!
library(data.table)

#Fetch the data set
power_consumption <- fread("./household_power_consumption.txt",na.strings=c("?","NA","N/A","null"))

#Change class Date column
power_consumption$Date <- as.Date(power_consumption$Date,"%d/%m/%Y")

#Obtain subset of data from 2007-02-01 to 2007-02-02
power2days <- subset(power_consumption,(Date >= as.Date("2007-02-01")) & (Date < as.Date("2007-02-03")))

#Create timestamp column with the exact date and time of each measurement
power2days$Timestamp <- paste(power2days$Date,power2days$Time)
power2days$Timestamp <- as.POSIXct(power2days$Timestamp,"%Y-%m-%d %H:%M:%S")

#Plot the data and save it to plot2.png
png(file="figure/plot2.png")
with(power2days,plot(Timestamp,Global_active_power,type = "n",xlab="",ylab="Global Active Power (kilowatts)"))
with(power2days,lines(Timestamp,Global_active_power))
dev.off()