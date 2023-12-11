## code to prepare `bpt_event_data` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "example-data/data-raw.xlsx"
)

sheets <- readxl::excel_sheets(path)
bpt_event_data <- readxl::read_excel(path, 2)
usethis::use_data(bpt_event_data, overwrite = TRUE)
