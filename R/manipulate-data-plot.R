#' Manipulate Data for Plot
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#'
#' @return A tibble of data ready for plotting
#' @export
#'
#' @examples
#'
manipulate_data_plot <- function(event_data, location_data) {
  data <- 
    dplyr::left_join(event_data, location_data, by = "location_id") %>% 
    dplyr::mutate(
      datetime_start = dttr2::dtt_date_time_from_ints(
        year = start_year,
        month = start_month,
        day = start_day,
        hour = start_hour,
        minute = start_minute
        # tz = ?
      ),
      herdsize = (fa + f1 + f0 + fu + ma + m3 + m2 + m1 + m0 + mu + ua + u1 + u0 + uu),
      year = dttr2::dtt_year(datetime_start),
      dayte_time = dttr2::dtt_dayte_time(datetime_start),
      season = dplyr::case_when(
        dttr2::dtt_month(dayte_time) %in% 4:6 ~ "calving",
        dttr2::dtt_month(dayte_time) %in% 7:11 ~ "summer_fall",
        dttr2::dtt_month(dayte_time) %in% c(12, 1:3) ~ "winter",
        .default = NA_character_
      ),
      location_id = factor(location_id)
    ) %>% 
    dplyr::select(
      location_id, herdsize, fa, f1, f0, fu, ma, m3, m2, m1, m0, mu, ua, u1, u0, uu, 
      season, dayte_time
    )
  data
}