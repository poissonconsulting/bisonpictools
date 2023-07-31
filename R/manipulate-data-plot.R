#Copyright 2023 Province of Alberta

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

#' Manipulate Data for Plot
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#'
#' @return A tibble of data prepared for plotting.
#' @export
#'
#' @examples
#' manipulate_data_plot(event_data(), location_data())
manipulate_data_plot <- function(event_data, location_data) {
  # TODO:: add checks, one for each argument.
  chk::chk_data(event_data)
  chk::chk_data(location_data)
  # Check names
  chk::check_names(
    event_data, 
    c("location_id", "start_year", "start_month", "start_day", "start_hour", 
      "start_minute", "fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", 
      "m0", "mu", "ua", "u1", "u0", "uu")
  )
  chk::check_names(location_data, c("location_id", "latitude", "longitude"))
  chk::chk_all(
    event_data[, c("fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", "m0", "mu", 
                   "ua", "u1", "u0", "uu", "start_year", "start_month", 
                   "start_day", "start_hour", "start_minute")],
    chk::chk_integer
  )
  chk::chk_character_or_factor(event_data$location_id)
  chk::chk_all(location_data[, c("latitude", "longitude")], chk::chk_numeric)
  chk::chk_character_or_factor(event_data$location_id)
  chk::chk_true(all(event_data$location_id %in% location_data$location_id))
  
  seasons_dat <- seasons() |>
    tidyr::pivot_longer(
      cols = c("start_dayte", "end_dayte"),
      names_to = NULL,
      values_to = "dayte"
    ) |>
    dplyr::mutate(
      season = dplyr::if_else(dttr2::dtt_month(.data$dayte) == 12, "Winter2", .data$season),
      dayte = dttr2::dtt_dayte(.data$dayte)
    ) |>
    dplyr::group_by(.data$season) |>
    tidyr::complete(dayte = seq(min(.data$dayte), max(.data$dayte), by = "1 day")) |>
    dplyr::ungroup() |>
    dplyr::arrange(.data$dayte) |>
    dplyr::mutate(
      season = dplyr::if_else(.data$season == "Winter2", "Winter", .data$season)
    )
  
  data <- 
    dplyr::left_join(event_data, location_data, by = "location_id") |> 
    dplyr::mutate(
        datetime_start = dttr2::dtt_date_time_from_ints(
          year = .data$start_year,
          month = .data$start_month,
          day = .data$start_day,
          hour = .data$start_hour,
          minute = .data$start_minute
          # tz = ?
        ),
        herdsize = .data$fa + .data$f1 + .data$f0 + .data$fu + .data$ma + 
          .data$m3 + .data$m2 + .data$m1 + .data$m0 + .data$mu + 
          .data$ua + .data$u1 + .data$u0 + .data$uu,
        year = dttr2::dtt_year(.data$datetime_start),
        dayte_time = dttr2::dtt_dayte_time(.data$datetime_start),
        dayte = dttr2::dtt_dayte(.data$dayte_time),
        across(
          c("fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", "m0", "mu", "ua", 
            "u1", "u0", "uu", "herdsize"),
          \(x) as.integer(x)
        )
      ) |> 
      dplyr::left_join(seasons_dat, by = "dayte") |>
      dplyr::mutate(
        location_id = factor(.data$location_id),
        year = factor(.data$year),
        season = factor(.data$season)
      ) |>
      dplyr::select(
        "location_id", "herdsize", "fa", "f1", "f0", "fu", "ma", "m3", "m2", 
        "m1", "m0", "mu", "ua", "u1", "u0", "uu", "season", "dayte_time", "year"
      )
  data
}
