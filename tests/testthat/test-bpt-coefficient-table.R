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

analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

coef_table <- bpt_coefficient_table(analysis)

test_that("returns a tibble", {
  expect_s3_class(coef_table, c("tbl_df", "tbl", "data.frame"))
})

test_that("coefficient table has correct column names", {
  expect_identical(
    names(coef_table),
    c("term", "estimate", "lower", "upper", "svalue")
  )
})

test_that("there are no NAs in coefficient table", {
  expect_false(any(is.na(coef_table)))
})

test_that("lower CI is less that estimate", {
  expect_true(all(coef_table$lower <= coef_table$estimate))
})

test_that("upper CI is greater than estimate", {
  expect_true(all(coef_table$upper >= coef_table$estimate))
})
