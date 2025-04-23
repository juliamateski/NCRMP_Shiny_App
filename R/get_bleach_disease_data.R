get_bleach_disease_data <- function(region){


    
    # PRICO Data
    prico_demo <- bind_rows(
      PRICO_2023_coral_demographics,
      PRICO_2021_coral_demographics,
      PRICO_2019_coral_demographics,
      PRICO_2016_coral_demographics,
      PRICO_2014_coral_demographics
    ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # Tortugas Data
    tort_demo <- bind_rows(
      Tortugas_2022_coral_demographics,
      Tortugas_2020_coral_demographics,
      Tortugas_2018_coral_demographics,
      TortugasMarq_2016_coral_demographics,
      TortugasMarq_2014_coral_demographics
    ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # FGBNMS Data
    fgbnms_demo <- bind_rows(FGBNMS_2013_coral_demographics %>% mutate(MAPGRID_NR = as.numeric(MAPGRID_NR)), 
                             FGBNMS_2015_coral_demographics %>% mutate(MAPGRID_NR = as.numeric(MAPGRID_NR)), 
                             FGBNMS_2018_coral_demographics %>% mutate(MAPGRID_NR = as.numeric(MAPGRID_NR)), 
                             FGBNMS_2022_coral_demographics %>% mutate(MAPGRID_NR = as.numeric(MAPGRID_NR)), 
                             FGBNMS_2024_coral_demographics %>% mutate(MAPGRID_NR = as.numeric(MAPGRID_NR)), ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # USVI Data
    usvi_demo <- bind_rows(
      USVI_2023_coral_demographics,
      USVI_2021_coral_demographics,
      USVI_2019_coral_demographics,
      USVI_2017_coral_demographics,
      USVI_2015_coral_demographics
    ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # FLK Data
    flk_demo <- bind_rows(
      
      FLK_2022_coral_demographics,
      FLK_2020_coral_demographics,
      FLK_2018_coral_demographics,
      FLK_2016_coral_demographics,
      FLK_2014_coral_demographics
    ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # SEFCRI Data
    sefcri_demo <- bind_rows(
      SEFCRI_2022_coral_demographics,
      SEFCRI_2020_coral_demographics,
      SEFCRI_2018_coral_demographics,
      SEFCRI_2016_coral_demographics
    ) %>%
      select(SPECIES_NAME, SPECIES_CD, YEAR, BLEACH_CONDITION, DISEASE, MONTH, DAY, N, JUV, REGION) %>%
      filter(!is.na(BLEACH_CONDITION))
    
    # Switch statement to choose the correct dataset based on the region
    bleach_disease_dataset <- switch(region,
                     "Puerto Rico" = prico_demo,
                     "Southeast Florida" = sefcri_demo,
                     "Florida Keys" = flk_demo,
                     "Dry Tortugas" = tort_demo,
                     "Flower Gardens" = fgbnms_demo,
                     "St Thomas, St John" = usvi_demo,
                     "St Croix" = usvi_demo,
                     
    )
    

return(bleach_disease_dataset)
}