#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage("Navbar!",

    tabPanel("Main",            
        # Application title
        titlePanel("Old Faithful Geyser Data"),
    
        # Sidebar with a slider input for number of bins
        sidebarLayout(
            sidebarPanel(
                sliderInput("Input1",
                            "Number of bins:",
                            min = 1,
                            max = 50,
                            value = 30),
                conditionalPanel(condition="input.Input1 > 40",
                                    actionButton("Check_Input", label="Do you really want to plot a histogram with so many bins???? ")
                                 
                                 )
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("distPlot")
            )
            
        )
    ),
    tabPanel("Second Page",     

    )
))
