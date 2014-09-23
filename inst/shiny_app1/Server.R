
# load the library for developing web apps with R (http://shiny.rstudio.com/)
library(shiny)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  
  # load kd, kdo data
  load("../../data/kd2013.RData")
  load("../../data/kdo2013.RData")
  
output$kdTable <- renderDataTable({
  return(kd)
  })  
  
output$kdoTable <- renderDataTable({
  return(kdo)
  })
  
})