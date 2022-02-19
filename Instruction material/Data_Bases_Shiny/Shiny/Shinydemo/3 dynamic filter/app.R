library(shiny)
library(RODBC)
com <- odbcConnect(dsn = "ODBC_to_Demo_RTShiny")
temp=sqlQuery(com,"SELECT * FROM dbo.select_options")
shinyApp(
    ui = fluidPage(navbarPage("Navbar!",
                              tabPanel("Main",            
                                       # Application title
                                       titlePanel("Old Faithful Geyser Data"),
                                       
                                       # Sidebar with a slider input for number of bins
                                       sidebarLayout(
                                         sidebarPanel(
                                           textInput("Value", "Textinput", value = "Input"),
                                           actionButton("save", "Save Value and use in drop-down"),
                                           
                                           selectInput(
                                             inputId="selection",
                                             label="Choose Option",
                                             choices=sqlQuery(com,"SELECT * FROM dbo.select_options")
                                           )
                                         ),
                                         
                                         # Show a plot of the generated distribution
                                         mainPanel(
                                           textOutput("result")
                                         )
                                         
                                       )
                              ),
                              tabPanel("Table1",mainPanel(dataTableOutput("Table1"))),
                              tabPanel("Table2",mainPanel(dataTableOutput("Table2"))),
                              tabPanel("Table3",mainPanel(dataTableOutput("Table3")))
    ),
    ),


    server = function(input, output) {
        
        
        
            observeEvent(input$save, {sqlQuery(com,paste( "INSERT INTO dbo.select_options VALUES('", input$Value, "')",sep="" ) ) })

            textvalue =eventReactive(input$save,{paste("You chose",input$Value)})
            Table1 = reactive({sqlQuery(com,"SELECT * FROM dbo.select_options")})
            Table2 = eventReactive(input$save,{sqlQuery(com,"SELECT * FROM dbo.select_options")})
            
            
            
            
            output$Table1 <-renderDataTable({Table1()})
            output$Table2 <-renderDataTable({Table2()})
            output$Table3 <-renderDataTable({sqlQuery(com,"SELECT * FROM dbo.select_options")})

            output$result <- renderText({ textvalue() })
    }
)
