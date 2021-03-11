UIflower <- function(id){
  ns <- NS(id)
  
  tagList(
              fluidRow(
                box(title = "Custom flower", color = "black", width = 15,
                    tags$label(class = "label_styl", textOutput(ns("angleVal"))),
                    shiny.semantic::slider_input(ns("angle_in"), min = 1, max = 45, value = 2, step = 1, class = "labeled ticked"),
                    tags$label(class = "label_styl", textOutput(ns("pointsVal"))),
                    shiny.semantic::slider_input(ns("points_in"), min = 100, max = 10000, value = 1000, step = 300, class = "labeled ticked"),
                    plotOutput(ns("cutomFlower"))
                )
              ),
              fluidRow(
                tabBox(title = "Math flower 'Golden Angle'", color = "black", width = 15,
                       collapsible = FALSE,
                       tabs = list(
                         list(menu = "Сhamomile", content = plotOutput(ns("flower_one"))),
                         list(menu = "Dandelion", content = plotOutput(ns("flower_two"))),
                         list(menu = "Sunflower", content = plotOutput(ns("flower_three")))
                       )),
              )
              
              
              #tabItem(tabName = "math_tab",
              
              #) #/tabitem

  )#/taglist
  
}