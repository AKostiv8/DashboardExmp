source("utilsData.R")

mainbodyServer <- function(id) {
  ns <- NS(id)
  moduleServer(
    id,
    function(input, output, session) {
      groupedData <- reactive({
        req(input$groupbyID)
        
        if(input$groupbyID == "Week day"){
          click_data_sum_add <- click_data %>%
            group_by(wday(visit_date, label = TRUE, abbr = FALSE)) %>%
            summarize(conversion_rate = mean(clicked_adopt_today))
          names(click_data_sum_add)[names(click_data_sum_add) == "wday(visit_date, label = TRUE, abbr = FALSE)"] <- "GroupedVar"
          return(click_data_sum_add)
        } 
        if(input$groupbyID == "Week"){
          click_data_sum_add <- click_data %>%
            group_by(week(visit_date)) %>%
            summarize(conversion_rate = mean(clicked_adopt_today))
          names(click_data_sum_add)[names(click_data_sum_add) == "week(visit_date)"] <- "GroupedVar"
          return(click_data_sum_add)
        }
        if(input$groupbyID == "Month"){
          click_data_sum_add <- click_data %>%
            group_by(month(visit_date, label = TRUE, abbr = FALSE)) %>%
            summarize(conversion_rate = mean(clicked_adopt_today))
          names(click_data_sum_add)[names(click_data_sum_add) == "month(visit_date, label = TRUE, abbr = FALSE)"] <- "GroupedVar"
          return(click_data_sum_add)
        }
      })
      
      sampleSize <- reactive({
        SSizeLogisticBin(p1 = input$p1Val,
                         p2 = input$p2Val,
                         B = input$beta,
                         alpha = input$alpha,
                         power = input$power)
      })
      
      experiment_data_clean_sum <- reactive({
        experiment_data_clean %>%
          group_by(condition, visit_date) %>%
          summarize(conversion_rate = mean(clicked_adopt_today))
      })
      
      logisticRegression <- reactive({
        glm(clicked_adopt_today ~ condition,
            family = "binomial",
            data = experiment_data_clean) %>%
          tidy()
      })
      
      minvalue_calc <- reactive({
        min(click_data$visit_date)
      })
      
      maxvalue_calc <- reactive({
        max(click_data$visit_date)
      })
      
      output$min_value <- renderText(format(minvalue_calc(), "%d.%m.%y"))
      output$max_value <- renderText(format(maxvalue_calc(), "%d.%m.%y"))
      #output$CR_value <- renderText(mean(groupedData()$conversion_rate))
      output$CRvalue <- shiny::renderText({
        paste(round(mean(groupedData()$conversion_rate), 3))
      })
      
      output$CR_plot <- renderPlotly(plot_ly(groupedData(), 
                                             x = ~ GroupedVar,
                                             y = ~ conversion_rate,
                                             type = "scatter", 
                                             mode = "lines+markers",
                                             line = list(color = '#fff570'),
                                             marker = list(color = '#fff570')) %>%
                                       layout(xaxis = list(title="",
                                                           gridcolor = '#4a4a4a',
                                                           ticks = 'outside',
                                                           tickcolor = '#4a4a4a'),
                                              yaxis = list(title="conversion rate",
                                                           gridcolor = '#4a4a4a',
                                                           ticks = 'outside',
                                                           tickcolor = '#4a4a4a'),
                                              paper_bgcolor='rgb(255,255,255)',
                                              plot_bgcolor='rgb(37,36,36)'
                                       )
      )
      
      output$CR_plot_condition <- renderPlotly(plot_ly(experiment_data_clean_sum(), 
                                                       x = ~ visit_date,
                                                       y = ~ conversion_rate, 
                                                       color = ~ condition,
                                                       type = "scatter", 
                                                       mode = "lines+markers"
      )  %>%
        layout(legend = list(orientation = "h",   
                             xanchor = "center",
                             x = 0.5,
                             y = -0.2),
               xaxis = list(title="",
                            gridcolor = '#4a4a4a',
                            ticks = 'outside',
                            tickcolor = '#4a4a4a'),
               yaxis = list(title="conversion rate",
                            gridcolor = '#4a4a4a',
                            zeroline = FALSE,
                            ticks = 'outside',
                            tickcolor = '#4a4a4a'),
               paper_bgcolor='rgb(255,255,255)',
               plot_bgcolor='rgb(37,36,36)'
        )
      )
      
      output$sampleSize <- shiny::renderText({
        paste(sampleSize())
      })
      
      output$logisticRegression <- renderTable(logisticRegression())
      
    }
  )
}