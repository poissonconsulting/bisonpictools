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

test_that("NULL inputs throw error", {
  expect_chk_error(
    check_study_year(NULL, NULL, NULL),
    regexp = paste0(
      "Data is not a compatible tibble\\. Ensure columns match the formatting ",
      "for one of the `event`, `census`, or `proportion_calf` tables in the ",
      "template\\: see `\\?template`\\."
    )
  )
  expect_chk_error(
    check_study_year(event_data, NULL, NULL),
    regexp = paste0(
      "Data is not a compatible tibble\\. Ensure columns match the formatting ",
      "for one of the `event`, `census`, or `proportion_calf` tables in the ",
      "template\\: see `\\?template`\\."
    )
  )
  expect_chk_error(
    check_study_year(NULL, census_data, NULL),
    regexp = paste0(
      "Data is not a compatible tibble\\. Ensure columns match the formatting ",
      "for one of the `event`, `census`, or `proportion_calf` tables in the ",
      "template\\: see `\\?template`\\."
    )
  )
})


test_that(
  "errors if study years of census data don't match those of event data",
  {
    census_data <- census_data |>
      dplyr::mutate(census_year = c(2030, 2031))
    expect_chk_error(
      check_study_year(event_data, census_data, proportion_calf_data),
      regexp = paste0(
        "Census data must include only dates that are within the study years ",
        "of the event data."
      )
    )
  }
)

test_that(
  "errors if study years of census data don't match those of event data",
  {
    prop_calf_data <- proportion_calf_data |>
      dplyr::mutate(proportion_calf_year = c(2030, 2031))
    expect_chk_error(
      check_study_year(event_data, census_data, prop_calf_data),
      regexp = paste0(
        "Calf proportion data must include only dates that are within the ",
        "study years of the event data."
      )
    )
  }
)

test_that(
  paste0(
    "passes if the study years of both census and prop calf data match ",
    "those of event data"
  ),
  {
    x <- check_study_year(
      event_data,
      census_data,
      proportion_calf_data
    )
    expect_true(x)
  }
)
