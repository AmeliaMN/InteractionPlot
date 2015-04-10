library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("California education data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("variable",
                  "Variable to make numeric:", 
                  choices = list("Percent black"="PCT_AA", "Average parent education"="AVG_ED", "Percent English learners"="P_EL", "Percent teachers with full credentials"="FULL"),
                  selected = "PCT_AA"),
      uiOutput("rangeslider")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("moreinfo"),
      tableOutput("modelsummary"),
      plotOutput("interactionplot"),
      textOutput("interpretation")
    )
  )
))
