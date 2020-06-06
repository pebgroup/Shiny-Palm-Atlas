library(shiny)

shinyServer ( function(input, output) {
  
  #writing the selected variables for easy assessment
  output$selected_spp <- renderText({ 
    paste("You have selected", input$SppSel)
  })
  output$selected_ala <- renderText({ 
    paste("You have selected Atlas of Australia = ", input$ala)
  })
  output$selected_bien <- renderText({ 
    paste("You have selected Bien = ", input$bien)
  })
  output$selected_bison <- renderText({ 
    paste("You have selected Bison = ", input$bison)
  })
  output$selected_gbif <- renderText({ 
    paste("You have selected GBIF = ", input$gbif)
  })
  output$selected_idigbio <- renderText({ 
    paste("You have selected iDigBio = ", input$idigbio)
  })
  output$selected_inat <- renderText({ 
    paste("You have selected iNaturalist = ", input$inat)
  })
  output$min_max <- renderText({ 
    paste("You have chosen a range that goes from",
          input$range[1], "to", input$range[2])
    })
  output$selected_OriCl <- renderText({ 
    paste("You have selected", input$cleanlvl)
  })
  
  output$download_data <- downloadHandler(
    filename = function() {
      paste(input$SppSel, ".csv", sep="")
      },
    content = function(file) {
      write.csv(data_input(), file)
      }
    )
    
    #making the date filter for the df, need to homogenise the columns first.
    
    data_input <- reactive({ df_full %>% 
      filter(species == input$SppSel) %>% 
      filter(year >= input$range[1]) %>% 
      filter(year <= input$range[2]) 
    }
    )
    
  output$mymap <- renderLeaflet({
    
    if(input$update_map==0)
      return()
    else
      isolate(
    #Filter dataframe based on what species is selected
    df_map <- Caryotalist[Caryotalist$SpecName == input$SppSel ,]
      )
    
    if(input$update_map==0)
      return()
    else
      isolate(
    #Create a palette function, using the selected color
    palette <- colorNumeric(palette = "Greens" , domain = df_map$value)
      )
    
    if(input$update_map==0)
      return()
    else
      isolate(
    #Use the palette function created above to add the appropriate RGB value to our dataframe
    df_map$color <- palette(df_map$value)
      )
    
    if(input$update_map==0)
      return()
    else
      isolate(
    mymap <- leaflet() %>%
      addTiles() %>%
      addPolygons(data=BotCon, 
                  stroke = TRUE,
                  smoothFactor = 0.3, 
                  weight = 1, 
                  fillOpacity = 0.5,  
                  fillColor = df_map$color, 
                  highlightOptions = highlightOptions(color = "white", weight = 3,
                                                      bringToFront = TRUE),
                  label = ~LEVEL3_NAM) %>% 
      addMarkers(data = data_input(), lng = ~ decimallongitude, lat = ~ decimallatitude, label = lapply(data_input()$label, HTML)) %>% 
    setView(lng = 100.52, lat = 13.73, zoom = 3) 
      )
    
    if(input$update_map==0)
      return()
    else
      isolate(
    mymap
      )
  })
  
})