test_that(
  "analysis fails with negative thinning rate", {
    expect_error(
      analysis <- bpt_analyse(
        event_data = bpt_event_data,
        location_data = bpt_location_data,
        census_data = bpt_census_data,
        proportion_calf_data = bpt_proportion_calf_data,
        nthin = -1L,
        analysis_mode = "quick"
      ),
      "`nthin` must be greater than or equal to 1."
    )
  }
)

test_that(
  "analysis fails with unrecognized analysis mode", {
   expect_error(
      analysis <- bpt_analyse(
        event_data = bpt_event_data,
        location_data = bpt_location_data,
        census_data = bpt_census_data,
        proportion_calf_data = bpt_proportion_calf_data,
        nthin = 1L,
        analysis_mode = "hurry"
      ),
      "`analysis_mode` must match"
    )
  }
)

test_that(
  "analysis fails with decimal thinning rate", {
    expect_error(
      analysis <- bpt_analyse(
        event_data = bpt_event_data,
        location_data = bpt_location_data,
        census_data = bpt_census_data,
        proportion_calf_data = bpt_proportion_calf_data,
        nthin = 0.1,
        analysis_mode = "quick"
      ),
      "`nthin` must be integer."
    )
  }
)

# Add tests for no inputs
