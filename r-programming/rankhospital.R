# 2. Hospital Name: varchar (50) Lists the name of the hospital.
# 7. State: varchar (2) Lists the 2 letter State code in which the hospital is located.
# 11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: Lists the risk adjusted rate (percentage) for each hospital.
# 17. Hospital 30-Day Death (Mortality) Rates from Heart Failure: Lists the risk adjusted rate (percentage) for each hospital.
# 23. Hospital 30-Day Death (Mortality) Rates from Pneumonia: Lists the risk adjusted rate (percentage) for each hospital.

rankhospital <- function(state, outcome, num = "best") {
    check_state(state)
    outcome_code <- get_outcome(outcome)

    full_dataset <- read.table("outcome-of-care-measures.csv", header=TRUE, na.strings = "Not Available", sep=",", fill=TRUE, stringsAsFactors=FALSE)
    hospital_state_value <- full_dataset[,c(2,7,outcome_code)]
    hospital_state_value <- hospital_state_value[complete.cases(hospital_state_value),]
    names(hospital_state_value) <- c("Hospital","State","Value")
    state_data <- split(hospital_state_value, hospital_state_value$State)[[state]]
    hospitals <- state_data[order(state_data$Value, state_data$Hospital),][[1]]
    get_hospital(hospitals, num)
}

check_state <- function(state) {
    states <- c("AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV", "NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY","GU")
    if (!state %in% states) {
        stop("invalid state")
    }
}

get_outcome <- function(outcome) {
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    codes <- c(11,17,23)
    if (!outcome %in% outcomes) {
        stop("invalid outcome")
    }
    codes[match(outcome, outcomes)]
}

get_hospital <- function(hospitals, num) {
    if (num == "best") {
        hospitals[1]
    } else if (num == "worst") {
        hospitals[length(hospitals)]
    } else if (!is.numeric(num)) {
        NA
    } else {
        num <- as.numeric(num)
        if (num > length(hospitals) || num < 1) {
            NA
        } else {
            hospitals[num]
        }
    }
}
