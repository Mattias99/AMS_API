#### PACKAGE ####


library(shiny)
library(shinydashboard)


#### SHINY ####

header <- dashboardHeader(title = "Job Ads from Arbetsförmedlingen")

sidebar <- dashboardSidebar()

body <- dashboardBody(
  fluidRow(
    box(title = "Choose Job Ad",
        width = 12,
        solidHeader = TRUE,
        status = "primary",
        selectInput("menu", "Choose your input:",
                    choices = unname(job_all$shiny_menu),
                    selected = "None")
        
    ),
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
    tabBox(width = 12,
           tabPanel("Description",
                    verbatimTextOutput("allresult")
           ),
           tabPanel("Search Words",
                    verbatimTextOutput("words"))
        
  )
 )
)

ui <- dashboardPage(header, sidebar, body)
  


server <- function(input, output) {
  output$map <- renderGoogle_map(test_map)
  # output$allresult <- renderText(job_all$text[i])
  output$allresult <- renderText(
    job_all %>% filter(shiny_menu == input$menu) %>% select(text)
  )
  
  output$words <- renderText({
    str_extract(
      string  = job_all$text[i],
      pattern = coll(c(
        word_tech, word_profession, word_profile
      ),
      ignore_case = TRUE)
    ) %>% na.omit(c())
  })
  
  
}

#### Run the application ####
shinyApp(ui = ui, server = server)
