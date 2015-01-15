plot4 <- function() {
    setup()
    SCC <- readRDS("./Source_Classification_Code.rds")
    SCC <- mutate(SCC, coal = grepl("coal", tolower(as.character(Short.Name)), ignore.case = TRUE))

    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")

    filtered <- filter(data, coal == TRUE)
    by_year <- group_by(select(filtered, Emissions, year), year)

    png("./assignment2-plot4.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    options("scipen" = 20)
    plot(summarize(by_year, sum(Emissions)), ylab = "Total Emissions From Coal Combustion-Related Sources (tons)", xlab = "Year", type = "l", col="red", main = "United States")
    dev.off()
}

setup <- function() {
    if (!exists("NEI", envir = .GlobalEnv)) {
        assign("NEI", readRDS("./summarySCC_PM25.rds"), envir = .GlobalEnv)
    }
    library(dplyr)
}