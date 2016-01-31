library(shiny)

shinyUI(pageWithSidebar(
  titlePanel("Coursera Data Science Courses data"),  
  sidebarPanel(
      radioButtons("course", "Course:",
                   c("All" = "all",
                     "The Data Scientist’s Toolbox" = "tools",
                     "R Programming" = "rprogr",
                     "Exploratory Data Analysis" = "ex",
                     "Reproducible Research" = "repl"
                     )),      
      dateRangeInput("daterange", "Date range:",
                     start = "2014-01-01",
                     end   = "2016-01-31",
                     format = "yyyy-mm-dd"),
      checkboxInput("checkbox", label = "Smooth plot", value = TRUE)
  ),
  mainPanel(
    plotOutput("plot"), 
    hr(),
    fluidRow(column(4, verbatimTextOutput("value")))
  )
))
