make_disease_by_species_plot <- function(region, summary){
  
  dis_long <- summary %>%
    pivot_longer(
      cols = starts_with("prevalence_"), 
      names_to = "disease_condition",
      values_to = "prevalence"
    ) %>%
    filter(disease_condition %in% c("prevalence_present_disease",
                                    "prevalence_fast_disease", 
                                    "prevalence_slow_disease"))%>%
    dplyr::select(SPECIES_NAME, disease_condition, prevalence)  # Keep only the desired columns
  
  # # Order SPECIES_NAME based on the previous order
  # dis_long$SPECIES_NAME <- factor(dis_long$SPECIES_NAME, levels = species_order)
  # 
  
  # Set the order for disease_condition
  dis_long$disease_condition <- factor(dis_long$disease_condition, 
                                       levels = c("prevalence_fast_disease",
                                                  "prevalence_slow_disease",
                                                  "prevalence_present_disease"))
  
  # Create disease plot
  dis_plot <-  ggplot(dis_long, aes(x = reorder(SPECIES_NAME, prevalence), y = prevalence, fill = disease_condition)) +
    geom_bar(stat = "identity") +
    coord_flip() +  
    labs(title = "Disease Prevalence (%)",  
         y = "Prevalence") +
    scale_fill_manual(values = c("prevalence_present_disease" = "#e3c869",
                                 "prevalence_slow_disease" = "#a8bf6d", 
                                 "prevalence_fast_disease" = "#5cb090"), 
                      labels = c("prevalence_present_disease" = "Present",
                                 "prevalence_slow_disease" = "Slow (<1cm)",
                                 "prevalence_fast_disease" = "Fast (>1cm)"),
                      breaks = c("prevalence_present_disease",
                                 "prevalence_slow_disease", 
                                 "prevalence_fast_disease"),
                      name = NULL) + 
   scale_y_continuous(expand = expansion(mult = c(0, 0)), 
                       limits = c(0, max(dis_long$prevalence) * 1.25)) +  
   # scale_y_reverse(
     # expand = expansion(mult = c(0.1, 0))  # No space at the bottom
    #) +
    theme_Publication(base_size = 20) +
    theme(
      axis.text.x = element_text(size = 10),
      legend.position = "bottom",
      axis.ticks.y = element_blank(),
      axis.text.y = element_text(face = "italic"),
      axis.title.y = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )

  return(dis_plot)
  
}