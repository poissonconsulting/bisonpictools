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

test_that("Correct study years outputted for event data", {
  expect_identical(
    bpt_study_years(bpt_event_data),
    c("2019-2020", "2020-2021", "2021-2022", "2018-2019")
  )
})

test_that("Correct study years outputted for census data", {
  expect_identical(
    bpt_study_years(bpt_census_data),
    c("2020-2021", "2021-2022")
  )
})

test_that("Correct study years outputted for calf proportion data", {
  expect_identical(
    bpt_study_years(bpt_proportion_calf_data),
    c("2020-2021", "2021-2022")
  )
})

test_that("Passes if non-sequential years included calf proportion data", {
  expect_identical(
    bpt_proportion_calf_data |>
      dplyr::mutate(proportion_calf_year = c(2020, 2022)) |>
      bpt_study_years(),
    c("2019-2020", "2021-2022")
  )
})


test_that(
  paste0(
    "Errors if the data provided does not match the format of census, ",
    "calf proportion, or event data"
  ),
  {
    expect_chk_error(
      bpt_study_years(bpt_location_data),
      regexp = paste0(
        "Data is not a compatible tibble\\. Ensure columns match the ",
        "formatting ",
        "for one of the `event`, `census`, or `proportion_calf` tables in the ",
        "template\\: see `\\?template`\\."
      )
    )
  }
)
