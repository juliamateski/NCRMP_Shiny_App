make_bleach_disease_summary <- function(region, dataset){
  
  summary <- dataset %>%
    mutate(SPECIES_NAME = ifelse(SPECIES_NAME == "Orbicella annularis species complex", "Orbicella annularis", SPECIES_NAME),
           SPECIES_CD = ifelse(SPECIES_NAME == "Orbicella annularis", "ORB ANNU", SPECIES_CD)) %>%
    filter(!grepl("spp", SPECIES_NAME, ignore.case = TRUE)) %>%
    filter(N != 0, JUV != 1, REGION == region_lookup(region)) %>%
    group_by(SPECIES_NAME) %>%
    summarise(
      total_colonies = sum(N, na.rm = TRUE),
      n_no_bleaching = sum(BLEACH_CONDITION == "N", na.rm = TRUE),
      n_partial_bleaching = sum(BLEACH_CONDITION == "PB", na.rm = TRUE),
      n_paling = sum(BLEACH_CONDITION == "P", na.rm = TRUE),
      n_total_bleaching = sum(BLEACH_CONDITION == "T", na.rm = TRUE),
      total_bleaching_conditions = n_partial_bleaching + n_paling + n_total_bleaching,
      n_present_disease = sum(DISEASE == "P", na.rm = TRUE),
      n_fast_disease = sum(DISEASE == "F", na.rm = TRUE),
      n_slow_disease = sum(DISEASE == "S", na.rm = TRUE),
      total_disease_conditions = n_fast_disease + n_slow_disease,
      .groups = 'drop'
    ) %>%
    mutate(
      prevalence_no_bleaching = n_no_bleaching / total_colonies,
      prevalence_partial_bleaching = n_partial_bleaching / total_colonies,
      prevalence_paling = n_paling / total_colonies,
      prevalence_total_bleaching = n_total_bleaching / total_colonies,
      prevalence_all_bleaching_conditions = total_bleaching_conditions / total_colonies,
      prevalence_present_disease = n_present_disease / total_colonies,
      prevalence_fast_disease = n_fast_disease / total_colonies,
      prevalence_slow_disease = n_slow_disease / total_colonies,
      prevalence_all_disease = total_disease_conditions / total_colonies
    ) %>%
    filter(!(total_bleaching_conditions == 0 & total_disease_conditions == 0)) %>%
    mutate(
      FontFace = ifelse(SPECIES_NAME %in% c("Acropora cervicornis", "Acropora palmata", "Dendrogyra cylindrus", 
                                            "Orbicella annularis", "Orbicella faveolata", "Orbicella franksi", 
                                            "Mycetophyllia ferox"), "bold.italic", "italic"),
      combined_label = paste(SPECIES_NAME, "(", total_colonies, ")", sep = "")
    )
  
  return(summary)
}