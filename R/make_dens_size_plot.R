
make_dens_size_plot <- function(region, species) {
  
  years <- get_size_freq_years(region)
  
  species_code <- abbreviate_species_name(species)
 
  project <- "NCRMP"
  
  if (region %in% c("Southeast Florida", "Florida Keys", "Dry Tortugas")){ project <- "NCRMP_DRM"}
  
  region_code <- region_lookup(region)

  tmp <- NCRMP_make_size_bins(
    region = region_code,
    project = project,
    years = years,
    size_bin_count = 10,
    length_bin_count = 10,
    species_filter = species_code
  )
  
  dens_plot <- tmp$demos %>%
    filter(SPECIES_CD == species_code) %>%
    mutate(YEAR = as.factor(YEAR)) %>%
    ggplot(aes(x = MAX_DIAMETER, group = YEAR, fill = YEAR, color = YEAR)) +
    geom_density(aes(y = after_stat(count)), adjust = 1, alpha = 0.4, size = 1) +
    theme_Publication(base_size = 10) +
    ggtitle("Size Distribution") +
    xlab("Maximum Diameter (cm)") +
    ylab("Weighted Observed Frequency") +
    theme(
      axis.text = element_text(size = 14),
      axis.title = element_text(size = 16),
      legend.position = "none",
      plot.title = element_text(face = "bold")
    ) +
    scale_fill_manual(values = c("#53868a", "#00cd65", "#ffd601")) +
    scale_color_manual(values = c("#53868a", "#00cd65", "#ffd601"))
  
  return(dens_plot)

}
