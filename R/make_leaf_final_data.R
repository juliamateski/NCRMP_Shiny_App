
make_leaf_final_data <- function(region){
  
  region_leaf_sources <- make_region_leaf_data()
  
  habitat_lookup <- make_habitat_data() 
  
  src <- region_leaf_sources[[region]]
  
  leaf_final_data <- full_join(src$density, src$cover) %>%
    distinct(PRIMARY_SAMPLE_UNIT, .keep_all = TRUE) %>%
    select(REGION, PRIMARY_SAMPLE_UNIT, YEAR, HABITAT_CD, LAT_DEGREES, LON_DEGREES, DENSITY, avCvr) %>%
    mutate(across(c(LAT_DEGREES, LON_DEGREES), as.numeric)) %>%
    left_join(habitat_lookup, by = c("REGION", "HABITAT_CD"))
  
  return(leaf_final_data)
}
