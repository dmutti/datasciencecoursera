plot6 <- function() {
    setup()
    SCC <- readRDS("./Source_Classification_Code.rds")
    SCC <- mutate(SCC, motorvehicle = grepl("vehicle", tolower(as.character(EI.Sector)), ignore.case = TRUE))

    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")

    sum_motor_balt <- summarize_by_fips(data, "24510")
    sum_motor_lac <- summarize_by_fips(data, "06037")

    png("./assignment2-plot6.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    options("scipen" = 20)
    plot(x = c(sum_motor_balt[[1]], sum_motor_lac[[1]]), y = (c(sum_motor_balt[[2]], sum_motor_lac[[2]]) * 1.1), ylab = "Total Emissions from Motor Vehicle Sources (tons)", xlab = "Year", type = "n", main = "Baltimore City x Los Angeles County")
    lines(sum_motor_balt, col = "blue")
    lines(sum_motor_lac, col = "red")
    legend("topright", c("Los Angeles County", "Baltimore City"), lty=1, col=c("red", "blue"), cex=.75)
    dev.off()
}

setup <- function() {
    if (!exists("NEI", envir = .GlobalEnv)) {
        assign("NEI", readRDS("./summarySCC_PM25.rds"), envir = .GlobalEnv)
    }
    library(dplyr)
}

summarize_by_fips <- function(full_data, code){
    filtered <- filter(full_data, motorvehicle == TRUE & fips == code)
    grouped <- group_by(select(filtered, Emissions, year), year)
    summarize(grouped, sum(Emissions))
}