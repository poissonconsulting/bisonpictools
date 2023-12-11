## code to prepare `bpt_proportion_calf_data` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "example-data/data-raw.xlsx"
)

sheets <- readxl::excel_sheets(path)
bpt_proportion_calf_data <- readxl::read_excel(path, 4)
usethis::use_data(bpt_proportion_calf_data, overwrite = TRUE)