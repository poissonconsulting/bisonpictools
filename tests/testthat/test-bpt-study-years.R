test_that("Correct study years outputted", {
  expect_identical(bpt_study_years(bpt_event_data()), c("2021-2022", "2022-2023"))
})