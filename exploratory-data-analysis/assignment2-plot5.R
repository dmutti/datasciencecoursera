plot5 <- function() {
    setup()
    SCC <- readRDS("./Source_Classification_Code.rds")
    SCC <- mutate(SCC, motorvehicle = grepl("vehicle", tolower(as.character(EI.Sector)), ignore.case = TRUE))

    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")

    filtered <- filter(data, motorvehicle == TRUE & fips == "24510")
    by_year <- group_by(select(filtered, Emissions, year), year)

    png("./assignment2-plot5.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    options("scipen" = 20)
    plot(summarize(by_year, sum(Emissions)), ylab = "Total Emissions from Motor Vehicle Sources (tons)", xlab = "Year", type = "l", col="red", main = "Baltimore City, Maryland")
    dev.off()
}

setup <- function() {
    if (!exists("NEI", envir = .GlobalEnv)) {
        assign("NEI", readRDS("./summarySCC_PM25.rds"), envir = .GlobalEnv)
    }
    library(dplyr)
}