test_that("event table only passed", {
  event_data <- dplyr::tibble(
    location_id	= c("SiteA"),
    start_year = c(2021L),
    start_month	= c(4L),
    start_day	= c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa	= c(1L),
    f1	= c(1L),
    f0	= c(2L),
    fu	= c(0L),
    ma	= c(1L),
    m3	= c(0L),
    m2	= c(0L),
    m1	= c(1L),
    m0	= c(1L),
    mu	= c(0L),
    ua	= c(0L),
    u1	= c(1L),
    u0	= c(1L),
    uu	= c(1L)
  )
  event <- bpt_check_data(event = event_data, complete = FALSE)
  
  expect_type(event, "list")
  expect_identical(event$event, event_data)
})

test_that("event table only errors as complete set to TRUE", {
  event_data <- dplyr::tibble(
    location_id	= c("SiteA"),
    start_year = c(2021L),
    start_month	= c(4L),
    start_day	= c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa	= c(1L),
    f1	= c(1L),
    f0	= c(2L),
    fu	= c(0L),
    ma	= c(1L),
    m3	= c(0L),
    m2	= c(0L),
    m1	= c(1L),
    m0	= c(1L),
    mu	= c(0L),
    ua	= c(0L),
    u1	= c(1L),
    u0	= c(1L),
    uu	= c(1L)
  )
  
  expect_error(
    bpt_check_data(event = bpt_event_data(), complete = TRUE),
    regexp = "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("event data changes type", {
  event_data <- dplyr::tibble(
    location_id	= c("SiteA"),
    start_year = c(2021L),
    start_month	= c(4L),
    start_day	= c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa	= c(1),
    f1	= c(1L),
    f0	= c(2L),
    fu	= c(0L),
    ma	= c(1L),
    m3	= c(0L),
    m2	= c(0L),
    m1	= c(1L),
    m0	= c(1L),
    mu	= c(0L),
    ua	= c(0L),
    u1	= c(1L),
    u0	= c(1L),
    uu	= c(1L)
  )
  event <- bpt_check_data(event = event_data, complete = FALSE)
  
  expect_type(event, "list")
  expect_identical(event$event$fa, 1L)
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

test_that("location table only errors as complete set to TRUE", {
  location_data <- dplyr::tibble( 
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )
  
  expect_error(
    bpt_check_data(location = location_data, complete = TRUE),
    regexp = "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("both tables passed", {
  event_data <- dplyr::tibble(
    location_id	= c("SiteA"),
    start_year = c(2021L),
    start_month	= c(4L),
    start_day	= c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa	= c(1L),
    f1	= c(1L),
    f0	= c(2L),
    fu	= c(0L),
    ma	= c(1L),
    m3	= c(0L),
    m2	= c(0L),
    m1	= c(1L),
    m0	= c(1L),
    mu	= c(0L),
    ua	= c(0L),
    u1	= c(1L),
    u0	= c(1L),
    uu	= c(1L)
  )
  
  location_data <- dplyr::tibble( 
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )
  
  data <- bpt_check_data(
    event = event_data, location = location_data, complete = TRUE
  )
  
  expect_type(data, "list")
  expect_identical(data$event, event_data)
  expect_identical(data$location, location_data)
})

test_that("errors as sites between tables don't match", {
  event_data <- dplyr::tibble(
    location_id	= c("SiteZ"),
    start_year = c(2021L),
    start_month	= c(4L),
    start_day	= c(12L),
    start_hour = c(13L),
    start_minute = c(50L),
    fa	= c(1L),
    f1	= c(1L),
    f0	= c(2L),
    fu	= c(0L),
    ma	= c(1L),
    m3	= c(0L),
    m2	= c(0L),
    m1	= c(1L),
    m0	= c(1L),
    mu	= c(0L),
    ua	= c(0L),
    u1	= c(1L),
    u0	= c(1L),
    uu	= c(1L)
  )
  
  location_data <- dplyr::tibble( 
    location_id = c("SiteA", "SiteB"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )
  expect_error(
    bpt_check_data(
      event = event_data, location = location_data, complete = TRUE
    ),
    regexp = paste0(
      "All 'location_id' values in the event table must be in the location ",
      "table. The following rows\\(s\\) in the event table are causing the",
      " issue: 1."
    )
  )
})
