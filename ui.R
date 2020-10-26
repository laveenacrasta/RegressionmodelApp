library(shiny)
shinyUI(fluidPage(
    titlePanel("Simple linear Regression Model Analysis (mtcars)"),
    sidebarLayout(
        sidebarPanel(
            selectInput("ExplVar", label = h3("Explanatory Variables"),
                        choices = colnames(mtcars), selected = 1),
            
            selectInput("Prevar", label = h3("Independent variable"),
                        choices = colnames(mtcars), selected = 1)
            
        ),
        
        mainPanel(
            
            tabsetPanel(type = "tabs",
                        tabPanel("Help",tags$img(src = "carlogo.png"),p(" "), 
                                 p("1. This app gives a simple analysis of the dataset mtcars which is available in r package."),
                                 p("2. There is a Scatter plot showing the relationship between the independent and dependent varaibles"), 
                                 p("3. We also have the histogram depicted for the independent and dependent variables"),
                                 p("4. The fourth tab gives the model summary of regression analysis"),
                                 p("5. The last tab shows the complete data set with options to Copy, csv format, excel and print too "),),
                        
                        tabPanel("Scatterplot", plotOutput("scatterplot")),
                        tabPanel("Distribution", 
                                 fluidRow(
                                     column(6, plotOutput("ExplanatoryVariable")),
                                     column(6, plotOutput("Independentvariable")))
                        ),
                        tabPanel("Model-Summary", verbatimTextOutput("summary")), # Regression output
                        tabPanel("Data", DT::dataTableOutput('tbl'),downloadButton("downloadData","Download Data")) # Data as datatable
                        
            )
        )
    )))

