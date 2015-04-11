library(shiny)

shinyUI(fluidPage(

  # Application title
  
  wellPanel(h1("California education data"),
<<<<<<< HEAD:InteractionPlot/ui.R
            p("For more exposition, see https://ameliamn.shinyapps.io/InteractionPlotExplanation/InteractionPlot.Rmd")),
=======
              p("(A caveat-- this is bad statistical practice. However, it is something that I see people doing pretty frequently, 
              and hopefully this interactive example will demonstrate how unstable it can be. Using categorical terms in a linear regression 
              is a way to compare predictive values for separate groups. Using several categorical variables can create easy-to-interpet interaction plots, 
              unlike the more complex interaction plots that result from other combinations of variable types. Because of this, users will sometimes take a 
              continous numeric variable and split it into two or more categorical groups. However, the choice of cut point is very important to the results-- 
              just a slight change in that cut point, and the effect may appear much smaller, and can even 'flip' if the variables are colinear. 
              However, since most users are working in a very static environment, there is almost no chance they will try more than one value for cut point. 
              This is a simple example of how having access to all the parameter choices made in an analysis could lead to better analysis.)")),

>>>>>>> 74df2a866ac292bdc8a0983da148ac50c3574965:ui.R
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("variable",
                  "Variable to make numeric:", 
                  choices = list("Percent black"="PCT_AA", "Average parent education"="AVG_ED", "Percent English learners"="P_EL", "Percent teachers with full credentials"="FULL"),
                  selected = "PCT_AA"),
      uiOutput("rangeslider"),
      plotOutput("underlyingdist"),
      textOutput("percens")
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
