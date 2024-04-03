test_that(
  paste0(
    "quick mode produces an .smb_analysis object with ",
    "correct thinning rate, names, and expected coefficients"
  ), {
    withr::with_seed(
      101, {
        analysis <- bpt_analyse(
          event_data = bpt_event_data,
          location_data = bpt_location_data,
          census_data = bpt_census_data,
          proportion_calf_data = bpt_proportion_calf_data,
          nthin = 2L,
          analysis_mode = "quick"
        )
        expect_equal(class(analysis), c("smb_analysis", "mb_analysis"))
        expect_equal(analysis$nthin, 2L)
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
        expect_snapshot(
          print(
            embr::glance(analysis),
            n = 100,
            width = 100
          )
        )
        expect_snapshot(
          print(
            embr::coef(analysis, simplify = TRUE, param_type = "fixed"),
            n = 500,
            width = 100
          )
        )
        expect_snapshot(
          print(
            embr::coef(analysis, simplify = TRUE, param_type = "random"),
            n = 500,
            width = 100
          )
        )
        expect_snapshot(
          print(
            embr::coef(analysis, simplify = TRUE, param_type = "derived"),
            n = 500,
            width = 100
          )
        )
      }
    )
  }
)