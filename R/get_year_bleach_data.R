get_year_bleach_data <- function(region_2) {
  
  switch(region_2,
         "Puerto Rico" = NCRMP_PRICO_2014_23_ble_prev_species_region,
         "St Thomas, St John" = NCRMP_STTSTJ_2013_23_ble_prev_species_region, 
         "St Croix" = NCRMP_STX_2015_23_ble_prev_species_region,
         "Southeast Florida" = NCRMP_DRM_SEFCRI_2014_22_ble_prev_species_region,
         "Florida Keys" = NCRMP_DRM_FLK_2014_22_ble_prev_species_region,
         "Dry Tortugas" = NCRMP_DRM_Tort_2014_22_ble_prev_species_region,
         "Flower Gardens" = NCRMP_FGBNMS_2013_24_ble_prev_species_region,
  ) 
  
}