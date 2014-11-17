corr <- function(directory, threshold = 0) {
    v_corr <- numeric(0)
    files <- length(list.files(path=directory, pattern="*.csv"))
    for (i in 1:files) {
        name <- paste(formatC(i, width = 3, flag = "0"), ".csv", sep="")
        file_data <- read.csv(paste(directory, "/", name, sep = ""))
        file_data <- file_data[complete.cases(file_data),]
        if (nrow(file_data) >= threshold) {
            v_corr <- c(v_corr, cor(file_data$nitrate, file_data$sulfate))
        }
    }
    v_corr
}
