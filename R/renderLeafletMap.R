renderLeafletMap <- function(input, output, session) {
  
output$map <- renderLeaflet({ #start leaflet
  
  req(input$map_region, input$year_selector)
  
  selected_data <- make_leaf_final_data(input$map_region)
  
 if (!is.null(input$year_selector)) {
      selected_data <- selected_data[selected_data$YEAR %in% input$year_selector, ]
  }
    
  leaflet_map <- leaflet(selected_data) %>%
    addProviderTiles(providers$Esri.OceanBasemap) %>%
    addCircleMarkers(
      lat = ~LAT_DEGREES,
      lng = ~LON_DEGREES,
      radius = 5,
      fillOpacity = 0.8,
      fillColor = ~colorFactor(YEAR, palette = "Set3"),
      stroke = FALSE,
      popup = ~paste(
        "Year: ", YEAR, "<br>",
        "Habitat Code: ", HABITAT_CD, "<br>",
        "Habitat Type: ", HABITAT_TYPE, "<br>",
        "Total Coral Density: ", DENSITY, "<br>",
        "Total Hard Coral Cover: ", round(avCvr, 2)
      )
    ) 
  
  
  leaflet_map
  
}) #end leaflet

}




