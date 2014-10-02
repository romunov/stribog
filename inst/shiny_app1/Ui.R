
# define the user interface
shinyUI(
  # define type of page layout
  pageWithSidebar(
    
    # define content of page header ####
    headerPanel("stribog"),
    
    # define content of left side of the page ####
    sidebarPanel(
      uiOutput("menuUra")
    ),
    
    # define content of the main part of the page ####   
    mainPanel(
      tabsetPanel(
        tabPanel(title = "KD graf po dnevih v tednu",
                 plotOutput("kdBarGraph", height = "600px")
        ),
        
        tabPanel(title = "KD podatki",
                 dataTableOutput("kdTable")
        ),
        
        tabPanel(title = "KDO podatki",
                 dataTableOutput("kdoTable")
        )
      )
    )
  )
)