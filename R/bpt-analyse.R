#' Fit Integrated Population Model
#'
#' Fits the integrated population model to data
#'
#' @param nthin thinning rate
#' @param event_data tibble of templated event data
#' @param location_data tibble of templated location data
#' @param census integer vector of census values
#' @param census_cv numeric vector of census coefficients of variation
#' @param census_study_year character vector of census study years
#' @param census_day_of_year integer vector of census days of year
#' @param proportion_calf numeric vector of proportion of calf values
#' @param proportion_calf_cv numeric vector of proportion of calf coefficients
#'   of variation
#' @param proportion_calf_study_year character vector of proportion of calf
#'   study years
#' @param proportion_calf_day_of_year integer vector of proportion of calf days
#'   of year
#' @param analysis_mode character string of analysis mode, either "debug",
#' "check", or "report". Run firstin "debug" mode to ensure that the model
#' samples. Next, run in "report" mode to sample the full number of iterations.
#'
#' @return an `smb.analysis` object
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_analyse(
#'   event_data = bpt_event_data,
#'   location_data = bpt_location_data,
#'   census = 200L,
#'   census_cv = 0.1,
#'   census_study_year = "2021-2022",
#'   census_day_of_year = 365L,
#'   proportion_calf = c(0.201, 0.168),
#'   proportion_calf_cv = c(0.5, 0.5),
#'   proportion_calf_study_year = c("2020-2021", "2021-2022"),
#'   proportion_calf_day_of_year = c(365L, 365L),
#'   nthin = 1L,
#'   analysis_mode = "quick"
#' )
#' }
bpt_analyse <- function(
    event_data,
    location_data,
    census,
    census_cv,
    census_study_year,
    census_day_of_year,
    proportion_calf,
    proportion_calf_cv,
    proportion_calf_study_year,
    proportion_calf_day_of_year,
    nthin = 1L,
    analysis_mode = "report") {
  chk::chk_integer(nthin)
  chk::chk_gte(nthin, 1L)
  chk::chk_subset(analysis_mode, c("report", "quick", "debug"))

  data <- bpt_manipulate_data_analysis(event_data, location_data)
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
        census = census,
        census_cv = census_cv,
        census_study_year = census_study_year,
        census_day_of_year = census_day_of_year,
        proportion_calf = proportion_calf,
        proportion_calf_cv = proportion_calf_cv,
        proportion_calf_study_year = proportion_calf_study_year,
        proportion_calf_day_of_year = proportion_calf_day_of_year
      )
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
      eMAPresence[i] <- bMAPresence[season[i]]

      m0f0_doy[i] <- bPropVecDoy[id[i], 4] / bPropVecDoy[id[i], 1]

      # prop calf
      prop_calf[i] <- bPropVecAnnual[annual[i], 1] + bPropVecAnnual[annual[i], 4]
  }",
    new_expr_vec = TRUE,
    select_data = list(
      id = factor(),
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
      doy = c(1L, 365L),
      groupsize_total = 1L,
      annual = factor(),
      season = factor()
    )
  )

  embr::set_analysis_mode(analysis_mode)
  analysis <- embr::analyse(model, data = data, nthin = nthin)

  analysis
}
