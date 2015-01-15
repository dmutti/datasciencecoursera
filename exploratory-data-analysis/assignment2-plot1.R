plot1 <- function() {
    setup()
    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")
    by_year <- group_by(select(data, Emissions, year), year)
    png("./assignment2-plot1.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    options("scipen" = 20)
    plot(summarize(by_year, sum(Emissions)), ylab = "Total PM2.5 Emission (tons)", xlab = "Year", type = "l", col="red")
    dev.off()
}

setup <- function() {
    if (!exists("SCC", envir = .GlobalEnv)) {
        assign("SCC", readRDS("./Source_Classification_Code.rds"), envir = .GlobalEnv)
    }
    if (!exists("NEI", envir = .GlobalEnv)) {
        assign("NEI", readRDS("./summarySCC_PM25.rds"), envir = .GlobalEnv)
    }
    if (!exists("data", envir = .GlobalEnv)) {
        data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")
        assign("data", data, envir = .GlobalEnv)
    }
    library(dplyr)
}