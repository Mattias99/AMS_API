#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####

header <- dashboardHeader(title = "Job Ads from Arbetsförmedlingen")

sidebar <- dashboardSidebar()

body <- dashboardBody(
  fluidRow(
    box(
      title = "Description of Ad"
    ),
    box(google_mapOutput(outputId = "map", height = 250))
  )
)

ui <- dashboardPage(header, sidebar, body)
  


server <- function(input, output) {
  output$map <- renderGoogle_map({
    test_map
  }
    
  )
  
}

#### Run the application ####
shinyApp(ui = ui, server = server)
