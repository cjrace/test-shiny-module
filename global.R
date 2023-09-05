# Load dependencies ============================================================

library(shiny)
library(DT)
library(dplyr)

# Read in data sets to use =====================================================
## Geographic data ----
lake_huron_dataset <- LakeHuron
nile_dataset <- Nile

## Vehicle data ----
cars_dataset <- cars
cars_testing_dataset <- mtcars
