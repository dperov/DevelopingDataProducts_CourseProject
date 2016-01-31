library(shiny)
library(ggplot2)

data_agg <- read.table("data/couses_data.table")

shinyServer(
  function(input, output) {

    # Fill in the spot we created for a plot
    output$plot <- renderPlot({
      
      # Render a barplot
      ggplot(data_agg, aes(x= as.Date(month), y= x, colour = course)) + geom_line()  + xlab("Date") + ylab("Number of students")
  
    })    
    
  }
)
