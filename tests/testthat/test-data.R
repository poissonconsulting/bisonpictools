test_that("confirm template saved in data is the same as the excel file", {
  path <- system.file(
    package = "bisonpictools",
    "template/template-bison.xlsx"
  )
  sheets <- readxl::excel_sheets(path)
  template_excel <- lapply(sheets, function(x) readxl::read_excel(path, x))
  names(template_excel) <- sheets
  
  expect_identical(template, template_excel)
})

test_that("confirm template is a list with two data frames in it", {
  expect_identical(length(template), 2L)
  expect_type(template, "list")
  expect_s3_class(template[[1]], c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(template[[2]], c("tbl_df", "tbl", "data.frame"))  
})
