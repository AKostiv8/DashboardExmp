library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(plotly)
library(DT)
library(tidyverse)
library(dplyr)
#library(reactlog)
library(lubridate)
# Load powerMediation
library(powerMediation)
# Load package for cleaning model results
library(broom)
library(shinycssloaders)
library(ggplot2)

source("utilsData.R")
source("mainbodyUI.R")
source("mainbodyServer.R")

ui <- semantic.dashboard::dashboardPage(
    semantic.dashboard::dashboardHeader(title = "Analytics",
                                        tags$head(
                                          tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
                                          tags$link(rel="icon", href="https://www.iconbunny.com/icons/media/catalog/product/7/9/79.9-financial-report-icon-iconbunny.jpg")
                                        ),
                    inverted = TRUE,
                    menu_button_label = "",
                    color = "black"),
    semantic.dashboard::dashboardSidebar(side = "left",
                     inverted = TRUE,
                     closable = TRUE,
                     sidebarMenu(
                         menuItem(tabName = "plot_tab", text = "A/B testing", icon = icon("home")),
                         menuItem(tabName = "math_tab", text = "Math flowers", icon = icon("smile"))
                     ), 
                     class = "sideCustom"),
    semantic.dashboard::dashboardBody(
      UImainbody("dashbody")
    )
)
server <- function(input, output, session) {
  mainbodyServer("dashbody")
    
    
}

shinyApp(ui, server)