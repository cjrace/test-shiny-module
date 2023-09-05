# script showing what the app would look like without modules
# Load dependencies ============================================================

library(shiny)
library(DT)

# Read in data sets to use =====================================================
## Geographic data ----
lake_huron_dataset <- as.data.frame(LakeHuron)
# nile_dataset <- Nile

## Vehicle data ----
cars_dataset <- cars

# UI ===========================================================================

ui <- fluidPage(
  
  "A quick data preview app",
  
  selectInput("user_interest", label = "What are you interested in?", choices = c("geographic", "vehicles")),
  
  dataTableOutput("preview_dataset")
  
)

# Server =======================================================================

server <- function(input, output){
  
  dataset_to_preview <- reactive({
    validate(
      need(input$user_interest, "Please selection an option")
    )
    
    if(input$user_interest == "vehicles"){
      cars_dataset
    } else if (input$user_interest == "geographic") {
      lake_huron_dataset
    }
  })
  
  output$preview_dataset <- DT::renderDataTable({
    dataset_to_preview()
  })
  
}

# Run app ======================================================================

shinyApp(ui = ui, server = server)
