# module UI ====================================================================
user_selection_ui <- function(id) {
  tagList(

    # Initial drop down for high level area of interest ----
    selectInput(
      NS(id, "user_interest"),
      label = "What are you interested in?",
      choices = c("geographic", "vehicles")
    ),

    # Second drop down with data set selection based on area of interest ----
    selectInput(
      NS(id, "data_selection"),
      label = "Select a dataset",
      choices = "Please select your area of interest"
    )
  )
}

# module server ================================================================

user_selection_server <- function(id) {
  moduleServer(id, function(input, output, session) {
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

    # Return the data set selected by the user ----
    return(reactive(input$data_selection))
  })
}
