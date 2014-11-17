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

#pollutantmean <- function(directory, pollutant, id = 1:332) {
#    file_list <- list.files(path=directory, pattern="*.csv", full.names = TRUE)
#    split_tables <- lapply(file_list, read.csv)
#    data <- do.call(rbind, split_tables)
#    fullPollutantData <- data[pollutant][id]
#    cleanPollutantData <- fullPollutantData[!is.na(fullPollutantData)]
#    mean(cleanPollutantData)
#}
