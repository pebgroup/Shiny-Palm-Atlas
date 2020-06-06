library(shiny)

shinyUI( dashboardPage( 
  skin = "green",
  #give titular name 
  dashboardHeader(title = "CaryotAtlas"),
  #create sidebar with input channels 
  dashboardSidebar(
      helpText("Select options to create your own atlas for the Caryota genus"),
#species selection input, using Palm database names to get all of them 
      
      selectInput(inputId = "SppSel", 
                  label = "Species Selection",
                  choices = paste(Caryota$SpecName)),

      #ala database input     
      checkboxInput(inputId =  "ala", 
              label = "Atlas of Australia Database", 
              value = TRUE),

      #bien database input     
      checkboxInput(inputId =  "bien", 
                    label = "Bien Database", 
                    value = TRUE),

      #bison database input     
      checkboxInput(inputId =  "bison", 
              label = "Bison Database", 
              value = TRUE),

      #gbif database input
      checkboxInput(inputId = "gbif", 
                    label = "GBIF Database", 
                    value = TRUE),

      #idigbio database input     
      checkboxInput(inputId =  "idigbio", 
              label = "iDigBio Database", 
              value = TRUE),

      #inat database input     
      checkboxInput(inputId =  "inat", 
              label = "iNaturalist Database", 
              value = TRUE),

      #year range of data input      
      sliderInput(inputId = "range", 
                  label = "Year Range:",
                  min = 1750, max = 2020, 
                  value = c(1950, 2020), sep = ""),

      #level of cleaning chosen to be applied  
      selectInput(inputId = "cleanlvl", 
                  label = "Data Cleaning options ",
                  choices = c("Original", 
                              "Partial",
                              "Full"),
                  selected = "Original"),

# text outputs to 
      textOutput("selected_spp"),
      textOutput("selected_ala"),
      textOutput("selected_bien"),
      textOutput("selected_bison"),
      textOutput("selected_gbif"),
      textOutput("selected_idigbio"),
      textOutput("selected_inat"),
      textOutput("min_max"),
      textOutput("selected_cleanlvl")
    ),

    #create main panel for text outputs and plots     
    dashboardBody(
      leafletOutput("mymap", height=600),
      actionButton(inputId = "update_map", "Create your own CaryotAtlas and dataset!", width = "100%", class = "butt"),
      tags$head(tags$style(".butt{background-color: green !important;} .butt{color: white;}")), # background color and font color
      downloadButton("download_data", "Download the dataset you've created!", width = "100%", class = "butt2"),
      tags$head(tags$style(".butt2{background-color: white !important;} .butt2{color: green;}")), # background color and font color)
      p("This app was developed as part of the Plant Evolutionary Biology group at Aarhus University. It aims to provide researchers and enthusiasts alike the tools to study Caryota. By selecting from the input menu on the left side of the screen, you can create your own Caryota Atlas."),
      p("The map requires loading time, so please be patient. If an error message is printed at the top of the screen, then the dataset you have chosen to create has no data inside it for the map to display. We recommend you to widen your input variables, and the map will redraw itself."),
      p("Talk about best practice, what makes life easier, and  maybe resource links/how to get involved/educated. To remove sidebar for presentation purposes, click the box with 3 dashes at the top of the screen.")
      )
    
  )
)
