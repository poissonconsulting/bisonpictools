test_that(
  paste0(
    "quick mode produces an .smb_analysis object with ",
    "correct thinning rate, names, and expected coefficients"
  ), {
    withr::with_seed(
      101, 
      analysis <- bpt_analyse(
        event_data = bpt_event_data,
        location_data = bpt_location_data,
        census_data = bpt_census_data,
        proportion_calf_data = bpt_proportion_calf_data,
        nthin = 1L,
        analysis_mode = "quick"
      )
    )
    expect_equal(class(analysis), c("smb_analysis", "mb_analysis"))
    expect_equal(analysis$nthin, 1L)
    expect_equal(
      names(analysis),
      c("model", "data", "inits", "stanfit", "mcmcr", "nthin", "duration")
    )
    expect_equal(
      analysis$data,
      bpt_manipulate_data_analysis(
        bpt_event_data,
        bpt_location_data,
        bpt_census_data,
        bpt_proportion_calf_data
      )$data
    )
    expect_equal(
      analysis$model$derived,
      c(
        "bPropVecMar31",
        "bPopulationAnnual",
        "bPropVecEvent",
        "bSpaceTimeF0M0",
        "bSpaceTimeF1M1",
        "bSpaceTimeFABull",
        "bSpaceTimeM2M3",
        "bSpaceTimeMAFA",
        "bSpaceTimeCalf",
        "bSpaceTimeYearling",
        "bSpaceTimeAdult"
      )
    )
    expect_equal(
      analysis$model$random_effects,
      list(
        eZSummerFallAdult = c("location", "weekfac"),
        eZSummerFallCalf = c("location", "weekfac"),
        eZSummerFallF0M0 = c("location", "weekfac"),
        eZSummerFallF1M1 = c("location", "weekfac"),
        eZSummerFallFABull = c("location", "weekfac"),
        eZSummerFallM2M3 = c("location", "weekfac"),
        eZSummerFallMAFA = c("location", "weekfac"),
        eZSummerFallYearling = c("location", "weekfac"),
        eZWinAdult = c("location", "weekfac"),
        eZWinCalf = c("location", "weekfac"),
        eZWinF0M0 = c("location", "weekfac"),
        eZWinF1M1 = c("location", "weekfac"),
        eZWinFABull = c("location", "weekfac"),
        eZWinM2M3 = c("location", "weekfac"),
        eZWinMAFA = c("location", "weekfac"),
        eZWinYearling = c("location", "weekfac")
      )
    )
    expect_snapshot_data(
      embr::glance(analysis),
      "quick_glance"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "fixed"),
      "quick_fixed_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "random"),
      "quick_random_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "derived"),
      "quick_derived_coef"
    )
  }
)

test_that(
  "report mode runs", {
    withr::with_seed(
      101, {
        analysis <- bpt_analyse(
          event_data = bpt_event_data,
          location_data = bpt_location_data,
          census_data = bpt_census_data,
          proportion_calf_data = bpt_proportion_calf_data,
          nthin = 1L,
          analysis_mode = "report"
        )
      }
    )
    expect_snapshot_data(
      embr::glance(analysis),
      "report_glance"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "fixed"),
      "report_fixed_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "random"),
      "report_random_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "derived"),
      "report_derived_coef"
    )
  }
)

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

test_that(
  "analysis has warning messages with debug analysis mode, and debug snapshots",
  {
    expect_warning(
      expect_warning(
        expect_warning(
          expect_warning(
            expect_warning(
              expect_warning(
                expect_warning(
                  expect_warning(
                    expect_warning(
                      withr::with_seed(
                        101,
                        analysis <- bpt_analyse(
                          event_data = bpt_event_data,
                          location_data = bpt_location_data,
                          census_data = bpt_census_data,
                          proportion_calf_data = bpt_proportion_calf_data,
                          nthin = 1L,
                          analysis_mode = "debug"
                        )
                      ),
                      "The largest R-hat is 2.12, indicating chains have not mixed"
                    ),
                    "Bulk Effective Samples Size"
                  ),
                  "Tail Effective Samples Size"
                ),
                "There were 7 divergent transitions after warmup"
              ),
              "There were 1 chains where the estimated Bayesian Fraction of Missing Information was low"
            ),
            "Examine the pairs\\(\\) plot to diagnose sampling problems"
          ),
          "The largest R-hat is 2.22, indicating chains have not mixed"
        ),
        "Bulk Effective Samples Size",
      ),
      "Tail Effective Samples Size"
    )
    expect_snapshot_data(
      embr::glance(analysis),
      "debug_glance"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "fixed"),
      "debug_fixed_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "random"),
      "debug_random_coef"
    )
    expect_snapshot_data(
      embr::coef(analysis, simplify = TRUE, param_type = "derived"),
      "debug_derived_coef"
    )
  }
)

# Add tests for no inputs
