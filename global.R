# Load dependencies ============================================================

library(shiny)
library(DT)
library(dplyr)

# Read in data sets to use =====================================================
## Geographic data ----
lake_huron_dataset <- as.data.frame(LakeHuron)
nile_dataset <- as.data.frame(Nile)

## Vehicle data ----
cars_dataset <- cars
cars_testing_dataset <- mtcars

# Pick the chosen data set ----
dataset <- function(selection) {
  case_when(
    selection == "rivers" ~ nile_dataset,
    selection == "lakes" ~ lake_huron_dataset,
    selection == "cars" ~ cars_dataset,
    selection == "cars testing" ~ cars_testing_dataset,
    TRUE ~ "Error in case when..."
  )
}
