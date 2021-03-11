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
      
      
      
      
    }
  )
}