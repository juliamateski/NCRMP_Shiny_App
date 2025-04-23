make_bleach_by_species_plot <- function(region, summary){

  
  piv_long <- summary %>%
    pivot_longer(
      cols = starts_with("prevalence_"),
      names_to = "bleaching_condition",
      values_to = "prevalence"
    ) %>%
    filter(bleaching_condition %in% c("prevalence_partial_bleaching", "prevalence_paling", "prevalence_total_bleaching")) %>%
    select(SPECIES_NAME, bleaching_condition, prevalence)
  
  piv_long$bleaching_condition <- factor(piv_long$bleaching_condition, 
                                         levels = c("prevalence_total_bleaching", 
                                                    "prevalence_partial_bleaching", 
                                                    "prevalence_paling"))
  
  plot <- piv_long %>%
    ggplot(aes(x = reorder(SPECIES_NAME, prevalence), y = prevalence, fill = bleaching_condition)) +
    geom_bar(stat = "identity") + 
    coord_flip() + 
    labs(title = region, y = "Prevalence") + 
    scale_fill_manual(values = c("prevalence_total_bleaching" = "#c5deda",
                                 "prevalence_partial_bleaching" = "#FF9B71",
                                 "prevalence_paling" = "#a17c9b"),
                      breaks = c("prevalence_paling", "prevalence_partial_bleaching", "prevalence_total_bleaching"),
                      labels = c("Paling", "Partial Bleaching", "Total Bleaching"),
                      name = NULL
    ) +
    scale_y_continuous(expand = expansion(mult = c(0, 0)), limits = c(0, max(piv_long$prevalence) * 1.1)) +
    theme_Publication(base_size = 20) +
    theme(
      axis.text.x = element_text(size = 10),
      legend.position = "bottom",
      axis.ticks.y = element_blank(),
      axis.text.y = element_text(face = "italic"),
      axis.title.y = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )
  
  return(plot)
}