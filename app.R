install.packages("shiny")
install.packages("leaflet")
install.packages("sf")
install.packages("dplyr")
install.packages("geojsonio")
install.packages("rgdal")
install.packages("magrittr")
install.packages("jsonlite")
library(shiny)
library(leaflet) 
library(sf)
library(dplyr)
library(geojsonio)
library(rgdal)
library(magrittr)
library(jsonlite)


############################################# 
#ACTUAL APP
##############################################

ui <- fluidPage(
  #give titular name 
  titlePanel("Palm Atlas"),
  #create sidebar with input channels 
  sidebarLayout(
    sidebarPanel(
      helpText("Select variables to create your own Palm Atlas"),
#species selection input, i want these to be drawn from the database of species eventually    
#so i want to use the species names in the database, as the choices in input Var1
#i created a factor, cos it'll hold the names irrespective of how many times they occur, however
#i'm not sure how to draw from this into the choices, and I haven't been able to find many examples
#very open to suggestions! :) 

Caryota <- read.csv("Caryota.csv", header = TRUE)
Caryota$SpecName
Spp <- Caryota[c(1:57),c(2)]

      selectInput(inputId = "var1", 
                  label = "Species Selection",
                  choices = c("Palm 1", 
                              "Palm 2",
                              "Palm 3", 
                              "Palm 4"),
                  selected = "Palm 1"),
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


# Define server logic ----
server <- function(input, output) {
  #tells server to render the outputs of the various inputs as text
  #these bits go into the main panel 
  output$selected_var <- renderText({ 
    paste("You have selected", input$var1)
  })
  output$selected_var2 <- renderText({ 
    paste("You have selected", input$var2)
  })
  output$selected_var3 <- renderText({ 
    paste("You have selected", input$var3)
  })
  output$min_max <- renderText({ 
    paste("You have chosen a range that goes from",
          input$range[1], "to", input$range[2])
  })
  
  
  #this puts in the random points coming up, but I'm envisaging putting in the update button here 
  points <- eventReactive(input$recalc, {
    cbind(10, 20)
  }, ignoreNULL = FALSE)
  
  #now we read in the geojson file 
  geojson <- readLines("level3.geojson", warn = FALSE) %>%
    paste(collapse = "\n") %>%
    fromJSON(simplifyVector = FALSE)
  
  #this gives it a default colour scheme 
  geojson$style = list(
    weight = 1,
    color = "#555555",
    opacity = 1,
    fillOpacity = 0.8
  )
  
  pal <- colorQuantile("Greens", gdp_md_est / pop_est)
  
  
  
  output$mymap <- renderLeaflet({
    #url <- "https://raw.githubusercontent.com/tdwg/wgsrpd/master/geojson/level3.geojson"
    #geojson <- jsonlite::fromJSON(url)
    library("leaflet") %>% 
      leaflet() %>%
      addTiles() %>% 
      addGeoJSON(geojson) %>% 
      addMarkers(data = points()) 
  })
}


# Runs the app 
shinyApp(ui = ui, server = server)

############################################################
############################################################

BotCon <- rgdal::readOGR("level3.geojson")
leaflet(BotCon) %>%
  addTiles()

Bot2 <- rgdal::readOGR("level3link.geojson")
leaflet(Bot2) %>% 
  addTiles()