library(tmap)
library(bcmaps)

tm_shape(health_ha()) +
  tm_fill(col = "HLTH_AUTHORITY_NAME")


tm_shape(census_division()) +
  tm_fill(col = "CENSUS_DIVISION_NAME")

str(iris)

iris_chr <- iris

iris_chr$Species <- as.character(iris_chr$Species)

all.equal(iris, iris_chr)



library(bcdata)
library(dplyr)
library(ggplot2)
library(plotly)

gj_school <- bcdc_get_data('dd2b0390-c77a-4c9f-b1bc-cb8d9f4a23c5', resource = '63e52d04-9431-44ea-93d4-5251e04a239c') %>%
  filter(DISTRICT_NAME == "Greater Victoria") %>%
  filter(!is.na(SCHOOL_NAME)) %>%
  rowwise() %>%
  mutate(avg_class_size = mean(c(AVG_CLASS_SIZE_K, AVG_CLASS_SIZE_1_3, AVG_CLASS_SIZE_4_7, AVG_CLASS_SIZE_8_12), na.rm = TRUE)) %>%
  mutate(school_size = TOTAL_CLASSES*avg_class_size) %>%
  select(SCHOOL_YEAR, SCHOOL_NAME, school_size) %>%
  filter(grepl("Elementary", SCHOOL_NAME))

gl_plot <- gj_school %>%
  ggplot(aes(x = SCHOOL_YEAR, y = school_size, colour = SCHOOL_NAME, group = SCHOOL_NAME)) +
  geom_line()

ggplotly(gl_plot)



bcdc_get_data("student-headcount-by-home-language", resource = '942d798d-4c38-4705-b62e-e9d7bc8c15b4')


foo %>%
  filter(SCHOOL_YEAR == "2020/2021", NUMBER_OF_STUDENTS != "Msk") %>%
  filter(DISTRICT_NAME == "Greater Victoria") %>%
  filter(!is.na(SCHOOL_NAME)) %>%
  filter(grepl("Elementary", SCHOOL_NAME)) %>%
  group_by(SCHOOL_NAME) %>%
  mutate(NUMBER_OF_STUDENTS = as.numeric(NUMBER_OF_STUDENTS)) %>%
  mutate(prop = NUMBER_OF_STUDENTS/sum(NUMBER_OF_STUDENTS)) %>%
  filter(TOP_10 == 2) %>%
  arrange(prop)


