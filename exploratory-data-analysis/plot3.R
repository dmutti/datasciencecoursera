plot3 <- function() {
    prepare()
    first_line = read.csv(file = "./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", nrows=1)
    hhpc = read.csv(file = "./household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings="?", sep = ";", skip = 66637, nrows = 2880, col.names = tolower(gsub("_", "", names(first_line))))
    hhpc = mutate(hhpc, ts = dmy_hms(paste(date, time, sep = " "), locale = "US"))
    png("./plot3.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    plot(x = hhpc$ts, y = pmax(hhpc$submetering1, hhpc$submetering2, hhpc$submetering3), type="n", ylab = "Energy sub metering", xlab = "")
    lines(x = hhpc$ts, y = hhpc$submetering1, col = "black")
    lines(x = hhpc$ts, y = hhpc$submetering2, col = "red")
    lines(x = hhpc$ts, y = hhpc$submetering3, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), cex=.75)
    dev.off()
}

#install and load required packages
prepare <- function() {
    if (length(grep("lubridate", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("lubridate")
    }
    if (length(grep("dplyr", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("dplyr")
    }
    library(lubridate)
    library(dplyr)
}
