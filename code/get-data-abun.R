### Use Jackson's get_data.R to do the same thing with abundance reps and means
##  First is whole data
##  Next is data minus YBP2 lg ciliates and other organisms, because their
##  numbers are so high and they need an inset
##  Last is data with only YBP2 lg ciliates and other organisms

library(readr)
library(tidyverse)

### Whole data
# READ DATA ---------------------------------------------------------------

abunDat <- read_csv('data/sumAbun.csv',
                   col_select = -c(3,4))
                   
abunDat <- rename(abunDat, "value" = "totBioUgL", "event" = "samp_ev")
                 

# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

abunMeans <- calcMean(abunDat)

### Data minus YBP2 lg cil and oth org
# READ DATA ---------------------------------------------------------------

abunDatv2 <- read_csv('data/sumAbun_noYBP2lgCilOthOrg.csv',
                    col_select = 1:3,
                    skip = 1,
                    col_names = c("event", "taxaGroup", "value"))

# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

abunMeansPartial <- calcMean(abunDatv2)

### Data with ONLY YBP2 lg cil and oth org
# READ DATA ---------------------------------------------------------------

abunDatv3 <- read_csv('data/sumAbun_onlyBig.csv',
                      col_select = 1:3,
                      skip = 1,
                      col_names = c("event", "taxaGroup", "value"))

# CALCULATE MEANS ---------------------------------------------------------

calcMean <- function(x) {
  x %>%
    group_by(taxaGroup, event) %>%
    summarize(avg = mean(value, na.rm = TRUE))
}

abunMeansOnlyBig <- calcMean(abunDatv3)
