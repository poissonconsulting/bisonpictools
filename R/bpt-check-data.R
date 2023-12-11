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
#' @return List of data frames
#' @export
#'
#' @examples
#' \dontrun{
#' # When all data sets are present
#' data <- bpt_check_data(
#'   event = bpt_event_data,
#'   location = bpt_location_data,
#'   census = bpt_census_data,
#'   proportion_calf = bpt_proportion_calf_data,
#'   complete = TRUE,
#'   join = TRUE,
#'   check_study_years = TRUE
#' )
#' event_data <- data$event
#' location_data <- data$location
#' # To check only a single data set
#' data_1 <- bpt_check_data(location = bpt_location_data)
#' data_2 <- bpt_check_data(event = bpt_event_data)
#' data_3 <- bpt_check_data(census = bpt_census_data)
#' data_4 <- bpt_check_data(proportion_calf = bpt_proportion_calf_data)
#' # Should error, as `complete = TRUE` requires that all 4 data sets be provided
#' try(event <- bpt_check_data(event = bpt_event_data, complete = TRUE))
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
  if (check_study_years) {
    bisonpictools::bpt_check_study_year(
      event_data = event,
      census_data = census,
      proportion_calf_data = proportion_calf
    )
  }
  data
}
