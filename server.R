
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
source("power.R")
library(shiny)

shinyServer(function(input, output) {
	output$r2output <- renderText({
		r2tof2(r2=input$r2value)
	})
   
  output$pwrPlot <- renderPlot({
     
    # generate and plot an rnorm distribution with the requested
    # number of observations
  	pwrFrame <- createPwrFrame(effectSizes=input$effectSize,
  				   dfs=5:input$dfs,
  				   dfNumerator=input$dfNumerator,
  				   sig.level=input$sigLevel,
  				   alternative=input$alternative,
  				   test=input$test,
  				   type=input$type)
  	print(plotPower(pwrFrame,guides=input$guides,power=input$power,df=input$dfs.plot))
  })
  
})
