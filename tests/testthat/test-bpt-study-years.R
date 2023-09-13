test_that("Correct study years outputted", {
  expect_identical(
    bpt_study_years(bpt_event_data), 
    c("2019-2020", "2020-2021", "2021-2022", "2018-2019")
  )
})