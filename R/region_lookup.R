region_lookup <- function(region) {
  region <- case_when(
    region == "Southeast Florida" ~ "SEFCRI",
    region == "Florida Keys" ~ "FLK",
    region == "Dry Tortugas" ~ "Tortugas",
    region == "Flower Gardens" ~ "FGB",
    region == "Puerto Rico" ~ "PRICO",
    region == "St. Thomas & St. John" ~ "STTSTJ",
    region == "St. Croix" ~ "STX"
  )
  
  return(region)
}