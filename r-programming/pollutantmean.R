pollutantmean <- function(directory, pollutant, id = 1:332) {
    names <- character(length=length(id))
    all_data <- numeric(0)
    for (i in 1:length(id)) {
        name <- paste(formatC(id[i], width = 3, flag = "0"), ".csv", sep="")
        file_data <- read.csv(paste(directory, "/", name, sep = ""))
        pollutant_data <- file_data[[pollutant]]
        pollutant_data <- pollutant_data[!is.na(pollutant_data)]
        all_data <- c(all_data, pollutant_data)
    }
    mean(all_data)
}
