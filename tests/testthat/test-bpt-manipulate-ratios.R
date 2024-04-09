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

test_that("errors with unknown numerator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(
        bpt_event_data,
        bpt_location_data
      ),
      numerator = "f6",
      denominator = "f1"
    ),
    regexp = paste0(
      "Numerator is not a compatible class. Ensure all elements are in: ",
      "c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', ",
      "'u1', 'u0', 'uu'\\)."
    )
  )
})

test_that("errors with unknown denominator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(
        bpt_event_data,
        bpt_location_data
      ),
      numerator = "f0",
      denominator = "f5"
    ),
    regexp = paste0(
      "Denominator is not a compatible class. Ensure all elements are in: ",
      "c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', ",
      "'u1', 'u0', 'uu'\\)."
    )
  )
})

test_that("same number of rows as event_data without filtering", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(
      bpt_event_data,
      bpt_location_data
    ),
    numerator = "f0",
    denominator = "f1"
  )
  expect_equal(
    nrow(x), nrow(bpt_event_data |> dplyr::filter(f0 > 0 | f1 > 0))
  )
})

test_that("filters out years", {
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(
          bpt_event_data,
          bpt_location_data
        ),
        numerator = "f0",
        denominator = "m0"
      )
    ),
    12L
  )
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(
          bpt_event_data,
          bpt_location_data
        ),
        numerator = "f0",
        denominator = "m0",
        study_years = "2021-2022"
      )
    ),
    3L
  )
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(
          bpt_event_data,
          bpt_location_data
        ),
        numerator = "f0",
        denominator = "m0",
        study_years = "2020-2021"
      )
    ),
    3L
  )
})

# Output
test_that("all ratios are ≤ 1", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(
      bpt_event_data,
      bpt_location_data
    ),
    numerator = "f1",
    denominator = "f0"
  )
  expect_true(max(x$ratio) <= 1)
})

test_that("all ratios are ≥ 0", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(
      bpt_event_data,
      bpt_location_data
    ),
    numerator = "f1",
    denominator = "f0"
  )
  expect_true(min(x$ratio) >= 0)
})

test_that("returns tibble", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(
      bpt_event_data,
      bpt_location_data
    ),
    numerator = "f1",
    denominator = "f0"
  )
  expect_true(attributes(x)$class[1] == "tbl_df")
  expect_true(attributes(x)$class[2] == "tbl")
  expect_true(attributes(x)$class[3] == "data.frame")
})

test_that("expected output column types", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(
      bpt_event_data,
      bpt_location_data
    ),
    numerator = "f1",
    denominator = "f0"
  )
  expect_true(is.factor(x$location_id))
  expect_true(is.integer(x$groupsize))
  expect_true(is.integer(x$fa))
  expect_true(is.integer(x$f1))
  expect_true(is.integer(x$f0))
  expect_true(is.integer(x$fu))
  expect_true(is.integer(x$ma))
  expect_true(is.integer(x$m3))
  expect_true(is.integer(x$m2))
  expect_true(is.integer(x$m1))
  expect_true(is.integer(x$m0))
  expect_true(is.integer(x$mu))
  expect_true(is.integer(x$ua))
  expect_true(is.integer(x$u1))
  expect_true(is.integer(x$u0))
  expect_true(is.integer(x$uu))
  expect_true(is.factor(x$study_year))
  expect_true(dttr2::is.POSIXct(x$date_time))
  expect_true(is.factor(x$year))
})
