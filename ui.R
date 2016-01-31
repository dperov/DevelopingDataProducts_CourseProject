library(shiny)

courses <- c("The Data Scientist’s Toolbox", 
             "R Programming", 
             "Exploratory Data Analysis", 
             "Reproducible Research") 

shinyUI(pageWithSidebar(
  titlePanel("Students of Coursera Data Science courses"),  
  sidebarPanel(
      selectInput("course", "Course:", 
                  courses),
      dateInput("From", "From date:"),
      dateInput("To", "To date:")
  ),
  mainPanel(
    plotOutput("plot") 
  )
))
