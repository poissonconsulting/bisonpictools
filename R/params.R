# Copyright 2023 Province of Alberta

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Parameters for functions
#'
#' Descriptions of the parameters for functions
#'
#' @keywords internal
#' @param analysis Analysis object from `bpt_analyse()`.
#' @param event_data Tibble of templated event data.
#' @param location_data Tibble of templated location data.
#' @param census_data Tibble of census data.
#' @param proportion_calf_data Tibble of proportion calf data.
#' @param numerator A character vector of sex-age codes to go in the numerator
#' of the ratio.
#' @param denominator A character vector of sex-age codes to go in the
#' denominator of the ratio.
#' @param study_years A character vector of study years to include in the plot.
#' @param locations A character vector of location_ids to include in the plot.
#' @param analysis_mode Character string of analysis mode, either "debug",
#' "check", or "report".
#' @param nthin Thinning rate, takes default of 1.
#' @param levels_annual Levels of the annual factor in data.
#' @param census Integer vector of census values.
#' @param census_cv Numeric vector of census coefficients of variation.
#' @param census_study_year Character vector of census study years.
#' @param census_day_of_year Integer vector of census days of year.
#' @param proportion_calf Numeric vector of proportion of calf values.
#' @param proportion_calf_cv Numeric vector of proportion of calf coefficients
#'   of variation.
#' @param proportion_calf_study_year Character vector of proportion of calf
#'   study years.
#' @param proportion_calf_day_of_year Integer vector of proportion of calf days
#'   of year.
#' @param prediction One of the following:
#'  - "abundance-class": plots abundances by class and study year.
#'  - "abundance-total": plots total herd abundance by study year.
#'  - "survival": plots survival rates by class and study year (bull rate
#'  includes M2, M3, MA).
#'  - "fecundity": plots fecundity rate and proportion of reproductive cows.
#'  - "ratios": plots ratios by study year.
#' @name params
NULL