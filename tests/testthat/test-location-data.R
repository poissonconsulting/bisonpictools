test_that("location_data produces tibble of expected dimensions", {
  expect_equal(dim(location_data()), c(2, 3))
})

test_that("expect error with arguments supplied to event_data", {
  expect_error(location_data(NULL), "unused argument \\(NULL\\)")
  expect_error(location_data(0), "unused argument \\(0\\)")
  expect_error(location_data(tibble(x = 1)), "unused argument \\(tibble\\(x = 1\\)\\)")
})
