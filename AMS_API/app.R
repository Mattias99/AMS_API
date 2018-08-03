#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####

header <- dashboardHeader(title = "Job Ads from Arbetsförmedlingen")

sidebar <- dashboardSidebar()

body <- dashboardBody(
  fluidRow(
    box(title = h1(strong("Job Ad")),
        width = 12,
        h3("Company: "), job_all$workplace,
        br(),
        h3("Title: "), job_all$title,
        br(),
        h3("Profession: "), job_all$Work,
        br(),
        h3("Application: "), a(job_all$web)
      ),
    box(width = 12,
        google_mapOutput(outputId = "map"),
        h3("Address: "), job_all$address,
        br(),
        h3("Duration "), job_dist$rows$elements[[1]]$duration$text,
        br(),
        h3("Distance"), job_dist$rows$elements[[1]]$distance$text
  )
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
