# module UI ====================================================================
data_preview_ui <- function(id) {
  tagList(
    dataTableOutput(NS(id, "preview_dataset"))
  )
}

# module server ================================================================

data_preview_server <- function(id, user_selection) {
  stopifnot(is.reactive(user_selection))

  moduleServer(id = "data_preview", function(input, output, session) {
    # Render the data table ----
    output$preview_dataset <- DT::renderDataTable({
      validate(
        need(user_selection, "Please make your selections above.")
      )

      dataset(user_selection())
    })
  })
}
