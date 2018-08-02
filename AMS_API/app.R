#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####


ui <- dashboardPage(
  dashboardHeader(title = "Job Ads from Arbetsförmedlingen"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(
        title = "Description of Ad"
      ),
      box(google_mapOutput(outputId = "map", height = 250))
    )
  )
)
  


server <- function(input, output) {
  output$map <- renderGoogle_map({
    test_map
  }
    
  )
  
}

#### Run the application ####
shinyApp(ui = ui, server = server)
