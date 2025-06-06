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

#' Calculate study years
#'
#' Calculate the unique set of study years beginning on Apr. 1 of each year of a
#' templated `event_data`, `census_data`, or `proportion_calf_data` tibble.
#'
#' @param data A tibble of templated data.
#'
#' @return a character vector of unique study years
#' @export
#'
#' @examples
#' bpt_study_years(event_data)
bpt_study_years <- function(data) {
  event <- try(bpt_check_data(event = data), silent = TRUE)
  census <- try(bpt_check_data(census = data), silent = TRUE)
  proportion_calf <- try(bpt_check_data(proportion_calf = data), silent = TRUE)

  if (inherits(event, "try-error") && inherits(census, "try-error") &&
    inherits(proportion_calf, "try-error")) {
    chk::abort_chk(
      paste0(
        "Data is not a compatible tibble. Ensure columns match the formatting ",
        "for one of the `event`, `census`, or `proportion_calf` tables in the ",
        "template: see `?template`."
      )
    )
  }

  if (!inherits(event, "try-error")) {
    event <- event$event
    event$datetime_start <- dttr2::dtt_date_time_from_ints(
      year = event$start_year,
      month = event$start_month,
      day = event$start_day,
      hour = event$start_hour,
      minute = event$start_minute
    )
    event$study_year <- dttr2::dtt_study_year(event$datetime_start, 4L)
    event$study_year <- as.factor(event$study_year)
    x <- as.character(unique(event$study_year))
    return(x)
  } else if (!inherits(census, "try-error")) {
    census <- census$census
    census$date <- dttr2::dtt_date_from_ints(
      year = census$census_year,
      month = census$census_month,
      day = census$census_day
    )
    census$study_year <- dttr2::dtt_study_year(census$date, 4L)
    census$study_year <- as.factor(census$study_year)
    x <- as.character(unique(census$study_year))
    return(x)
  } else if (!inherits(proportion_calf, "try-error")) {
    proportion_calf <- proportion_calf$proportion_calf
    proportion_calf$date <- dttr2::dtt_date_from_ints(
      year = proportion_calf$proportion_calf_year,
      month = proportion_calf$proportion_calf_month,
      day = proportion_calf$proportion_calf_day
    )
    proportion_calf$study_year <- dttr2::dtt_study_year(
      proportion_calf$date,
      4L
    )
    proportion_calf$study_year <- as.factor(proportion_calf$study_year)
    x <- as.character(unique(proportion_calf$study_year))
    return(x)
  }
}
