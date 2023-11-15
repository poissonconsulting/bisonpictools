## code to prepare `bpt_event_data` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "example-data/data-raw.xlsx"
)

sheets <- readxl::excel_sheets(path)

bpt_location_data <- readxl::read_excel(path, 1)
bpt_event_data <- readxl::read_excel(path, 2)
bpt_census_data <- readxl::read_excel(path, 3)
bpt_proportion_calf_data <- readxl::read_excel(path, 4)

usethis::use_data(bpt_location_data, overwrite = TRUE)
usethis::use_data(bpt_event_data, overwrite = TRUE)
usethis::use_data(bpt_census_data, overwrite = TRUE)
usethis::use_data(bpt_proportion_calf_data, overwrite = TRUE)