make_region_leaf_data <- function() {
  list(
    'Southeast Florida' = list(density = NCRMP_SEFCRI_2014_22_density_site, cover = NCRMP_SEFCRI_2014_22_cover_region),
    'Dry Tortugas' = list(density = NCRMP_Tort_2014_22_density_site, cover = NCRMP_Tort_2014_22_cover_region),
    'Florida Keys' = list(density = NCRMP_FLK_2014_22_density_site, cover = NCRMP_FLK_2014_22_cover_region),
    "Flower Gardens" = list(density = NCRMP_FGBNMS_2013_24_density_site, cover = NCRMP_FGBNMS_2013_24_cover_region),
    "Puerto Rico" = list(density = NCRMP_PRICO_2014_23_density_site, cover = NCRMP_PRICO_2014_23_cover_region),
    "St Thomas, St Johns" = list(density = NCRMP_STTSTJ_2013_23_density_site, cover = NCRMP_STTSTJ_2013_23_cover_region),
    "St Croix" = list(density = NCRMP_STX_2015_23_density_site, cover = NCRMP_STX_2015_23_cover_region)
  )
}
