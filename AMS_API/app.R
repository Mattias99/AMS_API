#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- fluidPage(
   google_mapOutput(outputId = "map")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$map <- renderGoogle_map({
    test_map
  }
    
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)

