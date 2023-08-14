## code to prepare `template` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "template/template-bison.xlsx"
)

sheets <- readxl::excel_sheets(path)
template <- lapply(sheets, function(x) readxl::read_excel(path, x))
names(template) <- sheets
usethis::use_data(template, overwrite = TRUE)
