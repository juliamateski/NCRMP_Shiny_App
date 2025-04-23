make_bleach_year_plot <- function(region, species){
  
  dens_data <- get_year_bleach_data(region) %>%
    filter(species_name == species)
  
  coralCovPlot <- dens_data %>%
    filter(YEAR %in% get_sampling_years(region)) %>%
    ggplot(aes(x = YEAR, y = avBlePrev)) +
    geom_line() +  
    geom_point(size = 2) + 
    geom_errorbar(aes(ymin = avBlePrev - SE_B, ymax = avBlePrev + SE_B), width = 0.2) +  # Add error bars
    labs(
      x = "Year",
      y = "Average Bleaching",
      color = "Region"
    ) +
    theme_Publication()+
    ylim(0,100)
  
  return(coralCovPlot)
}