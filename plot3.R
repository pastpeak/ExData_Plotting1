# Read in the data
df <- read.csv('household_power_consumption.txt', sep=';', header=TRUE)
# Convert missing values
df[df=='?'] <- NA
# Convert Date column from factor to Date type
df$Date <- as.Date(df$Date, "%d/%m/%Y")
# Subset to the dates of interest
df.sub <- df[df$Date == as.Date('2007-02-01') | df$Date == as.Date('2007-02-02'),]
# Convert Sub_metering factors to numeric
df.sub$Sub_metering_1 <- as.numeric(as.character(df.sub$Sub_metering_1))
df.sub$Sub_metering_2 <- as.numeric(as.character(df.sub$Sub_metering_2))
df.sub$Sub_metering_3 <- as.numeric(as.character(df.sub$Sub_metering_3))

# Write to a PNG file
png(filename = 'plot3.png')
# Set 1x1 plot layout
par(mfrow=c(1,1))
# Get combined date/time
df.sub$DateTime <- as.POSIXct(paste(df.sub$Date, df.sub$Time), format="%Y-%m-%d %H:%M:%S")
# Do the plot
plot(df.sub$DateTime, df.sub$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(df.sub$DateTime, df.sub$Sub_metering_2, type='l', xlab='', ylab='', col='red')
lines(df.sub$DateTime, df.sub$Sub_metering_3, type='l', xlab='', ylab='', col='blue')
# Add the legend
legend("topright", lty=1, legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'))
# Save the PNG file
dev.off()
