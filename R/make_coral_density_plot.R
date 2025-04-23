make_coral_density_plot <- function(region, species){

  region_data <- coral_density_data(region) %>%
    filter(SPECIES_CD == species)
  
  coralDensPlot <-   region_data %>%
    filter(YEAR %in% get_sampling_years(region)) %>%
    ggplot( aes(x = YEAR, y = avDen)) +
    geom_line() +  
    geom_point(size = 2) + 
    theme_Publication()+
    geom_errorbar(aes(ymin = avDen - SE, ymax = avDen + SE), width = 0.2) +  
   # facet_wrap(~ SPECIES_CD, scales = "free_y") +  
    labs(
      x = "Year",
      y = "Average Density"
      #title = "Average Density of Coral Species Over Time",
   #   color = "Region"
    ) +
    ggtitle(" ")
  
  
  return(coralDensPlot)

}