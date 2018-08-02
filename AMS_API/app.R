#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####


ui <- fluidPage(
   google_mapOutput(outputId = "map")
)


server <- function(input, output) {
  output$map <- renderGoogle_map({
    test_map
  }
    
  )
  
}

#### Run the application ####
shinyApp(ui = ui, server = server)

