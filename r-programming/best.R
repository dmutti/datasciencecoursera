# 2. Hospital Name: varchar (50) Lists the name of the hospital.
# 7. State: varchar (2) Lists the 2 letter State code in which the hospital is located.
# 11. Hospital 30-Day Death (Mortality) Rates from Heart Attack: Lists the risk adjusted rate (percentage) for each hospital.
# 17. Hospital 30-Day Death (Mortality) Rates from Heart Failure: Lists the risk adjusted rate (percentage) for each hospital.
# 23. Hospital 30-Day Death (Mortality) Rates from Pneumonia: Lists the risk adjusted rate (percentage) for each hospital.

best <- function(state, outcome) {
    states <- c("AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV", "NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","PR","RI","SC","SD","TN","TX","UT","VT","VI","VA","WA","WV","WI","WY","GU")
    if (!state %in% states) {
        stop("invalid state")
    }
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!outcome %in% outcomes) {
        stop("invalid outcome")
    }
    full_dataset <- read.table("outcome-of-care-measures.csv", header=TRUE, na.strings = "Not Available", sep=",", fill=TRUE)
    hospital_state_value <- data.frame()
    if (outcome == "heart attack") {
        hospital_state_value <- full_dataset[,c(2,7,11)]
    } else if (outcome == "heart failure") {
        hospital_state_value <- full_dataset[,c(2,7,17)]
    } else if (outcome == "pneumonia") {
        hospital_state_value <- full_dataset[,c(2,7,23)]
    }
    names(hospital_state_value) <- c("Hospital","State","Value")
    by_state <- split(hospital_state_value, hospital_state_value$State)[[state]]
    as.character(by_state[order(by_state$Value, by_state$Hospital),][1,1])
}
