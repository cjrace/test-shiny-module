# script showing what the app would look like without modules
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

# UI ===========================================================================

ui <- fluidPage(
  "A quick data preview app",
  # Initial drop down for high level area of interest ----
  selectInput(
    "user_interest",
    label = "What are you interested in?",
    choices = c("geographic", "vehicles")
  ),
  
  # Second drop down with data set selection based on area of interest ----
  selectInput(
    "data_selection",
    label = "Select a dataset",
    choices = "Please select your area of interest"
  ),
  dataTableOutput("preview_dataset")
)

# Server =======================================================================

server <- function(input, output) {
  
  # Update the second drop down based on selections from the first ----
  observeEvent(input$user_interest,
               {
                 if (input$user_interest == "geographic") {
                   interested_datasets <- c("rivers", "lakes")
                 } else if (input$user_interest == "vehicles") {
                   interested_datasets <- c("cars", "car tests")
                 } else {
                   interested_datasets <- "An error has occurred when selecting your area of interest"
                 }
                 updateSelectInput(
                   session,
                   inputId = "data_selection",
                   choices = interested_datasets
                 )
               },
               # TODO: Figure out the proper way to handle a default value without needing to ignoreInit
               ignoreInit = TRUE # Hacky way to delay execution for now
  )
  
  dataset_to_preview <- reactive({
    validate(
      need(input$user_interest, "Please selection an option")
    )

    dataset(input$data_selection)
  })

  output$preview_dataset <- DT::renderDataTable({
    dataset_to_preview()
  })
}

# Run app ======================================================================

shinyApp(ui = ui, server = server)
