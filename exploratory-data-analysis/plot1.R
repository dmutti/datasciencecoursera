# this script does the following
# 1. reads the "Individual household electric power consumption Data Set" from the file [./household_power_consumption.txt]
# 2. extracts the data regarding household energy usage over a 2-day period in February, 2007 (02/01/2007 and 02/02/2007)
# 3. constructs a plot
# 4. saves it to "./plot1.png" with a width of 480 pixels and a height of 480 pixels
plot1 <- function() {
    first_line = read.csv(file = "./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", nrows=1)
    hhpc = read.csv(file = "./household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings="?", sep = ";", skip = 66637, nrows = 2880, col.names = tolower(gsub("_", "", names(first_line))))
    png("./plot1.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    hist(hhpc$globalactivepower, col = "orangered", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
}
