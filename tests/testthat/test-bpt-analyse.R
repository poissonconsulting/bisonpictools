test_that("no errors when running analysis", {
  expect_no_error(
    analysis <<- bpt_analyse(
      event_data = bpt_event_data,
      location_data = bpt_location_data,
      census_data = bpt_census_data,
      proportion_calf_data = bpt_proportion_calf_data,
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
