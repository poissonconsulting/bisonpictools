test_that("errors with unknown numerator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
      numerator = "f6",
      denominator = "f1"
    ),
    "Numerator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("errors with unknown denominator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
      numerator = "f0",
      denominator = "f5"
    ),
    "Denominator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("same number of rows as event_data without filtering", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
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
        data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
        numerator = "f0",
        denominator = "m0"
      )
    ),
    12L
  )
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
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
        data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
        numerator = "f0",
        denominator = "m0",
        study_years = "2020-2021"
      )
    ),
    3L
  )
})

# Output
x <- bpt_manipulate_ratios(
  data = bpt_manipulate_data_plot(bpt_event_data, bpt_location_data),
  numerator = "f1",
  denominator = "f0"
)

test_that("all ratios are ≤ 1", {
  expect_true(max(x$ratio) <= 1)
})

test_that("all ratios are ≥ 0", {
  expect_true(min(x$ratio) >= 0)
})

test_that("output is a tibble", {
  expect_true(all(attributes(x)$class == c("tbl_df", "tbl", "data.frame")))
})

test_that("expected output column types", {
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
