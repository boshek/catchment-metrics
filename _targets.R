


library(targets)
library(tarchetypes)
# Read the tar_script() help file for details.

## Source all functions
source("R/setup.R")

## Load packages
tar_option_set(packages = .packages())



list(
  tar_target(elementary_boundaries, get_catchment_boundaries("elementary")),
  #tar_target(victoria_2018_income, get_taxfiler_data("TX2018", '59935', "28")),
  tar_target(median_income, summarise_by_school(boundaries = elementary_boundaries, "TX2018", '59935', "28")),
  tar_target(lone_parent_families, summarise_by_school(boundaries = elementary_boundaries, "TX2018", '59935', "720")),
  tar_target(ei_benefits, summarise_by_school(boundaries = elementary_boundaries, "TX2018", '59935', "36")),
  tar_target(li_gap_ratio, summarise_by_school(boundaries = elementary_boundaries, "TX2018", '59935', "354")),
  tar_target(language, map_df(c("563", "554"), ~{get_language_data("CA16", "59935", .x)}) %>%
               group_by(GeoUID) %>%
               mutate(prop = var/sum(var))),
  tar_target(language_by_school, elementary_boundaries %>%
               st_join(language) %>%
               st_drop_geometry() %>%
               mutate(vector = ifelse(vector == "563", "Not English or French", "English or French")) %>%
               group_by(School, vector) %>%
               summarise(mean_prop = mean(prop, na.rm = TRUE))),
  tar_target(school_popn_size, bcdc_get_data('dd2b0390-c77a-4c9f-b1bc-cb8d9f4a23c5',
                                             resource = '63e52d04-9431-44ea-93d4-5251e04a239c')),
  tar_render(catchment-metric-slides, "catchment-metric.Rmd")
)

# Output ------------------------------------------------------------------


## Pipeline

# list(
#   mcfd,
#   tar_render(mcfd_data_slides, "out/mcfd-data-slides/mcfd-data-slides.Rmd")
# )



