# Define the number of points
points <- 500
# Define the Golden Angle
angle <- pi * (3 - sqrt(5))
t <- (1:points) * angle
x <- sin(t)
y <- cos(t)
df <- data.frame(t, x, y)    

flowerServer <- function(id) {
  ns <- NS(id)
  moduleServer(
    id,
    function(input, output, session) {
      
      output$flower_one <- renderPlot(
        ggplot(df, aes(x*t, y*t)) +
          geom_point(size=8, alpha=0.5, color="#252424") +
          theme(panel.background = element_rect(fill="white"),
                panel.grid=element_blank(),
                axis.ticks=element_blank(),
                axis.title=element_blank(),
                axis.text=element_blank())
      )
      
      output$flower_two <- renderPlot(
        ggplot(df, aes(x*t, y*t)) + 
          geom_point(aes(size=t), alpha=0.5, shape=8)+
          theme(legend.position="none",
                panel.background = element_rect(fill="white"),
                panel.grid=element_blank(),
                axis.ticks=element_blank(),
                axis.title=element_blank(),
                axis.text=element_blank())
      )
      
      output$flower_three <- renderPlot(
        ggplot(df, aes(x*t, y*t)) + 
          geom_point(aes(size=t), alpha=0.5, shape=17, color="yellow")+
          theme(legend.position="none",
                panel.background = element_rect(fill="#252424"),
                panel.grid=element_blank(),
                axis.ticks=element_blank(),
                axis.title=element_blank(),
                axis.text=element_blank())
      )
      
      output$angleVal <- shiny::renderText({
        paste("Angle: ", input$angle_in)
      })
      
      output$pointsVal <- shiny::renderText({
        paste("Points: ", input$points_in)
      })
      
      # Change the value of the angle
      
      t_num <- reactive({
        req(input$points_in)
        req(input$angle_in)
        
        (1:input$points_in)*input$angle_in
      })
      
      x_val <- reactive({
        sin(t_num())
      })
      
      y_val <- reactive({
        cos(t_num())
      })
      
      dataFr <- reactive({
        data.frame(t = t_num(),
                   x = x_val(),
                   y = y_val())
      })
      
      output$num <- renderText({
        paste(names(dataFr()))
      })
      
      output$cutomFlower <- renderPlot({
        ggplot(dataFr(), aes(x*t, y*t)) + 
          geom_point(aes(size=t), alpha=0.5, shape=17, color="#fff570")+
          theme(legend.position="none",
                panel.background = element_rect(fill="#252424"),
                panel.grid=element_blank(),
                axis.ticks=element_blank(),
                axis.title=element_blank(),
                axis.text=element_blank())
      })
      


      
    }
  )
}