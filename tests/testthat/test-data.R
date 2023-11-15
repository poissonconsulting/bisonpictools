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

test_that("confirm template is a list with four data frames in it", {
  expect_identical(length(template), 4L)
  expect_type(template, "list")
  expect_s3_class(template[[1]], c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(template[[2]], c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(template[[3]], c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(template[[4]], c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm raw data is the same as the excel file", {
  path <- system.file(
    package = "bisonpictools",
    "example-data/data-raw.xlsx"
  )
  sheets <- readxl::excel_sheets(path)
  data_excel <- lapply(sheets, function(x) readxl::read_excel(path, x))
  names(data_excel) <- sheets

  expect_identical(data_excel$location, bpt_location_data)
  expect_identical(data_excel$event, bpt_event_data)
  expect_identical(data_excel$census, bpt_census_data)
  expect_identical(data_excel$proportion_calf, bpt_proportion_calf_data)
})

test_that("confirm bpt_event_data is a tibble", {
  expect_s3_class(bpt_event_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm bpt_location_data is a tibble", {
  expect_s3_class(bpt_location_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm bpt_census_data is a tibble", {
  expect_s3_class(bpt_census_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm bpt_proportion_calf_data is a tibble", {
  expect_s3_class(bpt_proportion_calf_data, c("tbl_df", "tbl", "data.frame"))
})

