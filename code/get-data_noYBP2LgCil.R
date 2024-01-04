### Get data, IR no YBP2 large ciliates
library(readr)
library(tidyverse)

# READ DATA ---------------------------------------------------------------

ingDatNoYBP2LgCil <- read_csv('data/IrTop5Reps_noYBP2LgCil.csv',
                   col_select = 1:3,
                   skip = 1,
                   col_names = c("event", "taxaGroup", "value"))

#clrDat <- read_csv('data/CR_Reps_Top5_New.csv',
 #                  col_select = -c(3,4,5))

#clrDat <- rename(clrDat, "value" = "CRmlcd")


# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

ingMeansNoYBP2LgCil <- calcMean(ingDatNoYBP2LgCil)
#clrMeans <- calcMean(clrDat)
