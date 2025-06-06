# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

test_that(
  paste0(
    "report mode produces an .smb_analysis object with ",
    "correct thinning rate, names, and expected coefficients"
  ),
  {
    withr::with_seed(
      101,
      {
        analysis <- bpt_analyse(
          event_data = event_data,
          location_data = location_data,
          census_data = census_data,
          proportion_calf_data = proportion_calf_data,
          nthin = 1L,
          analysis_mode = "report"
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
            event_data,
            location_data,
            census_data,
            proportion_calf_data
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
        testthat::skip_on_ci()
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
