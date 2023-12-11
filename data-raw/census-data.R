## code to prepare `bpt_census_data` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "example-data/data-raw.xlsx"
)

sheets <- readxl::excel_sheets(path)
bpt_census_data <- readxl::read_excel(path, 3)
usethis::use_data(bpt_census_data, overwrite = TRUE)
