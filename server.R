server <- function(input, output, session) {
  user_selection <- user_selection_server(id = "user_selection")

  dataset <- reactive({
    if (user_selection() == "vehicles") {
      return(cars_dataset)
    } else if (user_selection() == "geographic") {
      return(lake_huron_dataset)
    }
  })

  output$preview_dataset <- DT::renderDataTable({
    dataset()
  })
}
