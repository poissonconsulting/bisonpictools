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

# Individual tables passed
test_that("event table only passed", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA"),
    start_year = c(2021L),
    start_month = c(4L),
    start_day = c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa = c(1L),
    f1 = c(1L),
    f0 = c(2L),
    fu = c(0L),
    ma = c(1L),
    m3 = c(0L),
    m2 = c(0L),
    m1 = c(1L),
    m0 = c(1L),
    mu = c(0L),
    ua = c(0L),
    u1 = c(1L),
    u0 = c(1L),
    uu = c(1L)
  )
  event <- bpt_check_data(event = event_data, complete = FALSE)

  expect_type(event, "list")
  expect_identical(event$event, event_data)
})

test_that("location table only passed", {
  location_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )

  location <- bpt_check_data(location = location_data, complete = FALSE)

  expect_type(location, "list")
  expect_identical(location$location, location_data)
})


test_that("census table only passed", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  census <- bpt_check_data(census = census_data, complete = FALSE)

  expect_type(census, "list")
  expect_identical(census$census, census_data)
})

test_that("calf proportion table only passed", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.05, 0.1)
  )

  proportion_calf <- bpt_check_data(
    proportion_calf = proportion_calf_data,
    complete = FALSE
  )

  expect_type(proportion_calf, "list")
  expect_identical(proportion_calf$proportion_calf, proportion_calf_data)
})

# Individual tables error if complete == TRUE
test_that("event table only errors as complete set to TRUE", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA"),
    start_year = c(2021L),
    start_month = c(4L),
    start_day = c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa = c(1L),
    f1 = c(1L),
    f0 = c(2L),
    fu = c(0L),
    ma = c(1L),
    m3 = c(0L),
    m2 = c(0L),
    m1 = c(1L),
    m0 = c(1L),
    mu = c(0L),
    ua = c(0L),
    u1 = c(1L),
    u0 = c(1L),
    uu = c(1L)
  )

  expect_error(
    bpt_check_data(event = bpt_event_data, complete = TRUE),
    regexp =
      "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("location table only errors as complete set to TRUE", {
  location_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )

  expect_error(
    bpt_check_data(location = location_data, complete = TRUE),
    regexp =
      "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("census table only errors as complete set to TRUE", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_error(
    bpt_check_data(census = census_data, complete = TRUE),
    regexp =
      "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("calf proportion table only errors as complete set to TRUE", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.05, 0.1)
  )

  expect_error(
    bpt_check_data(proportion_calf = proportion_calf_data, complete = TRUE),
    regexp =
      "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

# Test on joins with all tables
test_that("all tables passed with joins and study years checked", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA"),
    start_year = c(2021L),
    start_month = c(4L),
    start_day = c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa = c(1L),
    f1 = c(1L),
    f0 = c(2L),
    fu = c(0L),
    ma = c(1L),
    m3 = c(0L),
    m2 = c(0L),
    m1 = c(1L),
    m0 = c(1L),
    mu = c(0L),
    ua = c(0L),
    u1 = c(1L),
    u0 = c(1L),
    uu = c(1L)
  )

  location_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )

  census_data <- dplyr::tibble(
    census_year = c(2022L),
    census_month = c(3L),
    census_day = c(31L),
    census = c(200L),
    census_cv = c(0.2)
  )

  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2022L),
    proportion_calf_month = c(3L),
    proportion_calf_day = c(31L),
    proportion_calf = c(0.2),
    proportion_calf_cv = c(0.05)
  )

  data <- bpt_check_data(
    event = event_data,
    location = location_data,
    census = census_data,
    proportion_calf = proportion_calf_data,
    complete = TRUE,
    join = TRUE,
    check_study_years = TRUE
  )

  expect_type(data, "list")
  expect_identical(data$event, event_data)
  expect_identical(data$location, location_data)
  expect_identical(data$census, census_data)
  expect_identical(data$proportion_calf, proportion_calf_data)
})

test_that("errors if sites in event table don't match ocation table", {
  event_data <- dplyr::tibble(
    location_id = c("SiteZ"),
    start_year = c(2021L),
    start_month = c(4L),
    start_day = c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa = c(1L),
    f1 = c(1L),
    f0 = c(2L),
    fu = c(0L),
    ma = c(1L),
    m3 = c(0L),
    m2 = c(0L),
    m1 = c(1L),
    m0 = c(1L),
    mu = c(0L),
    ua = c(0L),
    u1 = c(1L),
    u0 = c(1L),
    uu = c(1L)
  )

  location_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )

  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.05, 0.1)
  )

  expect_error(
    bpt_check_data(
      event = event_data,
      location = location_data,
      census = census_data,
      proportion_calf = proportion_calf_data,
      complete = TRUE,
      join = TRUE
    ),
    regexp = paste0(
      "All 'location_id' values in the event table must be in the location ",
      "table. The following rows\\(s\\) in the event table are causing the",
      " issue: 1."
    )
  )
})

test_that(
  paste0(
    "errors as dates in census and calf proportion tables are not within the ",
    "event_data study years"
  ),
  {
    event_data <- dplyr::tibble(
      location_id = c("SiteZ"),
      start_year = c(2021L),
      start_month = c(4L),
      start_day = c(12L),
      start_hour = c(13L),
      start_minute = c(50L),
      fa = c(1L),
      f1 = c(1L),
      f0 = c(2L),
      fu = c(0L),
      ma = c(1L),
      m3 = c(0L),
      m2 = c(0L),
      m1 = c(1L),
      m0 = c(1L),
      mu = c(0L),
      ua = c(0L),
      u1 = c(1L),
      u0 = c(1L),
      uu = c(1L)
    )

    location_data <- dplyr::tibble(
      location_id = c("SiteZ"),
      latitude = c(57.555),
      longitude = c(-111.757)
    )

    census_data <- dplyr::tibble(
      census_year = c(2021L, 2022L),
      census_month = c(3L, 3L),
      census_day = c(31L, 31L),
      census = c(200L, 140L),
      census_cv = c(0.2, 0.1)
    )

    proportion_calf_data <- dplyr::tibble(
      proportion_calf_year = c(2021L, 2022L),
      proportion_calf_month = c(3L, 3L),
      proportion_calf_day = c(31L, 31L),
      proportion_calf = c(0.2, 0.05),
      proportion_calf_cv = c(0.05, 0.1)
    )

    expect_error(
      bpt_check_data(
        event = event_data,
        location = location_data,
        census = census_data,
        proportion_calf = proportion_calf_data,
        complete = TRUE,
        join = TRUE,
        check_study_years = TRUE
      ),
      regexp = paste(
        "Census data must include only dates that are within the study years of",
        "the event data\\."
      )
    )
  }
)

## Tests on event_data template
test_that("event data coerces real to integer", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA"),
    start_year = c(2021L),
    start_month = c(4L),
    start_day = c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa = c(1),
    f1 = c(1L),
    f0 = c(2L),
    fu = c(0L),
    ma = c(1L),
    m3 = c(0L),
    m2 = c(0L),
    m1 = c(1L),
    m0 = c(1L),
    mu = c(0L),
    ua = c(0L),
    u1 = c(1L),
    u0 = c(1L),
    uu = c(1L)
  )
  event <- bpt_check_data(event = event_data, complete = FALSE)

  expect_type(event, "list")
  expect_identical(event$event$fa, 1L)
})

test_that("event data fails if location ID and datetime are not unique", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteA"),
    start_year = c(2021L, 2021L),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data, complete = FALSE),
    "Columns 'location_id', 'start_year', 'start_month', 'start_day', ",
    "'start_hour' and 'start_minute' in event must be a unique key."
  )
})

test_that("Location ID coerced to a string if provided as an integer", {
  event_data <- dplyr::tibble(
    location_id = c(6L, 1L),
    start_year = c(2021L, 2021L),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  event <- bpt_check_data(event = event_data)$event
  expect_equal(
    event$location_id,
    c("6", "1")
  )
})

test_that("Start year coerced from string to integer", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  event <- bpt_check_data(event = event_data)$event
  expect_identical(
    event$start_year,
    c(2021L, 2022L)
  )
})

test_that("Errors if start year is an incompatible string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("Two thousand and twenty-two", 2022L),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    regexp = paste0(
      "The following values in column 'start_year' should be a ",
      "integer: 'Two thousand and twenty-two'."
    )
  )
})

test_that("Errors if event year is before 2019", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2018", "2022"),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_year` must have values between 2019 and 2050."
  )
})

test_that("Errors if event year is after 2050", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2051", "2022"),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_year` must have values between 2019 and 2050."
  )
})

test_that("Errors if missing values in start_year", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(NA, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$start_year` must not have any missing values."
  )
})

test_that("Errors if start_month is a character string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c("April", 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "The following values in column 'start_month' should be a integer: 'April'."
  )
})

test_that("Errors if negative month provided", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(-1L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_month` must have values between 1 and 12."
  )
})

test_that("Errors if thirteenth month provided", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(13L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_month` must have values between 1 and 12."
  )
})

test_that("Errors if missing values in start_month", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(NA, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$start_month` must not have any missing values."
  )
})

test_that("Errors if day provided as 0", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 0L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_day` must have values between 1 and 31."
  )
})

test_that("Errors if day provided as a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, "thirteen"),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    regexp = paste0(
      "The following values in column 'start_day' should be a integer: ",
      "'thirteen'."
    )
  )
})

test_that("Errors if thirty-second day provided", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 32L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_day` must have values between 1 and 31."
  )
})

test_that("Errors if missing values in start_day", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(NA, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$start_day` must not have any missing values."
  )
})

test_that("Errors if hour provided as string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 32L),
    start_hour = c(13L, "ten"),
    start_minute = c(50L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "The following values in column 'start_hour' should be a integer: 'ten'."
  )
})

test_that("Errors if hour is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, -1L),
    start_minute = c(50L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_hour` must have values between 0 and 23."
  )
})

test_that("Errors if hour is greater than 23", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 26L),
    start_minute = c(50L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_hour` must have values between 0 and 23."
  )
})

test_that("Errors if missing values in start_hour", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(NA, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$start_hour` must not have any missing values."
  )
})

test_that("Errors if minute is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(-50L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_minute` must have values between 0 and 59"
  )
})

test_that("Errors if minute is greater than 59", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(100L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$start_minute` must have values between 0 and 59"
  )
})

test_that("Errors if missing values in start_minute", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(NA, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$start_minute` must not have any missing values."
  )
})

test_that("Errors if fa count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(-1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$fa` must have values between 0 and 900."
  )
})

test_that("Errors if fa count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1000L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$fa` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in fa count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(NA, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$fa` must not have any missing values."
  )
})

test_that("Errors if fa count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c("one", 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'fa' should be a integer: 'one'."
  )
})

test_that("Errors if f1 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(-1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$f1` must have values between 0 and 900."
  )
})

test_that("Errors if f1 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1000L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$f1` must have values between 0 and 900."
  )
})

test_that("Errors if f1 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c("two", 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'f1' should be a integer: 'two'."
  )
})

test_that("Errors if missing values in f1 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(NA, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$f1` must not have any missing values."
  )
})

test_that("Errors if f0 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(-2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$f0` must have values between 0 and 900."
  )
})

test_that("Errors if f0 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2000L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$f0` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in f0 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(NA, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$f0` must not have any missing values."
  )
})

test_that("Errors if f0 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c("two", 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'f0' should be a integer: 'two'."
  )
})

test_that("Errors if fu count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(-1L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$fu` must have values between 0 and 900."
  )
})

test_that("Errors if fu count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(1000L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$fu` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in fu count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(NA, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$fu` must not have any missing values."
  )
})

test_that("Errors if fu count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c("zero", 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'fu' should be a integer: 'zero'."
  )
})

test_that("Errors if ma count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(-1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$ma` must have values between 0 and 900."
  )
})

test_that("Errors if ma count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1000L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$ma` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in ma count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(NA, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$ma` must not have any missing values."
  )
})

test_that("Errors if ma count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c("one", 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'ma' should be a integer: 'one'."
  )
})

test_that("Errors if m3 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(-1L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m3` must have values between 0 and 900."
  )
})

test_that("Errors if m3 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(1000L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m3` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in m3 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(NA, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$m3` must not have any missing values."
  )
})

test_that("Errors if m3 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c("one", 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'm3' should be a integer: 'one'."
  )
})

test_that("Errors if m2 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(-1L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m2` must have values between 0 and 900."
  )
})

test_that("Errors if m2 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(1000L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m2` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in m2 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(NA, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$m2` must not have any missing values."
  )
})

test_that("Errors if m2 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c("one", 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'm2' should be a integer: 'one'."
  )
})

test_that("Errors if m1 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(-1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m1` must have values between 0 and 900."
  )
})

test_that("Errors if m1 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1000L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m1` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in m1 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(NA, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$m1` must not have any missing values."
  )
})

test_that("Errors if m1 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c("one", 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'm1' should be a integer: 'one'."
  )
})

test_that("Errors if m0 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(-1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m0` must have values between 0 and 900."
  )
})

test_that("Errors if m0 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1000L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$m0` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in m0 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(NA, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$m0` must not have any missing values."
  )
})

test_that("Errors if m0 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c("one", 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'm0' should be a integer: 'one'."
  )
})

test_that("Errors if mu count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, -1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$mu` must have values between 0 and 900."
  )
})

test_that("Errors if mu count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1000L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$mu` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in mu count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(NA, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$mu` must not have any missing values."
  )
})

test_that("Errors if ma count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, "one"),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'mu' should be a integer: 'one'."
  )
})

test_that("Errors if ua count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(-1L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$ua` must have values between 0 and 900."
  )
})

test_that("Errors if ua count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1000L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$ua` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in ua count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(NA, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$ua` must not have any missing values."
  )
})

test_that("Errors if ua count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c("one", 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'ua' should be a integer: 'one'."
  )
})

test_that("Errors if u1 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(1L, 1L),
    u1 = c(-1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$u1` must have values between 0 and 900."
  )
})

test_that("Errors if u1 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2000L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$u1` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in u1 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(NA, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$u1` must not have any missing values."
  )
})

test_that("Errors if u1 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c("one", 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'u1' should be a integer: 'one'."
  )
})

test_that("Errors if u0 count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(1L, 1L),
    u1 = c(1L, 2L),
    u0 = c(-1L, 1L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$u0` must have values between 0 and 900."
  )
})

test_that("Errors if u0 count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1000L),
    uu = c(1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$u0` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in u0 count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(NA, 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$u0` must not have any missing values."
  )
})

test_that("Errors if u0 count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c("one", 1L),
    uu = c(1L, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'u0' should be a integer: 'one'."
  )
})

test_that("Errors if uu count column is negative", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(1L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(-1L, 19L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$uu` must have values between 0 and 900."
  )
})

test_that("Errors if uu count column is greater than 900", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c("2021", "2022"),
    start_month = c(1L, 4L),
    start_day = c(12L, 10L),
    start_hour = c(13L, 10L),
    start_minute = c(10L, 10L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(1L, 1900L)
  )

  expect_error(
    bpt_check_data(event = event_data),
    "`event\\$uu` must have values between 0 and 900."
  )
})

test_that("Errors if missing values in uu count column", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c(NA, 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "`event\\$uu` must not have any missing values."
  )
})

test_that("Errors if uu count column is a string", {
  event_data <- dplyr::tibble(
    location_id = c("SiteA", "SiteB"),
    start_year = c(2021, 2022),
    start_month = c(4L, 4L),
    start_day = c(12L, 12L),
    start_hour = c(13L, 13L),
    start_minute = c(50L, 50L),
    fa = c(1L, 2L),
    f1 = c(1L, 3L),
    f0 = c(2L, 1L),
    fu = c(0L, 3L),
    ma = c(1L, 1L),
    m3 = c(0L, 0L),
    m2 = c(0L, 1L),
    m1 = c(1L, 3L),
    m0 = c(1L, 31L),
    mu = c(0L, 1L),
    ua = c(0L, 1L),
    u1 = c(1L, 2L),
    u0 = c(1L, 1L),
    uu = c("one", 19L)
  )

  expect_chk_error(
    bpt_check_data(event = event_data),
    "The following values in column 'uu' should be a integer: 'one'."
  )
})

## Tests on location_data template
test_that("Errors when location_id is not a unique key", {
  location_data <- dplyr::tibble(
    location_id = c("SiteZ", "SiteZ"),
    latitude = c(57.555, 58.552),
    longitude = c(-111.757, -112.757)
  )

  expect_chk_error(
    bpt_check_data(location = location_data),
    regexp = "Column 'location_id' in location must be a unique key."
  )
})

test_that("Errors when location_id has missing values", {
  location_data <- dplyr::tibble(
    location_id = c("SiteZ", NA),
    latitude = c(57.555, 58.552),
    longitude = c(-111.757, -112.757)
  )

  expect_chk_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$location_id` must not have any missing values."
  )
})

test_that("Warning when lat/longs are duplicated", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.555, 57.555),
    longitude = c(-111.757, -111.757)
  )

  expect_warning(
    bpt_check_data(location = location_data),
    regexp = "Location data contains duplicate coordinates\\."
  )
})

test_that("Errors if UTM-type values provided in latitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(813558.7, 6391289),
    longitude = c(-111.757, -111.757)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$latitude` must have values between 50 and 120."
  )
})

test_that("Errors if values provided below range in latitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(-111.575, -111.233),
    longitude = c(-111.757, -111.757)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$latitude` must have values between 50 and 120."
  )
})

test_that("Errors if missing values provided in latitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.555, NA),
    longitude = c(-111.757, -111.757)
  )

  expect_chk_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$latitude` must not have any missing values."
  )
})

test_that("Errors if non-coerceable string provided in latitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c("south creek", 6391289),
    longitude = c(-111.757, -111.757)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = paste0(
      "The following values in column 'latitude' should be a number: ",
      "'south creek'."
    )
  )
})


test_that("Errors if UTM-type values provided in longitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.555, 57.555),
    longitude = c(6391289, 6391289)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$longitude` must have values between -120 and -50."
  )
})

test_that("Errors if values provided below range in longitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.222, 57.636),
    longitude = c(57.772, 57.773)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$longitude` must have values between -120 and -50"
  )
})

test_that("Errors if missing values provided in longitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.555, 57.555),
    longitude = c(-111.757, NA)
  )

  expect_chk_error(
    bpt_check_data(location = location_data),
    regexp = "`location\\$longitude` must not have any missing values."
  )
})

test_that("Errors if non-coerceable string provided in longitude column", {
  location_data <- dplyr::tibble(
    location_id = c("Site1", "Site2"),
    latitude = c(57.433, 54.324),
    longitude = c("North", -111.757)
  )

  expect_error(
    bpt_check_data(location = location_data),
    regexp = paste0(
      "The following values in column 'longitude' should be a number: 'North'."
    )
  )
})

## Checks on census data template
test_that("Errors when year below range", {
  census_data <- dplyr::tibble(
    census_year = c(2016L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_year` must have values between 2019 and 2050."
  )
})

test_that("Errors when year above range", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2051L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_year` must have values between 2019 and 2050."
  )
})

test_that("Errors when year has missing values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, NA),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_year` must not have any missing values."
  )
})

test_that("Errors when non-coercable string provided as year", {
  census_data <- dplyr::tibble(
    census_year = c("this year", 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "The following values in column 'census_year' should be a integer: ",
      "'this year'."
    )
  )
})

test_that("Errors when text provided as month", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c("March", "March"),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "The following values in column 'census_month' should be a integer: ",
      "'March'."
    )
  )
})

test_that("Errors when month below range", {
  census_data <- dplyr::tibble(
    census_year = c(2019, 2022L),
    census_month = c(0L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_month` must have values between 1 and 12"
  )
})

test_that("Errors when month above range", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 13L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_month` must have values between 1 and 12."
  )
})

test_that("Errors when month has missing values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, NA),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_month` must not have any missing values."
  )
})

test_that("Errors when day below range", {
  census_data <- dplyr::tibble(
    census_year = c(2019, 2022L),
    census_month = c(1L, 3L),
    census_day = c(-1L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_day` must have values between 1 and 31"
  )
})

test_that("Errors when day above range", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 11L),
    census_day = c(33L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_day` must have values between 1 and 31."
  )
})

test_that("Errors when day has missing values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, NA),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_day` must not have any missing values."
  )
})

test_that("Errors when day has non-coerceable string values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c("twelve", 31L),
    census = c(200L, NA),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "The following values in column 'census_day' should be a integer: ",
      "'twelve'."
    )
  )
})

test_that("Errors if duplicate date values provided", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "Columns 'census_year', 'census_month' and 'census_day' in census must ",
      "be a unique key."
    )
  )
})

test_that("Errors if census is below 1", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(0L, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census` must have values between 1 and 1000."
  )
})


test_that("Errors if census is above 1000", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(1L, 1400L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census` must have values between 1 and 1000."
  )
})


test_that("Errors if census has missing values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(NA, 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census` must not have any missing values."
  )
})

test_that("Errors if census has non-coerceable string values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c("one", 140L),
    census_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "The following values in column 'census' should be a integer: 'one'."
    )
  )
})

test_that("Errors when CV is below the expected range", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(-0.1, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_cv` must have values between 0 and 0.5."
  )
})

test_that("Errors when CV is above the expected range", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(1L, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_cv` must have values between 0 and 0.5."
  )
})

test_that("Errors when CV has missing values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.1, NA)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = "`census\\$census_cv` must not have any missing values."
  )
})

test_that("Errors when CV has non-coerceable string values", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2022L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.1, "one")
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "The following values in column 'census_cv' should be a number: 'one'."
    )
  )
})

test_that("Errors when duplicate dates provided to census data", {
  census_data <- dplyr::tibble(
    census_year = c(2021L, 2021L),
    census_month = c(3L, 3L),
    census_day = c(31L, 31L),
    census = c(200L, 140L),
    census_cv = c(0.1, 0.1)
  )

  expect_chk_error(
    bpt_check_data(census = census_data),
    regexp = paste0(
      "Columns 'census_year', 'census_month' and 'census_day' in census ",
      "must be a unique key."
    )
  )
})

## Checks on calf proportion template
test_that("Errors when duplicate dates provided to calf proportion data", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2021L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.05, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "Columns 'proportion_calf_year', 'proportion_calf_month' and ",
      "'proportion_calf_day' in proportion_calf must be a unique key."
    )
  )
})

test_that("Errors when year below range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2016L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_year` must have values between 2019 ",
      "and 2050."
    )
  )
})

test_that("Errors when year above range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2051L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_year` must have values between ",
      "2019 and 2050."
    )
  )
})

test_that("Errors when year has missing values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, NA),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_year` must not have any missing ",
      "values."
    )
  )
})

test_that("Errors when year has non-coerceable string values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, "current year"),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "The following values in column 'proportion_calf_year' should be a ",
      "integer: 'current year'."
    )
  )
})

test_that("Errors when text provided as month", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c("March", "March"),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "The following values in column 'proportion_calf_month' should be a ",
      "integer: 'March'."
    )
  )
})

test_that("Errors when month below range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2019, 2022L),
    proportion_calf_month = c(0L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_month` must have values between 1 ",
      "and 12"
    )
  )
})

test_that("Errors when month above range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 13L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_month` must have values between 1 ",
      "and 12."
    )
  )
})

test_that("Errors when month has missing values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, NA),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_month` must not have any missing ",
      "values."
    )
  )
})

test_that("Errors when day below range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2019, 2022L),
    proportion_calf_month = c(1L, 3L),
    proportion_calf_day = c(-1L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_day` must have values between 1 ",
      "and 31"
    )
  )
})

test_that("Errors when day above range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 11L),
    proportion_calf_day = c(33L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_day` must have values between 1 ",
      "and 31."
    )
  )
})

test_that("Errors when day has missing values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, NA),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_day` must not have any missing ",
      "values."
    )
  )
})

test_that("Errors when proportion_calf has non-coerceable string", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, "a"),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "The following values in column 'proportion_calf' should be a ",
      "number: 'a'."
    )
  )
})

test_that("Errors if proportion_calf is less than 0", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2021L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, -0.2),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    paste0(
      "`proportion_calf\\$proportion_calf` must have values between 0 and 1."
    )
  )
})


test_that("Errors if proportion_calf is above 1", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2021L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(1L, 1400L),
    proportion_calf_cv = c(0.2, 1.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf` must have values between 0 and 1"
    )
  )
})


test_that("Errors if proportion_calf has missing values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2021L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(NA, 0.5),
    proportion_calf_cv = c(0.2, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf` must not have any missing values."
    )
  )
})

test_that("Errors when CV is below the expected range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(-0.1, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_cv` must have values between 0 and 1"
    )
  )
})

test_that("Errors when CV is above the expected range", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(1, 1.4)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_cv` must have values between 0 and 1."
    )
  )
})

test_that("Errors when CV has missing values", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.1, NA)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "`proportion_calf\\$proportion_calf_cv` must not have any missing values."
    )
  )
})

test_that("Errors when non-coerceable string in proportion_calf_cv", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2022L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.1, "a")
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "The following values in column 'proportion_calf_cv' should be a ",
      "number: 'a'."
    )
  )
})

test_that("Errors when duplicate dates provided to proportion_calf data", {
  proportion_calf_data <- dplyr::tibble(
    proportion_calf_year = c(2021L, 2021L),
    proportion_calf_month = c(3L, 3L),
    proportion_calf_day = c(31L, 31L),
    proportion_calf = c(0.2, 0.05),
    proportion_calf_cv = c(0.1, 0.1)
  )

  expect_chk_error(
    bpt_check_data(proportion_calf = proportion_calf_data),
    regexp = paste0(
      "Columns 'proportion_calf_year', 'proportion_calf_month' and ",
      "'proportion_calf_day' in proportion_calf must be a unique key."
    )
  )
})
