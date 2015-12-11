# Read in the data
df <- read.csv('household_power_consumption.txt', sep=';', header=TRUE)
# Convert missing values
df[df=='?'] <- NA
# Convert Date column from factor to Date type
df$Date <- as.Date(df$Date, "%d/%m/%Y")
# Subset to the dates of interest
df.sub <- df[df$Date == as.Date('2007-02-01') | df$Date == as.Date('2007-02-02'),]
# Convert Global_active_power factor to numeric
df.sub$Global_active_power <- as.numeric(as.character(df.sub$Global_active_power))
# Convert Global_reactive_power factor to numeric
df.sub$Global_reactive_power <- as.numeric(as.character(df.sub$Global_reactive_power))
# Convert Voltage factor to numeric
df.sub$Voltage <- as.numeric(as.character(df.sub$Voltage))
# Convert Sub_metering factors to numeric
df.sub$Sub_metering_1 <- as.numeric(as.character(df.sub$Sub_metering_1))
df.sub$Sub_metering_2 <- as.numeric(as.character(df.sub$Sub_metering_2))
df.sub$Sub_metering_3 <- as.numeric(as.character(df.sub$Sub_metering_3))

# Write to a PNG file
png(filename = 'plot4.png')
# Set 2x2 plot layout
par(mfrow=c(2,2))
# Get combined date/time
df.sub$DateTime <- as.POSIXct(paste(df.sub$Date, df.sub$Time), format="%Y-%m-%d %H:%M:%S")
# Global active power graph
plot(df.sub$DateTime, df.sub$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)')
# Voltage graph
plot(df.sub$DateTime, df.sub$Voltage, type='l', xlab='datetime', ylab='Voltage')
# Sub-metering graph
plot(df.sub$DateTime, df.sub$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(df.sub$DateTime, df.sub$Sub_metering_2, type='l', xlab='', ylab='', col='red')
lines(df.sub$DateTime, df.sub$Sub_metering_3, type='l', xlab='', ylab='', col='blue')
# Add the legend
legend("topright", lty=1, legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'))
# Global reactive power graph
plot(df.sub$DateTime, df.sub$Global_reactive_power, type='l', xlab='datetime', ylab='Global Reactive Power (kw)')
# Save the PNG file
dev.off()
