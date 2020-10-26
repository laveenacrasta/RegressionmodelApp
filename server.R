library(shiny)
shinyServer(function(input, output) {
    
    # Fitting the Regression model
    output$summary <- renderPrint({
        fit <- lm(mtcars[,input$ExplVar] ~ mtcars[,input$Prevar])
        names(fit$coefficients) <- c("Intercept", input$var2)
        summary(fit)
    })
    
    # Complete Data table
    output$tbl = DT::renderDataTable(
        mtcars, extensions = "Buttons", options = list(dom = "Bfrtip",buttons = list('copy', 'csv', 'excel','print'))
    )
    
    output$downloadData = downloadHandler(
        filename = function(){
            paste("mtcars", "csv", sep = ".") 
        },
        content = function(file){
            write.csv(mtcars[,c("mpg",input$ExplVar)], file)
        }
    )
    
    
    # Scatter plot showing the relationship between two variables
    output$scatterplot <- renderPlot({
        plot(mtcars[,input$Prevar], mtcars[,input$ExplVar], main="Scatterplot",
             xlab=input$Prevar, ylab=input$ExplVar, pch=19)
        abline(lm(mtcars[,input$ExplVar] ~ mtcars[,input$Prevar]), col="red")
        lines(lowess(mtcars[,input$Prevar],mtcars[,input$ExplVar]), col="blue")
    }, height=400)
    
    
    # Histogram of the Explanatory variable
    output$ExplanatoryVariable <- renderPlot({
        hist(mtcars[,input$ExplVar], main="", xlab=input$ExplVar)
    }, height=400, width=400)
    
    # Histogram of the Predictor variable
    output$Independentvariable <- renderPlot({
        hist(mtcars[,input$Prevar], main="", xlab=input$Prevar)
    }, height=400, width=400)
    
    
})
