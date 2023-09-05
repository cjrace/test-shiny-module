server <- function(input, output, session) {
  
  user_selection <- user_selection_server(id = "user_selection")
  
  data_preview_server(id = "data_preview", user_selection)
  
}
