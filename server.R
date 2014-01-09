
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
source("power.R")
library(shiny)

shinyServer(function(input, output) {
   
  output$pwrPlot <- renderPlot({
     
    # generate and plot an rnorm distribution with the requested
    # number of observations
  	pwrFrame <- createPwrFrame(effectSizes=c(.02,.15,.35,input$effectSize),dfs=1:input$dfs,dfNumerator=input$dfNumerator,sig.level=input$sigLevel)
  	plotPower(pwrFrame,guides=input$guides,cutoff=input$cutoff)
    
  })
  
})
