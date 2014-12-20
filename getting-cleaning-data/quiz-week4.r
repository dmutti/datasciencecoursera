quiz_4_question_1 <- function() {
    if (!file.exists("./q4q1.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="./q4q1.csv", method="curl")
    }
    data=read.csv("./q4q1.csv")
    strsplit(names(data), "wgtp")[[123]]
}

quiz_4_question_2 <- function() {
    if (!file.exists("./q4q2.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q4q2.csv", method="curl")
    }
    data=read.csv("./q4q2.csv", skip=4, quote="\"", col.names=c("id", "ranking", "skip1", "country", "gdp","skip2","skip3","skip4","skip5","skip6"))
    data=data[1:190,]
    data$gdp=as.numeric(gsub(",","", data$gdp))
    mean(data$gdp)
}

quiz_4_question_3 <- function() {
    if (!file.exists("./q4q3.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q4q3.csv", method="curl")
    }
    data=read.csv("./q4q3.csv", skip=4, quote="\"", col.names=c("id", "ranking", "skip1", "country", "gdp","skip2","skip3","skip4","skip5","skip6"))
    data=data[1:190,]
    grep("^United", data$country, value=TRUE)
}

quiz_4_question_4 <- function() {
    if (!file.exists("./q4q4p1.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="./q4q4p1.csv", method="curl")
    }
    if (!file.exists("./q4q4p2.csv")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="./q4q4p2.csv", method="curl")
    }
    gdp=read.csv("./q4q3.csv", skip=4, quote="\"", col.names=c("id", "ranking", "skip1", "country", "gdp","skip2","skip3","skip4","skip5","skip6"), stringsAsFactors=FALSE)
    gdp=gdp[1:190,]
    gdp$gdp=as.numeric(gsub(",","", gdp$gdp))
    country = read.csv("./q4q4p2.csv", stringsAsFactors=FALSE)
    merged = merge(gdp, country, by.x="id", by.y="CountryCode")
    grep("Fiscal year end: June", merged$Special.Notes, value=TRUE)
}

quiz_4_question_5 <- function() {
    if (length(grep("quantmod", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("quantmod")
    }
    library(quantmod)
    if (length(grep("lubridate", installed.packages(), fixed=TRUE)) == 0) {
        install.packages("lubridate")
    }
    library(lubridate)
    amzn = getSymbols("AMZN",auto.assign=FALSE)
    sampleTimes = index(amzn)
    dates = ymd(sampleTimes)
    print(paste("in 2012:", sum(year(dates) == 2012)))
    print(paste("in 2012 and on mondays:", sum(year(dates) == 2012 & wday(dates) == 2)))
}
