#install.packages(c("shiny","leaflet","sf","dplyr","geojsonio","rgdal","magrittr","jsonlite"))
library(shiny)
library(leaflet) 
library(sf)
library(dplyr)
library(geojsonio)
library(rgdal)
library(magrittr)
library(jsonlite)

getwd()
setwd("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R")
Caryota <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/Caryota.csv", header = TRUE)
JsonBot <- geojsonio::geojson_read("level3link.geojson", what = "sp")

Palms <- read.csv("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/palms_in_tdwg3.csv", header = TRUE)
shape <- readOGR(dsn= 'C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp', layer = 'level3')

shapefile_path <- "C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/app.R/PalmAtlas/tdwg_level3_shp"
#named it BotCon so I can mess around with it separate to main app. 
BotCon <- st_read(paste(shapefile_path, "/level3.shp", sep=""))

#############################################

#So I want to change polygon colour dependent on input$var1 being changed.
#The way I was approaching doing this was to try and create a reactive column inside BotCon (the sf object),
#which changed its values when a new species was selected. 
#I wanted to try and do it without reactivity at first, and just create a static leaflet map, 
#with only 0s in the BotCon column iniitally.
#I then thought I could use a simple colour palette to colour the polygons based on the 1s and 0s. 
#I know I got further along with this yesterday but I didn't save my work and had multiple r sessions open:/ 
#rookie errors i know.

#so i want to create input$var1=sp
#sp <- "Hyphaene_petersiana"
#sp <- reactive({input$var1})


# assuming if this is all in the same function it can be reactive
#get name of countries in which the species occurs, 
#by selecting all rows in Palms that are == species name. 
#selected_spp <- as.vector(Palms[Palms$SpecName == sp,"Area_code_L3"])

# then create a new column for the species in the sf object, all zeros for now, assuming reactivty will carry thru
#is this is all in reactive
BotCon[,sp] <- rep(0, nrow(BotCon))

# continues previous work to set the rows where BotCon$LEVEL3_COD in selected_spp (selected by input$var1) to 1
BotCon[BotCon$LEVEL3_COD %in% selected_spp,sp] <- 1

#create basic colour bins, to differentiate
#grabbed a standard pallete with v different colours
#and set domain of data to the BotCon sp column (so setting this column is the main problem I'm facing right now)
bins = c(0,1)
pal <- colorBin("Set1", domain = BotCon$sp, bins = bins)

#make a reactive function that puts all this code together, so when it's running 
#theoretically it will be redrawn whenever input$1 changes
plot_map1 <- reactive({
  sp <- input$var1
  selected_spp <- as.vector(Palms[Palms$SpecName == sp,"Area_code_L3"])
  # create a new column for the species, all zeros for now
  BotCon[,sp] <- rep(0, nrow(BotCon))
  # set the rows where BotCon$LEVEL3_COD in selected_spp to 1
  BotCon[BotCon$LEVEL3_COD %in% selected_spp,sp] <- 1
  BotCon[BotCon$LEVEL3_COD %in% Palms$Area_code_L3, ]
})

#then would put it inside this to draw the map, inside a render object of course. 
leaflet(plot_map1) %>%
  addTiles() %>%
  addPolygons(stroke = TRUE, fillColor = ~pal(BotCon$sp), smoothFactor = 0.3, weight = 1, fillOpacity = 0.2, 
              highlightOptions = highlightOptions(color = "snow1", weight = 2,
                                                  bringToFront = TRUE))


############################################# 
#ACTUAL APP
##############################################

ui <- fluidPage(
  titlePanel("Palm Atlas"),
  #create sidebar with input channels 
  sidebarLayout(
    sidebarPanel(
      helpText("Select variables to create your own Palm Atlas"),
      #species selection input, using Palm database names to get all of them 
      
      selectInput(inputId = "var1", 
                  label = "Species Selection",
                  choices = paste(Palms$SpecName)),
      textOutput("selected_var")
    ),
    #create main panel for text outputs and plots     
    mainPanel(
      leafletOutput("mymap", height=600)
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
  
  output$mymap <- renderLeaflet({
    leaflet(BotCon) %>%
      addTiles() %>%
      addPolygons(stroke = TRUE, color = "forestgreen", smoothFactor = 0.3, weight = 1, fillOpacity = 0.2, 
                  highlightOptions = highlightOptions(color = "snow1", weight = 2,
                                                      bringToFront = TRUE))
  })
  
#  observeEvent(input$var1, {
#  leafletProxy("mymap") %>% 
 #     clearMarkers() %>%
#      clearShapes() %>%
#      addPolygons(data = reactive_polygons(), stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.15, 
#                 fillColor = ~cv_pal(reactivePalmCon()$SelectedSpp))
#  })
}


# Runs the app 
shinyApp(ui = ui, server = server)
