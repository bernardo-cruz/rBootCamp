
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    
    output$distPlot <- renderPlot({
        
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        # draw the histogram with the specified number of bins
        hist(x, breaks = input$Input1 + 1, col = 'darkgray', border = 'white')
        
    })

    output$distPlot2 <- renderPlot({
        
        # generate bins based on input$bins fro(m ui.R
        x    <- faithful[, 2]
        Sys.sleep(5)
        # draw the histogram with the specified number of bins
        hist(x, breaks = 10, col = 'darkgray', border = 'white')
        
    })    
    
})