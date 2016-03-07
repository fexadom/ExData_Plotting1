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

#Plot the data and save it to plot4.png
png(file="figure/plot4.png")
par(mfrow = c(2, 2))
with(power2days,plot(Timestamp,Global_active_power,type = "n",xlab="",ylab="Global Active Power"))
with(power2days,lines(Timestamp,Global_active_power))
with(power2days,plot(Timestamp,Voltage,type = "n",xlab="datetime",ylab="Voltage"))
with(power2days,lines(Timestamp,Voltage))
with(power2days,plot(Timestamp,Sub_metering_1,type = "n",xlab="",ylab="Energy sub metering"))
with(power2days,lines(Timestamp,Sub_metering_1))
with(power2days,lines(Timestamp,Sub_metering_2,col = "red"))
with(power2days,lines(Timestamp,Sub_metering_3,col = "blue"))
legend("topright", lwd = 1,col = c("black","red", "blue"), bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(power2days,plot(Timestamp,Global_reactive_power,type = "n",xlab="datetime",ylab="Global_reactive_power"))
with(power2days,lines(Timestamp,Global_reactive_power))
dev.off()