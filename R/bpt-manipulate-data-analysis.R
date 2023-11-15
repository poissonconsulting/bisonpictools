#' Prepare Data for Analysis
#'
#' Checks that data is in the correct format and manipulates it for analysis.
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#' @param census_data a tibble of templated census data
#' @param proportion_calf_data a tibble of templated proportion of calf data
#'
#' @return a list of manipulated data ready for analysis
#' @export
#'
#' @examples
#' bpt_manipulate_data_analysis(
#'   event_data = bpt_event_data,
#'   location_data = bpt_location_data,
#'   census_data = bpt_census_data,
#'   proportion_calf_data = bpt_proportion_calf_data
#' )
bpt_manipulate_data_analysis <- function(
    event_data, 
    location_data,
    census_data,
    proportion_calf_data
) {
  data <- bpt_check_data(
    event = event_data,
    location = location_data,
    census = census_data,
    proportion_calf = proportion_calf_data,
    complete = TRUE,
    join = TRUE,
    check_study_years = TRUE
  )
  
  census_data <- data$census |> 
    dplyr::mutate(
      date = dttr2::dtt_date_from_ints(
        year = .data$census_year,
        month = .data$census_month,
        day = .data$census_day
      ),
      census_study_year = dttr2::dtt_study_year(date, start = 4L),
      doy = dttr2::dtt_doy(.data$date) -
        dttr2::dtt_doy(dttr2::dtt_date("2019-04-01")),
      doy = dplyr::if_else(.data$doy < 0, .data$doy + 365, .data$doy),
      census_doy = base::as.integer(.data$doy),
    ) |> 
    dplyr::select(
      "census", "census_cv", "census_study_year", "census_doy"
    )
  
  prop_calf_data <- data$proportion_calf |> 
    dplyr::rename(
      prop_calf = "proportion_calf",
      prop_calf_cv = "proportion_calf_cv",
    ) |> 
    dplyr::mutate(
      date = dttr2::dtt_date_from_ints(
        year = .data$proportion_calf_year,
        month = .data$proportion_calf_month,
        day = .data$proportion_calf_day
      ),
      prop_calf_study_year = dttr2::dtt_study_year(date, start = 4L),
      doy = dttr2::dtt_doy(.data$date) -
        dttr2::dtt_doy(dttr2::dtt_date("2019-04-01")),
      doy = dplyr::if_else(.data$doy < 0, .data$doy + 365, .data$doy),
      prop_calf_doy = base::as.integer(.data$doy),
    ) |> 
    dplyr::select(
      "prop_calf", "prop_calf_cv", "prop_calf_study_year", "prop_calf_doy"
    )

  seasons_long <-
    bpt_seasons() |>
    dplyr::group_by(.data$season) |>
    tidyr::expand(
      dayte = base::seq(.data$start_dayte, .data$end_dayte, "day")
    ) |>
    dplyr::ungroup() |>
    dplyr::mutate(dayte = dttr2::dtt_dayte(.data$dayte))

  data <-
    data$event |>
    dplyr::mutate(
      groupsize_total = .data$fa + .data$f1 + .data$f0 + .data$fu + .data$ma +
        .data$m3 + .data$m2 + .data$m1 + .data$m0 + .data$mu + .data$ua +
        .data$u1 + .data$u0 + .data$uu,
      calf = .data$f0 + .data$m0 + .data$u0,
      yearling = .data$f1 + .data$m1 + .data$u1,
      adult = .data$fa + .data$m2 + .data$m3 + .data$ma + .data$ua,
      datetime_start = dttr2::dtt_date_time_from_ints(
        year = .data$start_year,
        month = .data$start_month,
        day = .data$start_day,
        hour = .data$start_hour,
        minute = .data$start_minute
      ),
      year = dttr2::dtt_year(.data$datetime_start),
      annual = dttr2::dtt_study_year(
        .data$datetime_start,
        start = 4L,
        full = TRUE
      ),
      dayte = dttr2::dtt_dayte(.data$datetime_start),
      day = base::as.integer(dttr2::dtt_date(.data$datetime_start)),
      day = .data$day - base::min(.data$day),
      week = base::as.integer(.data$day %/% 7 + 1),
      weekfac = base::factor(.data$week),
      doy = dttr2::dtt_doy(.data$datetime_start) -
        dttr2::dtt_doy(dttr2::dtt_date("2019-04-01")),
      doy = dplyr::if_else(.data$doy < 0, .data$doy + 365, .data$doy),
      doy = base::as.integer(.data$doy),
      doy_fac = base::factor(.data$doy),
      month = dttr2::dtt_month(.data$datetime_start)
    ) |>
    dplyr::left_join(
      seasons_long,
      by = "dayte"
    ) |>
    dplyr::mutate(
      season = base::factor(
        .data$season,
        levels = c("Calving", "Summer/Fall", "Winter")
      )
    ) |>
    # Exclude calving season from analysis
    dplyr::filter(.data$season %in% c("Winter", "Summer/Fall")) |>
    dplyr::arrange(.data$datetime_start) |>
    dplyr::mutate(
      annual = base::factor(.data$annual),
      season = base::droplevels(.data$season),
      season_annual = stringr::str_c(
        base::as.character(.data$season),
        base::as.character(.data$annual),
        sep = " "
      ),
      season_annual = forcats::fct(.data$season_annual)
    ) |>
    dplyr::rename(location = "location_id") |>
    dplyr::arrange(.data$location, .data$weekfac) |>
    # Remove bachelor groups
    dplyr::filter(.data$groupsize_total > (.data$m2 + .data$m3 + .data$ma)) |>
    dplyr::mutate(
      location = factor(.data$location),
      location_weekfac = base::paste(.data$location, .data$week),
      location_weekfac = base::factor(.data$location_weekfac),
      id = base::factor(seq_len(dplyr::n()))
    ) |>
    dplyr::select(
      "f0", "f1", "m2", "m3", "ma", "fa", "m0", "m1", "u0", "u1", "ua",
      "calf", "yearling", "adult", "groupsize_total",
      "annual", "week", "weekfac", "season", "doy", "doy_fac",
      "location", "location_weekfac", "season_annual", "id"
    )

  chk::chk_not_any_na(data)
  
  chk::chk_all(
    c(census_data$census_study_year, prop_calf_data$prop_calf_study_year),
    chk_fun = chk::chk_subset,
    values = base::levels(data$annual)
  )

  data_list <- base::list(
    data = data,
    census_data = census_data,
    prop_calf_data = prop_calf_data
  )
  
  data_list
}
