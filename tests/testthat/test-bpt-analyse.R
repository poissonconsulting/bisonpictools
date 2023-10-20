test_that("no errors when running analysis", {
  expect_no_error(
    analysis <<- bpt_analyse(
      event_data = bpt_event_data,
      location_data = bpt_location_data,
      census = 272L,
      census_cv = 20 / 272L,
      census_study_year = "2020-2021",
      census_day_of_year = 365L,
      proportion_calf = c(0.195, 0.151),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2020-2021", "2021-2022"),
      proportion_calf_day_of_year = c(365L, 365L),
      nthin = 1L,
      analysis_mode = "quick"
    )
  )
})

test_that("analysis object is an .smb_analysis", {
  expect_equal(class(analysis), c("smb_analysis", "mb_analysis"))
})

test_that("thinning rate is 1", {
  expect_true(analysis$nthin == 1L)
})

### TODO: Add tests about specific parameters when model finalized.