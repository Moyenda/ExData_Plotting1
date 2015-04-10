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

# Make graph.
plot(x = febPower$DT, y = febPower$Global_active_power, type = 'l', ylab = 
             'Global Active Power (kilowatts)', xlab = '')

#Copy to PNG file.
dev.copy(png, file = 'plot2.png')
dev.off()