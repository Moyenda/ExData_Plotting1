# Read data set into R and format appropriately.
powerCon <- read.table('household_power_consumption.txt', header = TRUE, 
                       sep = ';', na.strings = '?')
powerCon$Date <- as.Date(powerCon$Date, format = '%d/%m/%Y')
powerCon$Time <- strptime(powerCon$Time, format = '%H:%M:%S')
powerCon$Time <- strftime(powerCon$Time, format = '%H:%M:%S')

# Subset relevant data for analysis. 
febPower <- powerCon[ which(powerCon$Date == '2007-2-1' | 
                                    powerCon$Date == '2007-2-2'),]

#Initialise text shrinking parameter.
par(cex = 0.8)

# Create column with time formated as required for graph.
febPower$DT <- as.POSIXlt(paste(febPower$Date, febPower$Time), 
                          format = '%Y-%m-%d %H:%M:%S')

#Make plot.
plot(x = febPower$DT, y = febPower$Sub_metering_1, type = 'l', ylab = 
             'Energy sub metering', xlab = '')
lines(x = febPower$DT, y = febPower$Sub_metering_2, type = 'l', col = 'red')
lines(x = febPower$DT, y = febPower$Sub_metering_3, type = 'l', col = 'blue')
legend(x = 'topright', legend = c('Sub_metering_1', 'Sub_metering_2', 
                'Sub_metering_3'), col = c('black', 'red', 'blue'), lwd = 1)

#Copy to PNG file.
dev.copy(png, file = 'plot3.png')
dev.off()