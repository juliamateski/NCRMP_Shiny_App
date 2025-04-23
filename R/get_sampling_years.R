get_sampling_years <- function(region){
  
  sampling_years <- switch(region,
                           "Southeast Florida" = c(2014,2016,2018,2020,2022),
                           "Florida Keys" = c(2014,2016,2018,2020,2022),
                           "Dry Tortugas" = c(2014,2016,2018,2020),
                           "Flower Gardens" = c(2013,2015,2018,2024),
                           "Puerto Rico" = c(2014,2016,2019,2021,2023),
                           "St Thomas, St John" = c(2013,2015,2017,2019,2021, 2023),
                           "St Croix" = c(2015,2017,2019,2021, 2023)
  )
  return(sampling_years)
}