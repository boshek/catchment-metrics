


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
  tar_render(catchment-metric-slides, "catchment-metric.Rmd")
)

# Output ------------------------------------------------------------------


## Pipeline

# list(
#   mcfd,
#   tar_render(mcfd_data_slides, "out/mcfd-data-slides/mcfd-data-slides.Rmd")
# )



