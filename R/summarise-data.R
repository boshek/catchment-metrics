
summarise_by_school <- function(boundaries, ...) {
  t1 <- get_taxfiler_data(...)

  boundaries %>%
    st_join(t1) %>%
    st_drop_geometry() %>%
    group_by(School)
}
