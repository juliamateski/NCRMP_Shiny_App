abbreviate_species_name <- function(full_name) {
  parts <- strsplit(full_name, " ")[[1]]
  if (length(parts) < 2) return(NA)
  
  genus <- toupper(substr(parts[1], 1, 3))
  species <- toupper(substr(parts[2], 1, 4))
  
  paste(genus, species)
}