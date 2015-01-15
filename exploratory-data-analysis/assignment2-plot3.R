plot3 <- function() {
    setup()
    SCC <- readRDS("./Source_Classification_Code.rds")
    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")
    sum_balt <- summarize_by_fips(data, "24510")
    png("./assignment2-plot3.png", width = 480, height = 480, units = "px")
    par(bg = "transparent")
    ggplot(data=sum_balt, aes(x=year, y=emissions, group=type, colour=type)) + geom_line() + geom_point()
    dev.off()
}

setup <- function() {
    if (!exists("NEI", envir = .GlobalEnv)) {
        assign("NEI", readRDS("./summarySCC_PM25.rds"), envir = .GlobalEnv)
    }
    library(dplyr)
    library(ggplot2)
}

summarize_by_fips <- function(full_data, code){
    filtered <- filter(full_data, fips == code)
    grouped <- group_by(select(filtered, type, Emissions, year), type, year)
    result <- summarize(grouped, sum(Emissions))
    names(result) <- c("type", "year", "emissions")
    result$type <- factor(result$type)
    result$year <- factor(result$year)
    result
}