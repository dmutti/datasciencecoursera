complete <- function(directory, id = 1:332) {
    names <- character(length=length(id))
    ids <- numeric(0)
    nobs <- numeric(0)
    for (i in 1:length(id)) {
        name <- paste(formatC(id[i], width = 3, flag = "0"), ".csv", sep="")
        file_data <- read.csv(paste(directory, "/", name, sep = ""))
        nobs <- c(nobs, nrow(file_data[complete.cases(file_data),]))
        ids <- c(ids, id[i])
    }
    data.frame(ids, nobs)
}
