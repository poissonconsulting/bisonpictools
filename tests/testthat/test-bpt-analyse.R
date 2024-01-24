test_that(
  paste0(
    "analysis runs producing an .smb_analysis object with ",
    "correct thinning rate"
  ),
  {
    analysis <- bpt_analyse(
      event_data = bpt_event_data,
      location_data = bpt_location_data,
      census_data = bpt_census_data,
      proportion_calf_data = bpt_proportion_calf_data,
      nthin = 1L,
      analysis_mode = "quick"
    )

    expect_equal(class(analysis), c("smb_analysis", "mb_analysis"))
    expect_true(analysis$nthin == 1L)
  }
)

### TODO: Add tests about specific parameters when model finalized.
# 1. Does it output the stan errors in debug mode?
# 2. If we add a seed to the analysis, can test that we get the same parameters
#    provided that we don't change the data..
