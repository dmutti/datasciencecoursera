#http://www.cookbook-r.com/Graphs/Bar_and_line_graphs_(ggplot2)/
#http://www.cookbook-r.com/Graphs/Output_to_a_file/
plot3 <- function() {
    setup()
    SCC <- readRDS("./Source_Classification_Code.rds")
    data <- merge(SCC, NEI, by.x="SCC", by.y="SCC")
    sum_balt <- summarize_by_fips(data, "24510")

    png("./assignment2-plot3.png", width = 480, height = 480, units = "px")
    print(ggplot(data=sum_balt, aes(x=year, y=emissions, group=type, colour=type)) + geom_line() + geom_point() + xlab("Year") + ylab("Total PM2.5 Emissions (tons)") + ggtitle("Baltimore, Maryland") + scale_colour_hue(name="Source"))
    #qplot(year, emissions, data = sum_balt, color = type)
    #qplot(year, emissions, data = sum_balt, facets = .~type, color = type) #facets: lhs=rows, rhs=columns, "." there is only one row
    #qplot(year, emissions, data = sum_balt, shape = type, color = type)
    dev.off
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
    result
}