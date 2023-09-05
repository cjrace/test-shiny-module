# module UI ====================================================================
data_preview_ui <- function(id) {
 tagList(
   dataTableOutput(NS(id, "preview_dataset"))
 )
}

# module server ================================================================

data_preview_server <- function(id, user_selection){
  stopifnot(is.reactive(user_selection))
  
  moduleServer(id = "data_preview", function(input, output, session) {
    
    dataset <- reactive({
      if(user_selection() == "vehicles"){
        return(cars_dataset)
      } else if (user_selection() == "geographic") {
        return(lake_huron_dataset)
      } 
    }

    )

    # Render the data table
    output$preview_dataset <- DT::renderDataTable({
      req(dataset())
      dataset()
    })
  })
}
