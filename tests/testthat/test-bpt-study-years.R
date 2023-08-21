test_that("Correct study years outputted", {
  expect_equal(bpt_study_years(bpt_event_data()), c("2021-2022", "2022-2023"))
})

# TODO: Add tests after adding in Ayla's check functions for event_data/location_data 