test_that("event_data produces tibble of expected dimensions", {
  expect_equal(dim(event_data()), c(7, 20))
})

test_that("expect error with arguments supplied to event_data", {
  expect_error(event_data(NULL), "unused argument \\(NULL\\)")
  expect_error(event_data(0), "unused argument \\(0\\)")
  expect_error(event_data(tibble(x = 1)), "unused argument \\(tibble\\(x = 1\\)\\)")
})