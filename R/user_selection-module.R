# module UI ====================================================================
user_selection_ui <- function(id) {
  tagList(
    selectInput(NS(id, "user_interest"), label = "What are you interested in?", choices = c("geographic", "vehicles"))
  )
}

# module server ================================================================

user_selection_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    return(reactive(input$user_interest))
    })
}
