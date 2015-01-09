plot1 <- function() {
    first_line = read.csv(file = "./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", nrows=1)
    hhpc = read.csv(file = "./household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings="?", sep = ";", skip = 66637, nrows = 2880, col.names = tolower(gsub("_", "", names(first_line))))
    png("./plot1.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    hist(hhpc$globalactivepower, col = "orangered", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
}
