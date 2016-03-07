# I will use data.table instead of data.frame, they are much faster!
library(data.table)

#Fetch the data set
power_consumption <- fread("./household_power_consumption.txt",na.strings=c("?","NA","N/A","null"))

#Change class Date column
power_consumption$Date <- as.Date(power_consumption$Date,"%d/%m/%Y")

#Obtain subset of data from 2007-02-01 to 2007-02-02
power2days <- subset(power_consumption,(Date >= as.Date("2007-02-01")) & (Date < as.Date("2007-02-03")))

#Plot the data and save it to plot1.png
png(file="figure/plot1.png")
with(power2days,hist(Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))
dev.off()


