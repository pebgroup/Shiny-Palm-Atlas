library(shiny)

shinyUI( fluidPage(
  #give titular name 
  titlePanel("Palm Atlas"),
  #create sidebar with input channels 
  sidebarLayout(
    sidebarPanel(
      helpText("Select variables to create your own Palm Atlas"),
#species selection input, using Palm database names to get all of them 
      
      selectInput(inputId = "var1", 
                  label = "Species Selection",
                  choices = paste(Palms$SpecName)),
      #clean/unclean input      
      selectInput(inputId = "var2", 
                  label = "Clean/Unclean",
                  choices = c("Clean", 
                              "Unclean"),
                  selected = "Clean"),
      #Native or all input      
      selectInput(inputId = "var3", 
                  label = "Native/All",
                  choices = c("Native", 
                              "All"),
                  selected = "Native"),
      #year range of data input      
      sliderInput(inputId = "range", 
                  label = "Year Range:",
                  min = 1900, max = 2020, value = c(1900, 2020), sep = "")
    ),
    #create main panel for text outputs and plots     
    mainPanel(
      textOutput("selected_var"),
      textOutput("selected_var2"),
      textOutput("selected_var3"),
      textOutput("min_max"), 
      leafletOutput("mymap"),
      p(),
      actionButton("recalc", "New points")
    )
    
  )
)
)
