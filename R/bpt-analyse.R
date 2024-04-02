#' Fit Integrated Population Model
#'
#' Fits the integrated population model to data. Run first in "debug" mode to
#' ensure that the model samples. Next, run in "report" mode to sample the
#' full number of iterations.
#'
#' @inheritParams params
#'
#' @return An `smb.analysis` object.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_analyse(
#'   event_data = bpt_event_data,
#'   location_data = bpt_location_data,
#'   census_data = bpt_census_data,
#'   proportion_calf_data = bpt_proportion_calf_data,
#'   nthin = 1L,
#'   analysis_mode = "quick"
#' )
#' }
bpt_analyse <- function(
    event_data,
    location_data,
    census_data,
    proportion_calf_data,
    nthin = 1L,
    analysis_mode = "report") {
  chk::chk_integer(nthin)
  chk::chk_gte(nthin, 1L)
  chk::chk_subset(analysis_mode, c("report", "quick", "debug"))

  data_list <- bpt_manipulate_data_analysis(
    event_data,
    location_data,
    census_data,
    proportion_calf_data
  )
  data <- data_list$data
  census_data <- data_list$census_data
  prop_calf_data <- data_list$prop_calf_data

  levels_annual <- levels(data$annual)

  model <- embr::model(
    code = readr::read_file(
      system.file(package = "bisonpictools", "stan/model.stan")
    ),
    modify_data = function(data) {
      data$nclass <- 8L
      data$nannual_minus_1 <- data$nannual - 1
      data <- bpt_modify_data(
        data = data,
        levels_annual = levels_annual,
        census = census_data$census,
        census_cv = census_data$census_cv,
        census_study_year = census_data$census_study_year,
        census_day_of_year = census_data$census_doy,
        proportion_calf = prop_calf_data$prop_calf,
        proportion_calf_cv = prop_calf_data$prop_calf_cv,
        proportion_calf_study_year = prop_calf_data$prop_calf_study_year,
        proportion_calf_day_of_year = prop_calf_data$prop_calf_doy
      )
      data$location_distance <- bpt_location_matrix(location_data)
      x <- as.data.frame(data[c("location_weekfac", "location", "week")]) |>
        dplyr::distinct() |>
        dplyr::arrange(.data$location_weekfac)
      data$week <- NULL
      data$lookup_location <- x$location
      data$lookup_week <- x$week
      data
    },
    new_expr = "
    for (i in 1:nObs) {
      eAbundanceF0[i] <- bPopulationAnnual[1, annual[i]]
      eAbundanceF1[i] <- bPopulationAnnual[2, annual[i]]
      eAbundanceFA[i] <- bPopulationAnnual[3, annual[i]]
      eAbundanceM0[i] <- bPopulationAnnual[4, annual[i]]
      eAbundanceM1[i] <- bPopulationAnnual[5, annual[i]]
      eAbundanceM2[i] <- bPopulationAnnual[6, annual[i]]
      eAbundanceM3[i] <- bPopulationAnnual[7, annual[i]]
      eAbundanceMA[i] <- bPopulationAnnual[8, annual[i]]

      eAbundance[i] <- eAbundanceF0[i] + eAbundanceF1[i] + eAbundanceFA[i] + eAbundanceM1[i] + eAbundanceM2[i] + eAbundanceM3[i] + eAbundanceMA[i]

      m0_f0[i] <- bPropVecMar31[annual[i], 4] / bPropVecMar31[annual[i], 1]
      m1_f1[i] <- bPropVecMar31[annual[i], 5] / bPropVecMar31[annual[i], 2]
      calf_fa[i] <- (bPropVecMar31[annual[i], 1] + bPropVecMar31[annual[i], 4]) / bPropVecMar31[annual[i], 3]
      yearling_fa[i] <- (bPropVecMar31[annual[i], 2] + bPropVecMar31[annual[i], 5]) / bPropVecMar31[annual[i], 3]
      m2_fa[i] <- bPropVecMar31[annual[i], 6] / bPropVecMar31[annual[i], 3]
      m3_fa[i] <- bPropVecMar31[annual[i], 7] / bPropVecMar31[annual[i], 3]
      ma_fa[i] <- bPropVecMar31[annual[i], 8] / bPropVecMar31[annual[i], 3]

      PredFecundityReproductiveFA[i] <- inv_logit(bFecundityReproductiveFA)
      ePropReproductiveFA[i] <- bPropReproductiveFA
      eInitialMortalityCalf[i] <- inv_logit(bInitialMortalityCalfAnnual[annual[i]])

      PredSurvF0Annual[i] <- inv_logit(bSurvF0Annual[annual[i]]) * (1 - eInitialMortalityCalf[i])
      PredSurvM0Annual[i] <- inv_logit(bSurvM0Annual[annual[i]]) * (1 - eInitialMortalityCalf[i])
      PredSurvF1Annual[i] <- inv_logit(bSurvF1Annual[annual[i]])
      PredSurvM1Annual[i] <- inv_logit(bSurvM1Annual[annual[i]])
      PredSurvFAAnnual[i] <- inv_logit(bSurvFAAnnual[annual[i]])
      PredSurvBullAnnual[i] <- inv_logit(bSurvBullAnnual[annual[i]])
      eMAProportion[i] <- bMAProportion[season[i]]

      prop_calf[i] <- bPropVecMar31[annual[i], 1] + bPropVecMar31[annual[i], 4]
  }",
    new_expr_vec = TRUE,
    select_data = list(
      f0 = 1L,
      m0 = 1L,
      calf = 1L,
      f1 = 1L,
      m1 = 1L,
      yearling = 1L,
      fa = 1L,
      m2 = 1L,
      m3 = 1L,
      ma = 1L,
      adult = 1L,
      doy = c(1L, 366L),
      groupsize_total = 1L,
      annual = factor(),
      season = factor(),
      season_annual = factor(),
      week = c(0L, 500L),
      location = factor(),
      weekfac = factor(),
      location_weekfac = factor(),
      id = factor()
    ),
    derived = c(
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
    ),
    random_effects = list(
      eZSummerFallF0M0 = c("location", "weekfac"),
      eZSummerFallF1M1 = c("location", "weekfac"),
      eZSummerFallFABull = c("location", "weekfac"),
      eZSummerFallM2M3 = c("location", "weekfac"),
      eZSummerFallMAFA = c("location", "weekfac"),
      eZSummerFallCalf = c("location", "weekfac"),
      eZSummerFallYearling = c("location", "weekfac"),
      eZSummerFallAdult = c("location", "weekfac"),
      eZWinF0M0 = c("location", "weekfac"),
      eZWinF1M1 = c("location", "weekfac"),
      eZWinFABull = c("location", "weekfac"),
      eZWinM2M3 = c("location", "weekfac"),
      eZWinMAFA = c("location", "weekfac"),
      eZWinCalf = c("location", "weekfac"),
      eZWinYearling = c("location", "weekfac"),
      eZWinAdult = c("location", "weekfac")
    )
  )

  on.exit(embr::set_analysis_mode(mode = "reset"))
  embr::set_analysis_mode(analysis_mode)
  analysis <- embr::analyse(model, data = data, nthin = nthin)

  analysis
}
