quiz_3_question_1 <- function() {
    if (!file.exists("./q3q1.csv")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./q3q1.csv", method="curl")
    }
    data = read.csv("./q3q1.csv")
    agricultureLogical = data$ACR == 3 & data$AGS == 6
    which(agricultureLogical)
}

quiz_3_question_2 <- function() {
    if (length(grep("jpeg", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("jpeg")
    }
    library(jpeg)
    if (!file.exists("./q3q2.jpg")) {
        download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "./q3q2.jpg", method="curl")
    }
    jpeg = readJPEG("./q3q2.jpg", native = TRUE)
    quantile(jpeg, probs = c(.3, .8))
}
