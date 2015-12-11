# Set 1x1 plot layout
par(mfrow=c(1,1))
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

# Get combined date/time
df.sub$DateTime <- as.POSIXct(paste(df.sub$Date, df.sub$Time), format="%Y-%m-%d %H:%M:%S")
# Do the line graph
plot(df.sub$DateTime, df.sub$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)')
# Save it as a PNG file
dev.copy(png, 'plot2.png')
dev.off()
