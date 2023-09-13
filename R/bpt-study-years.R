#' Calculate Study Years
#' 
#' Calculate the unique set of study years beginning on Apr. 1 of each year of a templated `event_data` tibble.
#'
#' @param event_data a tibble of templated event data
#'
#' @return a character vector of unique study years
#' @export
#'
#' @examples
#' bpt_study_years(bpt_event_data)
bpt_study_years <- function(event_data) {
  event_data$datetime_start <- dttr2::dtt_date_time_from_ints(
    year = event_data$start_year,
    month = event_data$start_month,
    day = event_data$start_day,
    hour = event_data$start_hour,
    minute = event_data$start_minute
  )
  event_data$study_year <- dttr2::dtt_study_year(event_data$datetime_start, 4L)
  event_data$study_year <- as.factor(event_data$study_year)
  as.character(unique(event_data$study_year))
}