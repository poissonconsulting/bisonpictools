# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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

  expect_identical(data_excel$location, location_data)
  expect_identical(data_excel$event, event_data)
  expect_identical(data_excel$census, census_data)
  expect_identical(data_excel$proportion_calf, proportion_calf_data)
})

test_that("confirm event_data is a tibble", {
  expect_s3_class(event_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm location_data is a tibble", {
  expect_s3_class(location_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm census_data is a tibble", {
  expect_s3_class(census_data, c("tbl_df", "tbl", "data.frame"))
})

test_that("confirm proportion_calf_data is a tibble", {
  expect_s3_class(proportion_calf_data, c("tbl_df", "tbl", "data.frame"))
})
