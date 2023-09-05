ui <- fluidPage(
  "A quick data preview app using R Shiny modules",
  user_selection_ui(id = "user_selection"),
  data_preview_ui(id = "data_preview")
)
