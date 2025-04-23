
library(shinydashboard)
library(shiny)
library(plotly)
library(tidyverse)
library(ncrmp.benthics.analysis)
library(ggplot2)
library(cowplot)
library(gridExtra)
library(egg)
library(leaflet)
library(leaflet.extras)



source("/Users/juliamateski/NCRMP_Shiny_App/R/year_selector_function.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/generateRegionPlot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/region_leaf_sources.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_leaf_final_data.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_habitat_data.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/renderLeafletMap.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/get_sampling_years.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_dens_size_plot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/get_size_freq_years.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/region_lookup.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/theme_Publication.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/abbreviate_species_name.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/get_year_bleach_data.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_bleach_year_plot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/coral_density_data.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_coral_density_plot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_photo_path.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/plot_coral_demographics.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/get_bleach_disease_data.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/month_function.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_bleach_disease_summary.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_bleach_by_species_plot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/make_disease_by_species_plot.R")
source("/Users/juliamateski/NCRMP_Shiny_App/R/size_freq_species.R")



ui <- dashboardPage(
  
  # Dashboard header
  dashboardHeader(title = "Data Explorer"),
  
  # Dashboard sidebar with menu items
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Single Species Analysis", tabName = "size_frequency"),
      menuItem("Bleaching and Disease", tabName = "bleaching"),
      menuItem("Benthic Community Assessment", tabName = "benthic_cover"),
      menuItem("Coral Demographic Data", tabName = "coral_demographics"),
      menuItem("Sampling Map", tabName = "leaflet"),
      
      
      
      conditionalPanel(
        condition = 'input.tabs == "size_frequency"', 
        selectInput("freq_region", "Select Region:", 
                    choices = c("Southeast Florida", "Florida Keys", "Dry Tortugas", "Flower Gardens", "Puerto Rico", "St. Thomas & St. John", "St. Croix"),
                    selected = "Puerto Rico"),
        uiOutput("speciesSizeFreq") 
      ),
      
      
      
      
      conditionalPanel(
        condition = 'input.tabs == "benthic_cover"',
        checkboxGroupInput("cover", "choose cover", choices = c("CCA", "HARD CORALS", "MACROALGAE", "RAMICRUSTA SPP.", "SOFT CORALS", "SPONGES", "TURF ALGAE", "OTHER"), selected = c("HARD CORALS", "MACROALGAE")),
        sliderInput("year", "Select Year:", min = 2014, max = 2023, value = c(2014, 2023), step = 1),
        checkboxGroupInput("region", "Region", choices = c("Dry Tortugas", "Southeast Florida", "Florida Keys", "Flower Gardens", "Puerto Rico", "St Thomas St John", "St Croix"), selected = c("Dry Tortugas", "Southeast Florida", "Florida Keys", "Flower Gardens", "Puerto Rico", "St Thomas, St John", "St Croix")),
      ),
      
      
      conditionalPanel(
        condition = 'input.tabs == "coral_demographics"',
        checkboxGroupInput("coral_species", "Coral Species", choices = c(
          "Acropora cervicornis",
          "Acropora palmata",
          "Orbicella annularis",
          "Orbicella franksi",
          "Orbicella faveolata",
          "Meandrina meandrites",
          "Dendrogyra cylindrus",
          "Pseudodiploria strigosa",
          "Diploria labyrinthiformis",
          "Colpophyllia natans",
          "Siderastrea siderea",
          "Porites astreoides",
          "Montastraea cavernosa",
          "Agaricia agaricites",
          "Stephanocoenia intersepta"
        ), selected = c(
          "Porites astreoides",
          "Montastraea cavernosa",
          "Orbicella faveolata")),
        selectInput("coral_year", "Year", choices = c( 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023), selected = 2022),
        
        selectInput("coral_region", "Region", choices = c("Dry Tortugas", "Southeast Florida", "Florida Keys", "Flower Gardens", "Puerto Rico", "St Thomas, St John", "St Croix"), selected = "Dry Tortugas")
      ),
      
      
      conditionalPanel(
        condition = 'input.tabs == "leaflet"', 
        selectInput("map_region", "Select Region:",
                    choices = c("Southeast Florida", "Florida Keys", "Dry Tortugas", "Flower Gardens", "Puerto Rico", "St Thomas, St John", "St Croix"),
                    selected = "Florida Keys"),
        uiOutput("year_selector")
  
        
      ),
      conditionalPanel(
        condition = 'input.tabs == "bleaching"', 
        selectInput("health_region", "Select Region:", 
                    choices = c("Southeast Florida", "Florida Keys", "Dry Tortugas", 
                                "Flower Gardens", "Puerto Rico", "St Thomas, St John", 
                                "St Croix"), selected = "FLK"),
        uiOutput("health_year"),
        # selectInput("health_year", "Select Year", 
        #             choices = c(2013:2024), selected = 2022),
        
        uiOutput("month_choice"),
        uiOutput("speciesSelect")  
      )
    )
  ),
  
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
      body {
        font-family: 'Segoe UI', sans-serif;
      }
      .sidebar-menu > li > a {
        font-size: 13px;
      }
      .box-title {
        font-weight: bold;
      }
      .box {
        padding: 15px;
        margin-bottom: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      }
      .skin-blue .main-header .navbar {
        background-color: #004c6d;
      }
      h2, h3, h4 {
        font-family: 'Segoe UI', sans-serif;
        color: #004c6d;
        margin-top: 10px;
      }
      .sidebar-menu > li.active > a {
        background-color: #004c6d !important;
        color: white !important;
        font-weight: bold;
      }
      body, .content-wrapper {
        font-size: 12px;
        line-height: 1.6
      }
      .sidebar-menu > li > a:hover {
        background-color: #004c6d;
        color: #000;
      }
      .selectize-input, .checkbox, .radio {
        margin-bottom: 12px;
      }
    "))
    ),
    tabItems(
      
      tabItem(
        tabName = "size_frequency",
        fluidRow(
          box(
            title = uiOutput("dynamic_title"), 
            width = 5, 
            status = "primary", 
            
            textOutput("text"),
            imageOutput("landingPageImage")
          ),
          
          box(
            title = "Size Frequency", 
            status = "warning", 
            width = 7,
            plotOutput("size_freq")
          )
        ),
        
        fluidRow(
          column(
            width = 6,
            box(
              title = "Density", 
              width = NULL, 
              solidHeader = TRUE, 
              status = "primary",
              " ",
              plotOutput("coral_density")
            ),
            # box(
            #   width = NULL, 
            #   background = "black",
            #   "A box with a solid black background",
            #   
            # )
          ),
          
          column(
            width = 6,
            box(
              title = "Bleaching", 
              width = NULL, 
              solidHeader = TRUE, 
              status = "warning",
              " ",
              plotOutput("coral_bleaching_page_1")
            ),
            # box(
            #   title = "Title 5", 
            #   width = NULL, 
            #   background = "light-blue",
            #   "A box with a solid light-blue background"
            # )
          ),
          
          # column(
          #   width = 4,
          #   box(
          #     title = "Title 2", 
          #     width = NULL, 
          #     solidHeader = TRUE,
          #     "Box content"
          #   ),
          #   box(
          #     title = "Title 6", 
          #     width = NULL, 
          #     background = "maroon",
          #     "A box with a solid maroon background"
          #   )
          # )
        )
      ),
      
      # Bleaching and Disease Tab
      tabItem(
        tabName = "bleaching",
        h2("Bleaching and Disease"),
        fluidRow(
          p("Bleaching Reported for Selected Months"),
          plotOutput("bleach"),
          p("Disease Reported for ENTIRE YEAR"),
          plotOutput("disease"),
          
        )
      ),
      
      # Benthic Cover Tab
      tabItem(
        tabName = "benthic_cover",
        h2("% Cover of Benthic Communities"),
        fluidRow(
          uiOutput("region_plots_ui"),
          p("Overall cover (%) for benthic cover type for each region from NCRMP surveys. Statistical significance (Tukey’s two-tailed t-test), if present, is reported at p <0.05, and different letters (e.g., a and b) denote a difference between survey years. SE = standard error.")
        )
      ),
      
      # Coral Demographics Tab
      tabItem(
        tabName = "coral_demographics",
        h2("Coral Demographics"),
        fluidRow(
          plotOutput("coral_demo_plot"),
          p("Mean density of corals (colonies/m²), maximum diameter (cm), percentage of old mortality (%), and percentage of recent mortality (%) by coral species. Species are ordered in terms of decreasing density, and only species with densities above 0.01 are included.")
        )
      ),
      
      # Leaflet Tab
      tabItem(
        tabName = "leaflet",
        h2("Leaflet"),
        fluidRow(
          p("Map of coral data by region and year input"),
          leafletOutput("map")
        )
      )
    )
  )
  
)


server <- function(input, output, session) {
  
  output$region_plots_ui <- renderUI({
    req(input$region)
  
    #loop through all the inputed regions and build the box
    plot_boxes <- lapply(input$region, function(region) {
      box(
        title = region,
        status = "primary",
        width = 6, 
        plotOutput(outputId = tolower(paste0(gsub(" ", "_", region), "_plot"))) #gsub replace space w _
      )
    })
  
    do.call(fluidRow, plot_boxes)
  })
  
  
  
  output$dry_tortugas_plot <- renderPlot({
    
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("Dry Tortugas" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_Tort_2014_22_cover_region %>% dplyr::mutate(YEAR = ifelse(YEAR == 2020, 2021, as.numeric(YEAR)))
      
      generateRegionPlot(region_data, selected_years, "Dry Tortugas", selected_covers)
    }
  })
  

  output$flower_gardens_plot <- renderPlot({
    
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("Flower Gardens" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_FGBNMS_2013_24_cover_region %>% dplyr::mutate(YEAR = ifelse(YEAR == 2020, 2021, as.numeric(YEAR)))
      
      generateRegionPlot(region_data, selected_years, "Flower Gardens", selected_covers)
    }
  })
  
  
  output$puerto_rico_plot <- renderPlot({
    
    
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("Puerto Rico" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_PRICO_2014_23_cover_region %>% dplyr::mutate(YEAR = ifelse(YEAR == 2020, 2021, as.numeric(YEAR)))
      
      generateRegionPlot(region_data, selected_years, "Puerto Rico", selected_covers)
    }
  })
  
  output$st_thomas_st_john_plot <- renderPlot({
    
    
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("St Thomas, St John" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_STTSTJ_2013_23_cover_region %>% dplyr::mutate(YEAR = ifelse(YEAR == 2020, 2021, as.numeric(YEAR)))
      
      generateRegionPlot(region_data, selected_years, "St Thomas, St John", selected_covers)
    }
  })
  
  output$st_croix_plot <- renderPlot({
    
    
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("St Croix" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_STX_2015_23_cover_region %>% dplyr::mutate(YEAR = ifelse(YEAR == 2020, 2021, as.numeric(YEAR)))
      
      generateRegionPlot(region_data, selected_years, "St Croix", selected_covers)
    }
  })
  
  
  output$southeast_florida_plot <- renderPlot({
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("Southeast Florida" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_SEFCRI_2014_22_cover_region
      
      generateRegionPlot(region_data, selected_years, "Southeast Florida", selected_covers)
    }
  })
  
  output$florida_keys_plot <- renderPlot({
    selected_regions <- input$region
    selected_covers <- input$cover
    
    if ("Florida Keys" %in% selected_regions) {
      selected_years <- as.character(input$year[1]:input$year[2])
      
      region_data <- NCRMP_FLK_2014_22_cover_region %>% filter(YEAR != 2020)
      
      generateRegionPlot(region_data, selected_years, "Florida Keys", selected_covers)
    }
  })
  
  
 
  renderLeafletMap(input, output, session)
  
  
  output$year_selector <- renderUI({
    
    req(input$map_region) 
    sampling_years <- get_sampling_years(input$map_region)
    
    selectInput("year_selector", "Select Year(s)", choices = sampling_years, selected = last(sampling_years))
  })
  
  
  output$health_year <- renderUI({
    
    req(input$map_region) 
    sampling_years <- get_sampling_years(input$health_region)
    
    selectInput("health_year", "Select Year(s)", choices = sampling_years, selected = last(sampling_years))
  })
  
  
  
  output$speciesSizeFreq <- renderUI({
    req(input$freq_region)
    region <- input$freq_region
    species_choices <- size_freq_species(region)
    selectInput("speciesSizeFreq", "Select Species:", choices = species_choices)
  })
  
  
  output$size_freq <- renderPlot({
    
    region <- input$freq_region
    species <- input$speciesSizeFreq
    make_dens_size_plot(region, species)
    
  })
  

  
  output$coral_bleaching_page_1 <- renderPlot({
    
    region <- input$freq_region
    
    species <- input$speciesSizeFreq
    
    make_bleach_year_plot(region, species)
    
  })
  
  
  output$coral_density <- renderPlot({
    req(input$freq_region)
    req(input$speciesSizeFreq) 
    
    species <- input$speciesSizeFreq
    
    region <- input$freq_region
    
    make_coral_density_plot(region, species)
    
  })
  
  
  output$landingPageImage <- renderImage({
    
    req(input$speciesSizeFreq)
    selected_species <- input$speciesSizeFreq
    
    image_path <- make_photo_path(selected_species)
    
    list(
      src = image_path,
      contentType = "image/png",
      alt = selected_species,
      height = "100%", 
      width = "100%",   
      style = "object-fit: contain;"  
    )
    
  }, deleteFile = FALSE)  # Do not delete the file after rendering
  
  
  
  
  
  output$speciesSelect <- renderUI({
    req(input$health_region)  # Require the selection of a health region
    
    # Determine the choices based on the selected health region
    choices <- switch(input$health_region,
                      "Southeast Florida" = c("Stephanocoenia intersepta", "Siderastrea siderea", "Orbicella faveolata", "Siderastrea radians", "Meandrina meandrites", "Pseudodiploria strigosa", "Porites divaricata", "Solenastrea hyades", "Agaricia lamarcki", "Montastraea cavernosa", "Agaricia agaricites", "Porites astreoides", "Oculina diffusa", "Colpophyllia natans", "Solenastrea bournoni", "Dichocoenia stokesii", "Porites porites", "Pseudodiploria clivosa", "Acropora cervicornis", "Agaricia fragilis", "Madracis auretenra", "Diploria labyrinthiformis", "Eusmilia fastigiata", "Orbicella franksi", "Favia fragum", "Madracis decactis", "Porites furcata", "Mycetophyllia aliciae"),
                      "Florida Keys" = c("Agaricia agaricites", "Siderastrea radians", "Porites divaricata", "Porites porites", "Helioceris cucullata", "Siderastrea siderea", "Agaricia humilis", "Porites furcata", "Eusmilia fastigiata", "Solenastrea bournoni", "Stephanocoenia intersepta", "Porites astreoides", "Agaricia lamarcki", "Orbicella franksi", "Montastraea cavernosa", "Diploria labyrinthiformis", "Agaricia fragilis", "Manicina areolata", "Orbicella faveolata", "Scolymia cubensis", "Pseudodiploria strigosa", "Porites branneri", "Dichocoenia stokesii", "Solenastrea hyades", "Orbicella annularis", "Colpophyllia natans", "Meandrina meandrites", "Oculina spp", "Madracis auretenra", "Madracis decactis", "Mycetophyllia aliciae", "Pseudodiploria clivosa", "Acropora cervicornis"),
                      "Dry Tortugas" = c("Agaricia agaricites", "Siderastrea siderea", "Orbicella faveolata", "Orbicella franksi", "Montastraea cavernosa", "Porites divaricata", "Porites porites", "Agaricia fragilis", "Porites furcata", "Pseudodiploria clivosa", "Pseudodiploria strigosa", "Mycetophyllia aliciae", "Siderastrea radians", "Stephanocoenia intersepta", "Agaricia humilis", "Eusmilia fastigiata", "Agaricia lamarcki", "Diploria labyrinthiformis", "Porites astreoides", "Dichocoenia stokesii", "Acropora cervicornis", "Colpophyllia natans", "Solenastrea bournoni", "Madracis decactis", "Meandrina meandrites", "Helioceris cucullata", "Orbicella annularis"),
                      "Flower Gardens" = c("Agaricia agaricites", "Agaricia fragilis", "Agaricia humilis", "Colpophyllia natans", "Helioceris cucullata", "Madracis auretenra", "Madracis decactis", "Meandrina meandrites", "Montastraea cavernosa", "Mussa angulosa", "Orbicella annularis", "Orbicella faveolata", "Orbicella franksi", "Porites astreoides", "Pseudodiploria strigosa", "Scolymia cubensis", "Siderastrea siderea", "Stephanocoenia intersepta", "Tubastraea coccinea"),
                      "Puerto Rico" = c("Acropora cervicornis", "Acropora palmata", "Agaricia agaricites", "Agaricia fragilis", "Agaricia grahamae", "Agaricia humilis", "Agaricia lamarcki", "Agaricia tenuifolia", "Colpophyllia natans", "Dendrogyra cylindrus", "Dichocoenia stokesii", "Diploria labyrinthiformis", "Eusmilia fastigiata", "Favia fragum", "Helioceris cucullata", "Madracis auretenra", "Madracis decactis", "Manicina areolata", "Meandrina danae", "Meandrina jacksoni", "Meandrina meandrites", "Montastraea cavernosa", "Mycetophyllia aliciae", "Mycetophyllia ferox", "Oculina diffusa", "Orbicella annularis", "Orbicella faveolata", "Orbicella franksi", "Porites astreoides", "Porites branneri", "Porites divaricata", "Porites furcata", "Porites porites", "Pseudodiploria clivosa", "Pseudodiploria strigosa", "Scolymia cubensis", "Siderastrea radians", "Siderastrea siderea", "Solenastrea bournoni", "Stephanocoenia intersepta"),
                      "St Thomas, St John" = c("Acropora cervicornis", "Acropora palmata", "Agaricia agaricites", "Agaricia fragilis", "Agaricia grahamae", "Agaricia humilis", "Agaricia lamarcki", "Agaricia tenuifolia", "Colpophyllia natans", "Dendrogyra cylindrus", "Dichocoenia stokesii", "Diploria labyrinthiformis", "Eusmilia fastigiata", "Favia fragum", "Helioceris cucullata", "Isophyllia sinuosa", "Madracis auretenra", "Madracis carmabi", "Madracis decactis", "Madracis formosa", "Manicina areolata", "Meandrina meandrites", "Montastraea cavernosa", "Mycetophyllia aliciae", "Orbicella annularis", "Orbicella faveolata", "Orbicella franksi", "Porites astreoides", "Porites colonensis", "Porites divaricata", "Porites furcata", "Porites porites", "Pseudodiploria clivosa", "Pseudodiploria strigosa", "Siderastrea radians", "Siderastrea siderea", "Solenastrea bournoni", "Stephanocoenia intersepta"),
                      "St Croix" = c("Acropora palmata", "Agaricia agaricites", "Agaricia fragilis", "Agaricia grahamae", "Agaricia humilis", "Agaricia lamarcki", "Agaricia tenuifolia", "Colpophyllia natans", "Dichocoenia stokesii", "Diploria labyrinthiformis", "Eusmilia fastigiata", "Favia fragum", "Helioceris cucullata", "Isophyllastrea rigida", "Isophyllia sinuosa", "Madracis auretenra", "Madracis decactis", "Madracis formosa", "Manicina areolata", "Meandrina meandrites", "Montastraea cavernosa", "Mycetophyllia aliciae", "Orbicella annularis", "Orbicella faveolata", "Orbicella franksi", "Porites astreoides", "Porites branneri", "Porites colonensis", "Porites divaricata", "Porites furcata", "Porites porites", "Pseudodiploria clivosa", "Pseudodiploria strigosa", "Siderastrea radians", "Siderastrea siderea", "Solenastrea bournoni", "Stephanocoenia intersepta")
    )
    
    checkboxGroupInput("speciesSelect", "Select Species:", choices)
  })
  
  
  
  
  output$month_choice <- renderUI({
    
    region <- input$health_region
    year = input$health_year
    
    month_function(region, year)
  })
  
  
  

  
  output$bleach <- renderPlot({

    req(input$month_choice) 

    month_final <- as.numeric(match(input$month_choice, month.name)) 
  
    region <- input$health_region
    
    dataset <- get_bleach_disease_data(region) %>%
      filter(SPECIES_NAME %in% input$speciesSelect) %>%
      filter(YEAR == input$health_year) %>%
      filter(MONTH %in% month_final)  
    
    summary <- make_bleach_disease_summary(region, dataset)
    
    make_bleach_by_species_plot(region, summary)
  
  })
  
  
  output$disease <- renderPlot({
    
    req(input$health_region, input$health_year, input$speciesSelect)

    month_final <- as.numeric(match(input$month_choice, month.name)) 
    
    region <- input$health_region

    
    dataset <- get_bleach_disease_data(region) %>%
      filter(SPECIES_NAME %in% input$speciesSelect) %>%
      filter(YEAR == input$health_year) %>%
      filter(MONTH %in% month_final)  
    
    summary <- make_bleach_disease_summary(region, dataset)
    
    make_disease_by_species_plot(region, summary)
    
  })
  
  output$coral_demo_plot <- renderPlot({
    
    region <- input$coral_region
      
    project <- "NCRMP"
    
    if (region %in% c("Southeast Florida", "Florida Keys", "Dry Tortugas")){ project <- "NCRMP_DRM"}
      
    species_list <- input$coral_species
      
    year <- input$coral_year
    
    weighted_means <- coral_density_data(region)
    
    old_mort <- NCRMP_DRM_calculate_mortality(region = region_lookup(region), project = project)
    
    old_mort_spp <- old_mort$Domain_est_old_mort_species
    
    rec_mort_spp <- old_mort$Domain_est_rec_mort_species
    
    mean_col_size <- NCRMP_DRM_calculate_mean_colony_size(region = region_lookup(region), project = project)
    
    size_spp <- mean_col_size$Domain_est_species
    
    plot_coral_demographics(region_lookup(region), year, weighted_means, old_mort_spp, size_spp, rec_mort_spp, species_list) 
    
  })
  
  
  
  
} #end server


shinyApp(ui = ui, server = server)
