get_size_freq_years <- function(region){
  
  sampling_years <- switch(region,
                           "Flower Gardens" = c(2013, 2018, 2024),
                           "Southeast Florida" = c(2016, 2018, 2022),
                           "Florida Keys" = c(2016, 2018, 2022),
                           "Dry Tortugas" = c(2016, 2018, 2022),
                           "Puerto Rico" = c(2014, 2019, 2023),
                           "St Thomas, St John" = c(2013,2019, 2023),
                           "St Croix" = c(2015,2019, 2023),
                           NULL) 
  
  return(sampling_years)
}