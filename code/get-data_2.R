### Get data without YBP2 large ciliates, SJR1 and LSZ2 large centric diatoms
### And below, ONLY YBP2 large ciliates, SJR1 and LSZ2 large centric diatoms
library(readr)
library(tidyverse)

# READ DATA ---------------------------------------------------------------

ingDatv2 <- read_csv('data/IrTop5Reps_v2.csv',
                   col_select = 1:3,
                   skip = 1,
                   col_names = c("event", "taxaGroup", "value"))

#clrDat <- read_csv('data/CR_Reps_Top5_New.csv',
                  # col_select = -c(3,4,5))

#clrDat <- rename(clrDat, "value" = "CRmlcd")


# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

ingMeans_v2 <- calcMean(ingDatv2)
#clrMeans <- calcMean(clrDat)


### ONLY  YBP2 large ciliates, SJR1 and LSZ2 large centric diatoms 
# READ DATA ---------------------------------------------------------------

ingDatv3 <- read_csv('data/IrTop5Reps_v3.csv',
                     col_select = 1:3,
                     skip = 1,
                     col_names = c("event", "taxaGroup", "value"))


# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

ingMeans_v3 <- calcMean(ingDatv3)

