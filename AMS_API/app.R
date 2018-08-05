#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####

header <- dashboardHeader(title = "Job Ads from Arbetsförmedlingen")

sidebar <- dashboardSidebar()

body <- dashboardBody(
  fluidRow(
    box(title = "Job Ad",
        width = 12,
        solidHeader = TRUE,
        status = "primary",
        h3("Company: "), job_all$workplace[i],
        br(),
        h3("Title: "), job_all$title[i],
        br(),
        h3("Profession: "), job_all$Work[i],
        br(),
        h3("Application: "), a(job_all$web[i]),
        br(),
        h3("Open for Application: "), job_all$firstday[i],
        " to ", job_all$lastday[i]
      ),
    box(title = "Map, Direction and Distance",
        width = 12,
        solidHeader = TRUE,
        status = "primary",
        google_mapOutput(outputId = "map"),
        h3("Address: "), job_all$address[i],
        br(),
        h3("Duration "), job_dist$rows$elements[[1]]$duration$text,
        br(),
        h3("Distance"), job_dist$rows$elements[[1]]$distance$text
        ),
    box(title = "Description",
        width = 12,
        solidHeader = TRUE,
        status = "primary",
        textOutput(outputId = "Text with textOutput"),
        htmlOutput(outputId = "Text with htmlOutput")
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
