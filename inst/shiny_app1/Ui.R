
# define the user interface
shinyUI(
  # define type of page layout
  pageWithSidebar(
    
    # define content of page header ####
    headerPanel("stribog"),
    
    # define content of left side of the page ####
    sidebarPanel(),
    
    # define content of the main part of the page ####   
    mainPanel(
      tabsetPanel(
        tabPanel(title = "KD Data",
                 dataTableOutput("kdTable")
        ),
        tabPanel(title = "KDO Data",
                 dataTableOutput("kdoTable")
                 )
        )
      )
  )
)