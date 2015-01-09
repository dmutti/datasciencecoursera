plot2 <- function() {
    set_up()
    first_line = read.csv(file = "./household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";", nrows=1)
    hhpc = read.csv(file = "./household_power_consumption.txt", header = FALSE, stringsAsFactors = FALSE, na.strings="?", sep = ";", skip = 66637, nrows = 2880, col.names = tolower(gsub("_", "", names(first_line))))
    hhpc = mutate(hhpc, ts = dmy_hms(paste(date, time, sep = " "), locale = "US"))
    png("./plot2.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    plot(hhpc$globalactivepower ~ hhpc$ts, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    dev.off()
}

set_up <- function() {
    Sys.setlocale("LC_TIME", "English")
    if (length(grep("lubridate", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("lubridate")
    }
    if (length(grep("dplyr", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("dplyr")
    }
    library(lubridate)
    library(dplyr)
}
