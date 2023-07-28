#' Manipulate Data for Plot
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#'
#' @return A tibble of data ready for plotting
#' @export
#'
#' @examples
#' manipulate_data_plot(event_data(), location_data())
manipulate_data_plot <- function(event_data, location_data) {
  data <- 
    dplyr::left_join(event_data, location_data, by = "location_id") %>% 
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
      season = dplyr::case_when(
        dttr2::dtt_month(.data$dayte_time) %in% 4:6 ~ "calving",
        dttr2::dtt_month(.data$dayte_time) %in% 7:11 ~ "summer_fall",
        dttr2::dtt_month(.data$dayte_time) %in% c(12, 1:3) ~ "winter",
        .default = NA_character_
      ),
      across(
        c(.data$fa, .data$f1, .data$f0, .data$fu, .data$ma, .data$m3, .data$m2,
          .data$m1, .data$m0, .data$mu, .data$ua, .data$u1, .data$u0, .data$uu, 
          .data$herdsize),
        \(x) as.integer(x)
      ),
      location_id = factor(.data$location_id),
      year = factor(.data$year),
      season = factor(.data$season)
    ) %>% 
    dplyr::select(
      .data$location_id, .data$herdsize, .data$fa, .data$f1, .data$f0, .data$fu,
      .data$ma, .data$m3, .data$m2, .data$m1, .data$m0, .data$mu, 
      .data$ua, .data$u1, .data$u0, .data$uu, .data$season, .data$dayte_time,
      .data$year
    )
  data
}