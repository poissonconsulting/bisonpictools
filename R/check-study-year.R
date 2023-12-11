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
#'   bpt_event_data,
#'   bpt_census_data,
#'   bpt_proportion_calf_data
#' )
check_study_year <- function(
    event_data,
    census_data,
    proportion_calf_data) {
  sy_event <- bpt_study_years(event_data)
  sy_census <- bpt_study_years(census_data)
  sy_prop_calf <- bpt_study_years(proportion_calf_data)

  if (!chk::vld_subset(sy_census, sy_event)) {
    chk::abort_chk("Census data must include only dates that are within the study years of the event data.")
  }

  if (!chk::vld_subset(sy_prop_calf, sy_event)) {
    chk::abort_chk("Calf proportion data must include only dates that are within the study years of the event data.")
  }
  
  invisible(TRUE)
}
