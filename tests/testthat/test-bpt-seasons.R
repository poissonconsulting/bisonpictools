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

test_that("seasons returns tibble with expected start and end daytes", {
  expect_equal(bpt_seasons(), dplyr::tribble(
    ~season, ~start_dayte, ~end_dayte,
    "Calving", "1972-04-01 00:00:00", "1972-06-30 23:59:59",
    "Summer/Fall", "1972-07-01 00:00:00", "1972-11-30 23:59:59",
    "Winter", "1972-12-01 00:00:00", "1973-03-31 23:59:59"
  ) |>
    dplyr::mutate(
      dplyr::across(
        c("start_dayte", "end_dayte"),
        \(x) dttr2::dtt_date_time(x)
      )
    ))
})

test_that("seasons errors with arguments", {
  expect_error(bpt_seasons(NULL), "unused argument \\(NULL\\)")
  expect_error(bpt_seasons(1), "unused argument \\(1\\)")
})
