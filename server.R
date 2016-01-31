library(shiny)
library(ggplot2)

data_agg <- read.table("data/couses_data.table")

shinyServer(
  function(input, output) {
    
    # Fill in the spot we created for a plot
      output$plot <- renderPlot({
      #input$course
      #input$
      #datebeg <- as.character(input$daterange[1])
      #dateend <- as.character(input$daterange[2])
      #subset <- data_agg[data_agg$month > datebeg & data_agg$month < dateend,]
        
        
        
      course <- input$course  
      
      coursename <- switch(course, 
                           "all" = "All Courses",
                           "tools" = "The Data Scientist’s Toolbox",
                           "rprogr" = "R Programming",
                           "ex" = "Exploratory Data Analysis",
                           "repl" = "Reproducible Research")
      
      datebeg <- as.POSIXlt(as.character(input$daterange[1]))
      dateend <- as.POSIXlt(as.character(input$daterange[2]))
      
      smooth = input$checkbox

      subset <- data_agg[as.POSIXlt(data_agg$month) >=  datebeg & 
                           as.POSIXlt(data_agg$month) <= dateend, ]
                           
      if (course !=  "all") {
        subset <- data_agg[data_agg$course == course,]
      }
      
      # Render a barplot
      g <-
      ggplot(subset, aes(x= as.Date(month), y= x, colour = course)) + 
         xlab("") + ylab("Number of students") +
        ggtitle(coursename) +
        geom_line()
      
      if (smooth) {
        g <- g +   geom_smooth()
      }
      
      g
    })    
    output$value <- renderPrint(
      {
        c(input$course, 
          as.character(input$daterange[1]),
          as.character(input$daterange[2])
          #as.character(input$daterange)
          )
      })
      
  }
)
