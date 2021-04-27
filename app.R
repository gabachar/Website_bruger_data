library(shiny)
library(shinydashboard)
library(tidyverse)

brugere <- read_csv("daily-website-visitors.csv", 
                    col_types = cols(Date = col_date(format = "%m/%d/%Y")))

view(brugere)
ui <- dashboardPage(
    
    title = "Daglige brugere Dashboard", skin = "red",
  
    dashboardHeader(title = div(img(height = 50, width = 50, src = "Dating-dk.png"))),
    dashboardSidebar(
      tags$style(type = "text/css",
                 ".shiny-output-error {visibility: hidden;}",
                 ".shiny-output-error:before {visibility: hidden;}"),
      sidebarMenu(id = "brugere", 
                  menuItem("Brugere", tabName = "brugere", icon = icon("user-alt")))
    ),
    dashboardBody(
        tabItems(
          tabItem(tabName = "brugere")),
            fluidRow(valueBoxOutput(width = 4, "unik_bruger"),
                    valueBoxOutput(width = 4, "ny_bruger"),
                    valueBoxOutput(width = 4, "tilbage_bruger")),
            fluidRow(column(width = 12, box(title = "", width = NULL, dateRangeInput("datoer", label = "Vælg dato",
                                                                                     start = "2020-08-01",
                                                                                     end = "2020-08-19",
                                                                                     max = "2020-08-19"),

          checkboxInput("tendens", label = "Plot tendenslinje"),
          submitButton("Gem")))),


    fluidRow(column(width = 12, box(title = "Unikke besøg pr. dag", width = NULL, plotOutput("besøg_pr_dag"))))             
    
  )
)

server <- function(input, output) {
  
  output$unik_bruger <- renderValueBox({
    
    first_row <- head(brugere, n = 1)
    
    df <- brugere %>%
      filter(Date >= as.Date(input$datoer[1]) & Date <= as.Date(input$datoer[2]))
    
    valueBox(sum(df$Unique.Visits), "Unikke Besøg", icon = icon("heart"), color = "maroon"
    )
  })
  
  output$ny_bruger <- renderValueBox({
    
    first_row <- head(brugere, n = 1)
    
    df <- brugere %>%
      filter(Date >= as.Date(input$datoer[1]) & Date <= as.Date(input$datoer[2]))
    
    valueBox(sum(df$First.Time.Visits), "Nye Brugere", icon = icon("heart-broken"), color = "maroon"
    )
  })
  
  output$tilbage_bruger <- renderValueBox({
    
    first_row <- head(brugere, n = 1)
    
    df <- brugere %>%
      filter(Date >= as.Date(input$datoer[1]) & Date <= as.Date(input$datoer[2]))
    
    valueBox(sum(df$Returning.Visits), "Tilbagevendende Brugere", icon = icon("arrows-alt-v"), color = "maroon"
    )
  })
    
   
  
 output$besøg_pr_dag <- renderPlot({
   
   brugere2 <- brugere %>%
   filter(Date >= as.Date(input$datoer[1]) & Date <= as.Date(input$datoer[2]))
   
  p1 <-  ggplot(brugere2, aes(x = Date, y = Unique.Visits, group = 1)) + 
     geom_line(color = "maroon") +
    labs(title = "Unikke besøg pr. dag", x = "Dato", y = "Unikke Besøg")
  
  if(input$tendens) {
    
  p2 <- p1 + geom_smooth()
  
  print(p2) 
  
  } else {
  
  print(p1)
    
  }
 })
  
}

shinyApp(ui = ui, server = server)
