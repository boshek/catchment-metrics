
## From school district
get_catchment_boundaries <- function(level) {
  if (level == "elementary") {
    school_data <- httr::content(
      httr::GET(
        "https://www.arcgis.com/sharing/rest/content/items/b99a3887b72c42d2a7cfe8e06be61320/data?f=geojson")
    )
  }
  school_polys <- esri2sf:::esri2sfPolygon(school_data$layers[[1]]$featureSet$features)
  sf::st_crs(school_polys) <- school_data$layers[[1]]$layerDefinition$extent$spatialReference$latestWkid

  purrr::map_dfr(school_data$layers[[1]]$featureSet$features, "attributes") %>%
    dplyr::mutate(geometry = school_polys) %>%
    st_as_sf() %>%
    transform_bc_albers() %>%
    filter(is.na(Label), !grepl("SD63|SD62", School))
}


## CensusMapper
get_taxfiler_data <- function(dataset, CMA, vector) {
  get_census(dataset = dataset, regions=list(CMA = CMA), vectors = c("var" = glue::glue('v_{dataset}_{vector}')),
             geo_format = 'sf', level=c("CT"), quiet = TRUE) %>%
    transform_bc_albers() %>%
    mutate(year = gsub("TX","",dataset))
}


