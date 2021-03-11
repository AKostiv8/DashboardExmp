UImainbody <- function(id){
  ns <- NS(id)
  
  tagList(
    
    fluidRow(
      valueBox("Start Date", withSpinner(textOutput(ns("min_value")), color="#aba125"), icon("calendar alternate outline"), color = "black", width = 5),
      valueBox("End Date", withSpinner(textOutput(ns("max_value")), color="#aba125"), icon("calendar alternate outline"), color = "black", width = 5),
      valueBox("Aveeage Conversion Rate", withSpinner(textOutput(ns("CRvalue")), color="#aba125"), icon("calculator"), color = "black", width = 5)
    ), #/fluidRow
    fluidRow(
      box(title = "Conversion rate", color = "black", width = 15,
          shiny.semantic::selectInput(inputId =  ns("groupbyID"), 
                                      choices = c("Week day", "Week", "Month"),
                                      label = "Group by:", 
                                      selected = "Week day"),
          withSpinner(plotlyOutput(ns("CR_plot")), color="#aba125")
      ), #/fluidRow
      box(title = "Conversion rates by condition", color = "black", width = 15,
          withSpinner(plotlyOutput(ns("CR_plot_condition")), color="#aba125")
      )
    ),
    fluidRow(
      box(title = "Compute sample size for experiment", color = "black", width = 9,
          tags$label(class = "label_styl", "p1 value:"),
          shiny.semantic::slider_input(ns("p1Val"), min = 0, max = 1, value = 0.54, step = 0.01, class = "labeled ticked"),
          tags$label(class = "label_styl", "p2 value:"),
          shiny.semantic::slider_input(ns("p2Val"), min = 0, max = 1, value = 0.59, step = 0.01, class = "labeled ticked"),
          tags$label(class = "label_styl", HTML("&beta;:")),
          shiny.semantic::slider_input(ns("beta"), min = 0, max = 1, value = 0.5, step = 0.01, class = "labeled ticked"),
          tags$label(class = "label_styl", HTML("&alpha;:")),
          shiny.semantic::slider_input(ns("alpha"), min = 0, max = 1, value = 0.05, step = 0.01, class = "labeled ticked"),
          tags$label(class = "label_styl", "Power:"),
          shiny.semantic::slider_input(ns("power"), min = 0, max = 1, value = 0.8, step = 0.01, class = "labeled ticked"),
      ), #/box
      valueBox("Sample size", withSpinner(textOutput(ns("sampleSize")), color="#aba125"), icon("filter"), color = "black", width = 6)
    ), #/fluidRow
    fluidRow(
      box(title = "Logistic Regression", color = "black", width = 15,
          withSpinner(tableOutput(ns("logisticRegression")), color="#aba125")
      )
    )#, #/fluidRow
    #tabItem(tabName = "math_tab",
    
    #) #/tabitem
    
  )#/taglist
  
}
