
# load the library for developing web apps with R (http://shiny.rstudio.com/)
library(shiny)

# load library for graphics
library(ggplot2)

# load the library for interactive graphics
library(ggvis)
library(dplyr)

# define the server-side logic of the Shiny application
shinyServer(function(input, output) {
  
  # load kd, kdo data 
  # TODO: load last version from GitHub?
  load("kd2013.RData")
  load("kdo2013.RData")
  
  # ggpot won't plot if non-UTF8 chars are sent to it - quick fix ČETRTEK
  # TODO: cleanup names of days - make them UTF8 if they are not and remove spaces
  levels(kd$dan)[which(levels(kd$dan)=="\xc8ETRTEK    ")] <- "ČETRTEK"
  
  # reactive data frame - depends on what the user selects in the menu
  # and creates a subset of data based on that
  kdReactiveData <- reactive({
    data <- filter(kd, ura==input$selectedUra)
    
  })
  
  # tabel of KD data
  output$kdTable <- renderDataTable({
    return(kd)
  })  
  
  # table of KDO data
  output$kdoTable <- renderDataTable({
    return(kdo)
  })
  
  
  # bar chart of criminal acts by days of the week
  output$kdBarGraph <- renderPlot({
    
    plot <- 
      ggplot(kdReactiveData(), aes(x=dan)) + geom_bar()
    
    return(plot)
  })
  
  # menu for selecting times of criminal acts
  output$menuUra <- renderUI({
    uraLevels <- levels(kd$ura)
    
    selectInput(inputId = "selectedUra", label = "Izberi ure dejanj:",
                choices = uraLevels, selected = uraLevels, multiple = TRUE)
    
  })
  
})