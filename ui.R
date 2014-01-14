
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  # Application title
	headerPanel("Power Analysis Plotter"),
  # Sidebar with a slider input for number of observations
	sidebarPanel(tabsetPanel(tabPanel("Plot Options",
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
		textOutput("r2output"),
		numericInput("dfNumerator",
			"Number of predictors in full model (excluding intercept)",
			4,
			0,
			10000)),
	conditionalPanel(
		condition="input.test == 'd' || input.test == 'r'",
		radioButtons("alternative",
			"Alternative hypothesis for d, r, and r^2",
			c("Two-sided" = "two.sided",
			"Greater" = "greater",
			"Less" = "less"),
			"Two-sided"),
    		radioButtons("type",
			"Two-sample, one-sample, or paired (d)",
			c("Two-sample" = "two.sample",
			"One-sample" = "one.sample",
			"Paired" = "paired"),
			"Two-sample")
	),
	numericInput("effectSize",
		"Effect size",
		.035,
		0,
		10000),
	checkboxInput("standard",
		"Include cohen's standard effect sizes",
		TRUE),
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
			"Power")),
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
	)),
	tabPanel("Download",
		 numericInput("plotWidth",
		 	     "Width",
		 	     8,
		 	     0),
		 numericInput("plotHeight",
		 	     "Height",
		 	     4,
		 	     0),
		 radioButtons("plotFormat",
		 	     "Filetype",
		 	     c(".svg" = "svg",
		 	       ".pdf" = "pdf"),
		 	     ".svg"
		 	     ),
		 downloadButton("downloadButton",label="Download Plot"))
	)),
	mainPanel(
		plotOutput("pwrPlot"),
		p("Author: Stephen R. Martin"),
		a("Github Page", href="http://github.com/stephensrmmartin/")
		
		
	
	)
	)
)
