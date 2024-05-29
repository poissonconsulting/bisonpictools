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

#' Data Checks based on the Template
#'
#' Confirms the columns types match the
#' template, the values follow the allowed ranges of the template and tables can
#' be joined appropriately.
#'
#' @param event A data frame of event data.
#' @param location A data frame of location data.
#' @param census A data frame of census data.
#' @param proportion_calf A data frame of calf proportion data.
#' @param complete A flag indicating if all data frames need to be supplied.
#' @param join A flag indicating if joins should be checked.
#' @param check_study_years A flag indicating if study years should be checked
#' (census and calf proportion data must be within the same study years as the
#' event data)
#'
#' @return A list of data frames.
#' @export
#'
#' @examples
#' \dontrun{
#' # When all data sets are present
#' data <- bpt_check_data(
#'   event = event_data,
#'   location = location_data,
#'   census = census_data,
#'   proportion_calf = proportion_calf_data,
#'   complete = TRUE,
#'   join = TRUE,
#'   check_study_years = TRUE
#' )
#' event_data <- data$event
#' location_data <- data$location
#' # To check only a single data set
#' data_1 <- bpt_check_data(location = location_data)
#' data_2 <- bpt_check_data(event = event_data)
#' data_3 <- bpt_check_data(census = census_data)
#' data_4 <- bpt_check_data(proportion_calf = proportion_calf_data)
#' # Should error, as `complete = TRUE` requires all 4 data sets be provided
#' try(event <- bpt_check_data(event = event_data, complete = TRUE))
#' }
bpt_check_data <- function(
    event = NULL,
    location = NULL,
    census = NULL,
    proportion_calf = NULL,
    complete = FALSE,
    join = FALSE,
    check_study_years = FALSE) {
  data <- chktemplate::check_data_format(
    event = event,
    location = location,
    census = census,
    proportion_calf = proportion_calf,
    template = bisonpictools::template,
    complete = complete,
    join = join
  )
  if (!is.null(location)) {
    groups <-
      location |>
      dplyr::group_by(.data$latitude, .data$longitude) |>
      dplyr::n_groups()
    if (groups < nrow(location)) {
      warning(
        "Location data contains duplicate coordinates."
      )
    }
  }
  if (check_study_years) {
    check_study_year(
      event_data = event,
      census_data = census,
      proportion_calf_data = proportion_calf
    )
  }
  data
}
