library(shiny)

# Define server logic required to draw a histogram
shinyServer ( function(input, output) {
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
  
  
  output$mymap <- renderLeaflet({
    leaflet(shape) %>%
      addTiles() %>%
      addPolygons(stroke = TRUE, color = "forestgreen", smoothFactor = 0.3, weight = 1, fillOpacity = 0.2, 
                  highlightOptions = highlightOptions(color = "snow1", weight = 2,
                                                      bringToFront = TRUE)) %>% 
      addMarkers(data = points())
  })
})