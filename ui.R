
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
			"Sample Sizes to consider",
			min = 5, 
			max = 10000, 
			value = 1000),
  	radioButtons("test",
			"Effect size test",
			c("f^2" = "f2",
			"r^2" = "r2",
			"Cohen's d" = "d",
			"r" = "r"),
			"f^2"),
	conditionalPanel(
		condition="input.test == 'f2'",
		numericInput(
			"r2value",
			"Convert r^2 to f^2",
			0),
		textOutput("r2output")),
	conditionalPanel(
		condition="input.test == 'd' || input.test == 'r'",
		radioButtons("alternative",
			"Alternative hypothesis for d, r, and r^2",
			c("Two-sided" = "two.sided",
			"Greater" = "greater",
			"Less" = "less"),
			"two.sided"),
    		radioButtons("type",
			"Two-sample, one-sample, or paired (d)",
			c("Two-sample" = "two.sample",
			"One-sample" = "one.sample",
			"Paired" = "paired"),
			"two.sample")
	),
	numericInput("effectSize",
		"Effect size",
		.035,
		0,
		10000),
	checkboxInput("standard",
		"Include cohen's standard effect sizes",
		TRUE),
	numericInput("dfNumerator",
		"Number of predictors in full model (excluding intercept)",
		4,
		0,
		10000),
	numericInput("sigLevel",
		"Significance level",
		.05,
		0,
		1),
	checkboxInput("guides",
		"Enable plot guides",
		TRUE),
	conditionalPanel(
		condition="input.guides == TRUE",
		radioButtons("interest",
			"Power Guides or DF Guides",
			c("Power" = "powerGuides",
			"DF" = "dfGuides"),
			"powerGuides"),
		conditionalPanel(
			condition="input.interest == 'powerGuides'",
			numericInput("power",
			"Power level of interest",
			.8,
			0,
			1)),
		conditionalPanel(
			condition="input.interest == 'dfGuides'",
			numericInput("dfs.plot",
			"Degrees of freedom of interest",
			20,
			5,
			10000)
	)
	)
	),
  
  # Show a plot of the generated distribution
	mainPanel(
	plotOutput("pwrPlot")
	)
	))
