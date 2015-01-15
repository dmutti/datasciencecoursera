# this script does the following
# 1. reads the "Individual household electric power consumption Data Set" from the file [./household_power_consumption.txt]
# 2. extracts the data regarding household energy usage over a 2-day period in February, 2007 (02/01/2007 and 02/02/2007)
# 3. constructs a plot
# 4. saves it to "./plot4.png" with a width of 480 pixels and a height of 480 pixels
plot4 <- function() {
    set_up()
    first_line = read.csv(file = "./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", nrows=1)
    hhpc = read.csv(file = "./household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings="?", sep = ";", skip = 66637, nrows = 2880, col.names = tolower(gsub("_", "", names(first_line))))
    hhpc = mutate(hhpc, ts = dmy_hms(paste(date, time, sep = " "), locale = "US"))
    png("./plot4.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    par(mfrow=c(2,2))
    plot41(hhpc)
    plot42(hhpc)
    plot43(hhpc)
    plot44(hhpc)
    dev.off()
}

plot41 <- function(hhpc) {
    plot(hhpc$globalactivepower ~ hhpc$ts, type = "l", ylab = "Global Active Power", xlab = "")
}

plot42 <- function(hhpc) {
    plot(hhpc$voltage ~ hhpc$ts, type = "l", ylab = "Voltage", xlab = "datetime")
}

plot43 <- function(hhpc) {
    plot(x = hhpc$ts, y = pmax(hhpc$submetering1, hhpc$submetering2, hhpc$submetering3), type="n", ylab = "Energy sub metering", xlab = "")
    lines(x = hhpc$ts, y = hhpc$submetering1, col = "black")
    lines(x = hhpc$ts, y = hhpc$submetering2, col = "red")
    lines(x = hhpc$ts, y = hhpc$submetering3, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), cex=.75)
}

plot44 <- function(hhpc) {
    plot(hhpc$globalreactivepower ~ hhpc$ts, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
}

set_up <- function() {
    Sys.setlocale("LC_TIME", "English")
    library(lubridate)
    library(dplyr)
}
