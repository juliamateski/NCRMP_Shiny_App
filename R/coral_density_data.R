coral_density_data <- function(region) {
  switch(region,
         "Puerto Rico" = NCRMP_PRICO_Occ_Den_CV,
         "St. Thomas & St. John" = NCRMP_STTSTJ_Occ_Den_CV, 
         "St. Croix" = NCRMP_STX_Occ_Den_CV,
         "Southeast Florida" = NCRMP_DRM_SEFCRI_Occ_Den_CV,
         "Florida Keys" = NCRMP_DRM_FLK_Occ_Den_CV,
         "Dry Tortugas" = NCRMP_DRM_Tort_Occ_Den_CV,
         "Flower Gardens" = NCRMP_FGBNMS_Occ_Den_CV
  ) 
  
}