# 2. Hospital Name: varchar (50) Lists the name of the hospital.
# 7. State: varchar (2) Lists the 2 letter State code in which the hospital is located.
# 11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: Lists the risk adjusted rate (percentage) for each hospital.
# 17. Hospital 30-Day Death (Mortality) Rates from Heart Failure: Lists the risk adjusted rate (percentage) for each hospital.
# 23. Hospital 30-Day Death (Mortality) Rates from Pneumonia: Lists the risk adjusted rate (percentage) for each hospital.

rankall <- function(outcome, num = "best") {
    outcome_code <- get_outcome(outcome)
    full_dataset <- read.table("outcome-of-care-measures.csv", header=TRUE, na.strings = "Not Available", sep=",", fill=TRUE, stringsAsFactors=FALSE)
    hospital_state_value <- full_dataset[,c(2,7,outcome_code)]
    hospital_state_value <- hospital_state_value[complete.cases(hospital_state_value),]
    names(hospital_state_value) <- c("hospital","state","value")
    state_data <- split(hospital_state_value, hospital_state_value$state)
    result <- lapply(names(state_data), get_hospital, state_data, num)
    do.call(rbind, result)
}

get_outcome <- function(outcome) {
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    codes <- c(11,17,23)
    if (!outcome %in% outcomes) {
        stop("invalid outcome")
    }
    codes[match(outcome, outcomes)]
}

get_hospital <- function(name_state, all_state_data, num) {
    state_data <- all_state_data[[name_state]]
    ordered <- state_data[order(state_data$value, state_data$hospital),]
    if (num == "best") {
        ordered[1,1:2]
    } else if (num == "worst") {
        ordered[nrow(ordered),1:2]
    } else if (!is.numeric(num)) {
        empty_data_frame(name_state)
    } else {
        num <- as.numeric(num)
        if (num > nrow(ordered) || num < 1) {
            empty_data_frame(name_state)
        } else {
            ordered[num,1:2]
        }
    }
}

empty_data_frame <- function(name_state) {
    data.frame("hospital" = "<NA>", "state"=name_state)
}
