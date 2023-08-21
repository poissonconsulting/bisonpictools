test_that("all ratios are ≤ 1", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()), 
    numerator = "f1", 
    denominator = "f0"
  )
  expect_true(max(x$ratio) <= 1)
})

test_that("all ratios are ≥ 0", {
  x <- bpt_manipulate_ratios(
    data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()), 
    numerator = "f1", 
    denominator = "f0"
  )
  expect_true(min(x$ratio) >= 0)
})

test_that("errors with unknown numerator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()), 
      numerator = "f6", 
      denominator = "f1"
    ),
    "Numerator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("errors with unknown denominator class", {
  expect_error(
    bpt_manipulate_ratios(
      data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()), 
      numerator = "f0", 
      denominator = "f5"
    ),
    "Denominator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("filters out years", {
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()),
        numerator = "f0",
        denominator = "m0"
      )
    ),
    7L
  )
  expect_equal(
    nrow(
      bpt_manipulate_ratios(
        data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()),
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
        data = bpt_manipulate_data_plot(bpt_event_data(), bpt_location_data()),
        numerator = "f0",
        denominator = "m0",
        study_years = "2022-2023"
      )
    ),
    4L
)
})
