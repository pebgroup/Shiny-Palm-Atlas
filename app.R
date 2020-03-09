library(shiny)
library(leaflet) 
#does the mapping features

setwd("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/dataset 1")
df <- read.csv(file = "5spp.csv")
#have just set wd to get file, and then read the csv file into a dataframe 
pam <- table(df[2:1])
#this puts the dataframe into a spp presence absence matrix and gives it a name 
pam

#this bit is for the map placeholder I've included within the project 
r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

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
#spp selection input      
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
                  min = 1900, max = 2020, value = c(1900, 2020))
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

#codes for the bit of map I've put in as a proof of concept
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(data = points())
  })
}
  


# Runs the app 
shinyApp(ui = ui, server = server)

############################################################
############################################################


#Emulating palmtraits although their way refused to work for me, reading the OGR file into a dataframe for usage later
BotCon <- readOGR(dsn=path.expand("C:/Users/benra/OneDrive/Documents/Year 3 (Aarhus)/Palm Project/R practice/dataset 1/tdwg_level3_shp"), 
                  layer="level3")
#they also did this, which I assume sorts some row names out, but have little idea really 
BotCon@data$id <- rownames(BotCon@data)


#these stages were included by palmtraits to refine the polygons, which i assume theyre doing because 
#the polygons are a bit old and didn't look nice enough to publish
shape2 <- gSimplify(spgeom = BotCon, tol = 0.01, topologyPreserve = TRUE) 
BotCon <- SpatialPolygonsDataFrame(shape2, BotCon@data)
shape_centroid <- gCentroid(BotCon, byid = TRUE)
BotCon@data$centroid_long <- shape_centroid$x
BotCon@data$centroid_lat <- shape_centroid$y
shape_fort <- fortify(BotCon, id = id)
shape_gg <- merge(shape_fort, BotCon@data, by = "id")

#this bit then reads the occurence data into R, and I've chosen to keep with 5 species thuse far, 
#as it hould hopefully make stuff easier for me
occ <- read.csv(file.path( "5spp.csv"), stringsAsFactors = FALSE)
occ$SpecName <- gsub(occ$SpecName, pattern = "_", replacement = " ")


### so I've got my dataframes here, and both presumably can be sorted via their species names, and their botanical countries
#I'm unsure if I even can put them together in a normal R map first, because it wouldn't have the interactivty required 
#so then I need to try doing it in shiny first of all, 
#because I can't do a simple unreactive one that would demonstrate what I need sufficiently.
#I should be able to combine my 5 species dataset and the large one containing the polygons, because the polygons just set out the map right?
#I don't know and havent been able to figure out how to do so, but once I have this template, 
#I'm fairly sure adding in occurence points on the map should then be easier, because there's numerous examples online 
#its just squishing these datasets together, and then i can link them to my drop down palm species menu 