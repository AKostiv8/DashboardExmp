UIflower <- function(id){
  ns <- NS(id)
  
  tagList(
    fluidRow(
      box(title = "Custom flower", color = "black", width = 15,
        #  tags$label(class = "label_styl", textOutput(ns("angleVal"))),
          slider_input(ns("angle_in"), min = 1, max = 45, value = 2, step = 1, class = "labeled ticked"),
        #  tags$label(class = "label_styl", textOutput(ns("pointsVal"))),
       #   shiny.semantic::slider_input(ns("points_in"), min = 100, max = 10000, value = 1000, step = 300, class = "labeled ticked"),
      #    withSpinner(plotOutput(ns("cutomFlower")), color="#aba125")
      )
    )
    ,
    fluidRow(
      tabBox(title = "Math flower 'Golden Angle'", color = "black", width = 15,
             collapsible = FALSE,
             tabs = list(
               list(menu = "Сhamomile", content = withSpinner(plotOutput(ns("flower_one")), color="#aba125")),
               list(menu = "Dandelion", content = withSpinner(plotOutput(ns("flower_two")), color="#aba125")),
               list(menu = "Sunflower", content = withSpinner(plotOutput(ns("flower_three")), color="#aba125"))
             )),
    )
    
    
    #tabItem(tabName = "math_tab",
    
    #) #/tabitem
    
  )#/taglist
  
}