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

quiz_3_question_3 <- function() {
    if (!file.exists("./q3q3p1.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q3q3p1.csv", method="curl")
    }
    if (!file.exists("./q3q3p2.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./q3q3p2.csv", method="curl")
    }
    gdp = read.csv("./q3q3p1.csv")
    gdp$GDP = as.numeric(gsub(",","", gdp$GDP))
    country = read.csv("./q3q3p2.csv")

    merged = merge(gdp, country, by.x="CountryCode", by.y="CountryCode")
    ordered = merged[order(merged$GDP),]
    print(paste(length(merged$CountryCode), ordered[13,3], sep = " "))
}

quiz_3_question_4 <- function() {
    if (!file.exists("./q3q3p1.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q3q3p1.csv", method="curl")
    }
    if (!file.exists("./q3q3p2.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./q3q3p2.csv", method="curl")
    }
    gdp = read.csv("./q3q3p1.csv")
    gdp$GDP = as.numeric(gsub(",","", gdp$GDP))
    country = read.csv("./q3q3p2.csv")

    merged = merge(gdp, country, by.x="CountryCode", by.y="CountryCode")
    ordered = merged[order(merged$GDP),]

    oecd = mean(ordered$Ranking[ordered$Income.Group == "High income: OECD"])
    non_oecd = mean(ordered$Ranking[ordered$Income.Group == "High income: nonOECD"])
    print(paste(oecd, non_oecd, sep=", "))
}

quiz_3_question_5 <- function() {
    if (!file.exists("./q3q3p1.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q3q3p1.csv", method="curl")
    }
    if (!file.exists("./q3q3p2.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./q3q3p2.csv", method="curl")
    }
    gdp = read.csv("./q3q3p1.csv")
    gdp$GDP = as.numeric(gsub(",","", gdp$GDP))
    country = read.csv("./q3q3p2.csv")

    merged = merge(gdp, country, by.x="CountryCode", by.y="CountryCode")
    ordered = merged[order(merged$GDP),]

    print(sum(ordered$Ranking[ordered$Income.Group == "Lower middle income"] <= 38))
}
