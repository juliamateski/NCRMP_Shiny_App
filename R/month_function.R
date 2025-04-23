month_function <- function(region, year){

# Fetch the region data and filter for the selected year
region_data <- get_bleach_disease_data(region) %>%
  filter(YEAR == year)

#get unique months
months_1 <- unique(region_data$MONTH)

#Sort months numerically
months_1_sorted <- sort(months_1)

#if months are bigger than 0:
if (length(months_1_sorted) > 0) {
  
  # Create a named vector mapping month numbers to month names (1 = January, 12 = December)
  month_map <- setNames(1:12, month.name)  # Mapping from month number to month name
  
  # Convert numeric month values to month names (from the sorted months)
  months_names <- month.name[months_1_sorted]
  
  # Create the checkbox group input for selecting months
  checkboxGroupInput("month_choice", "Pick Month(s):",
                     choices = months_names,  # Display month names in checkboxes
                     selected = months_names,  # Default selection (all months selected)
                     inline = TRUE)  # Optional: Display checkboxes horizontally (side by side)
} 
else {
  return("No data available for the selected region and year.")
}

}