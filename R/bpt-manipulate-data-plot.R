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

#' Manipulate Data for Plot
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#' @param census_data a tibble of census data
#' @param proportion_calf_data a tibble of proportion calf data
#'
#' @return A tibble of data prepared for plotting.
#' @export
#'
#' @examples
#' bpt_manipulate_data_plot(
#'  bpt_event_data, 
#'  bpt_location_data, 
#'  bpt_census_data, 
#'  bpt_proportion_calf_data
#' )
bpt_manipulate_data_plot <- function(
    event_data, 
    location_data,
    census_data,
    proportion_calf_data
) {
  data <- bpt_check_data(
    location = location_data,
    event = event_data,
    census = census_data,
    proportion_calf = proportion_calf_data,
    complete = TRUE
  )

  event_data <- data$event
  location_data <- data$location

  data <-
    dplyr::left_join(event_data, location_data, by = "location_id") |>
    dplyr::mutate(
      datetime_start = dttr2::dtt_date_time_from_ints(
        year = .data$start_year,
        month = .data$start_month,
        day = .data$start_day,
        hour = .data$start_hour,
        minute = .data$start_minute
      ),
      groupsize = .data$fa + .data$f1 + .data$f0 + .data$fu + .data$ma +
        .data$m3 + .data$m2 + .data$m1 + .data$m0 + .data$mu +
        .data$ua + .data$u1 + .data$u0 + .data$uu,
      year = dttr2::dtt_year(.data$datetime_start),
      study_year = dttr2::dtt_study_year(.data$datetime_start, 4L),
      month = dttr2::dtt_month(.data$datetime_start),
      dplyr::across(
        c(
          "fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", "m0", "mu", "ua",
          "u1", "u0", "uu", "groupsize"
        ),
        \(x) base::as.integer(x)
      )
    ) |>
    dplyr::mutate(
      location_id = factor(.data$location_id),
      year = factor(.data$year),
      study_year = factor(.data$study_year),
    ) |>
    dplyr::rename(
      date_time = "datetime_start"
    ) |>
    dplyr::select(
      "location_id", "groupsize", "fa", "f1", "f0", "fu", "ma", "m3", "m2",
      "m1", "m0", "mu", "ua", "u1", "u0", "uu", "study_year", "date_time",
      "year"
    )
  data
}
