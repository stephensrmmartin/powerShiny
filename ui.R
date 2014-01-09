
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Power Analysis for Multiple Regression"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("dfs", 
                "Sample Size",
                min = 2, 
                max = 5000, 
                value = 1000),
    numericInput("effectSize",
    	     	"Estimated f^2 value",
    	     	"0",
    	     	"10000",
    	     	".035"),
    numericInput("dfNumerator",
    	     "Number of predictors in full model (excluding intercept)",
    	     "3",
    	     "0"),
    numericInput("sigLevel",
    	     "Significance level",
    	     ".05",
    	     "0",
    	     "1"),
    checkboxInput("guides",
    	      "Enable plot guides",
    	      TRUE),
    numericInput("cutoff",
    	     "Power level cutoff for guides",
    	     ".80",
    	     "0",
    	     "1")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("pwrPlot")
  )
))
