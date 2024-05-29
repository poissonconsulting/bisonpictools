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

#' Check Study Years
#'
#' Checks that the dates provided in the census and calf proportion data are
#' within the study years of the event data.
#'
#' @inheritParams params
#'
#' @return Throws an error if the study years do not match, otherwise invisibly
#' returns TRUE.
#' @noRd
#'
#' @examples
#' check_study_year(
#'   event_data,
#'   census_data,
#'   proportion_calf_data
#' )
check_study_year <- function(
    event_data,
    census_data,
    proportion_calf_data) {
  sy_event <- bpt_study_years(event_data)
  sy_census <- bpt_study_years(census_data)
  sy_prop_calf <- bpt_study_years(proportion_calf_data)

  if (!chk::vld_subset(sy_census, sy_event)) {
    chk::abort_chk(
      paste0(
        "Census data must include only dates that are within the study years ",
        "of the event data."
      )
    )
  }

  if (!chk::vld_subset(sy_prop_calf, sy_event)) {
    chk::abort_chk(
      paste0(
        "Calf proportion data must include only dates that are within the ",
        "study years of the event data."
      )
    )
  }

  invisible(TRUE)
}
