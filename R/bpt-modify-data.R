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

#' Modify data for analysis
#'
#' Modifies data list prepared by `embr::analyse()` directly before passing to
#' model.
#'
#' @inheritParams params
#' @param data Data in list form as passed through embr::analyse().
#'
#' @return Data in list form with the new data added.
#'
#' @examples
#' \dontrun{
#' bpt_modify_data(
#'   data = list(
#'     annual = factor(c("2021-2022", "2022-2023"))
#'   ),
#'   levels_annual = c("2021-2022", "2022-2023"),
#'   census = 272L,
#'   census_cv = 20 / 272L,
#'   census_study_year = "2021-2022",
#'   census_day_of_year = 365L,
#'   proportion_calf = c(0.195, 0.151),
#'   proportion_calf_cv = c(0.5, 0.5),
#'   proportion_calf_study_year = c("2021-2022", "2022-2023"),
#'   proportion_calf_day_of_year = c(365L, 365L)
#' )
#' }
bpt_modify_data <- function(
    data,
    levels_annual,
    census,
    census_cv,
    census_study_year,
    census_day_of_year,
    proportion_calf,
    proportion_calf_cv,
    proportion_calf_study_year,
    proportion_calf_day_of_year) {
  chk::chk_list(data)
  df <- base::is.data.frame(data)
  if (df) {
    stop("Data must be in a list format as passed through embr::analyse()")
  }

  # Inputs for each type must have the same length (not strictly recyclable)
  chk::chk_true(
    length(census) == length(census_cv) &
      length(census) == length(census_study_year) &
      length(census) == length(census_day_of_year)
  )

  chk::chk_true(
    length(proportion_calf) == length(proportion_calf_cv) &
      length(proportion_calf) == length(proportion_calf_study_year) &
      length(proportion_calf) == length(proportion_calf_day_of_year)
  )

  chk::chk_integer(census)
  chk::chk_numeric(census_cv)
  chk::chk_gt(census_cv, 0)
  chk::chk_character(census_study_year)
  chk::chk_subset(census_study_year, levels_annual)
  chk::chk_integer(census_day_of_year)
  chk::chk_subset(census_day_of_year, 1:366)
  chk::chk_numeric(proportion_calf)
  chk::chk_range(proportion_calf, range = c(0, 1), inclusive = TRUE)
  chk::chk_numeric(proportion_calf_cv)
  chk::chk_gt(proportion_calf_cv, 0)
  chk::chk_character(proportion_calf_study_year)
  chk::chk_subset(proportion_calf_study_year, levels_annual)
  chk::chk_integer(proportion_calf_day_of_year)
  chk::chk_subset(proportion_calf_day_of_year, 1:366)

  ncensus <- base::length(census)
  nprop_calf <- base::length(proportion_calf)

  sCensus <- census_cv * census
  sPropCalf <- proportion_calf_cv * proportion_calf

  annual_census <- base::array(
    base::as.integer(
      base::factor(
        census_study_year,
        levels = levels_annual
      )
    ),
    dim = ncensus
  )

  annual_prop_calf <- base::array(
    base::as.integer(
      base::factor(
        proportion_calf_study_year,
        levels = levels_annual
      )
    ),
    dim = nprop_calf
  )

  census <- base::array(census, dim = ncensus)
  sCensus <- base::array(sCensus, dim = ncensus)
  doy_census <- base::array(census_day_of_year, dim = ncensus)

  proportion_calf <- base::array(proportion_calf, dim = nprop_calf)
  sPropCalf <- base::array(sPropCalf, dim = nprop_calf)
  doy_prop_calf <- base::array(proportion_calf_day_of_year, dim = nprop_calf)

  data$ncensus <- ncensus
  data$census <- census
  data$sCensus <- sCensus
  data$annual_census <- annual_census
  data$doy_census <- doy_census
  data$nprop_calf <- nprop_calf
  data$prop_calf <- proportion_calf
  data$sPropCalf <- sPropCalf
  data$annual_prop_calf <- annual_prop_calf
  data$doy_prop_calf <- doy_prop_calf

  data
}
