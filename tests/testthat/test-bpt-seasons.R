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
