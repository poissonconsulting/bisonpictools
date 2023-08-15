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

#' Manipulate Ratios
#' 
#' Takes output from `manipulate_data_plot()` and calculates ratio of interest for plotting. Ratio of interest is calculated as numerator:(denominator + numerator) to avoid infinite values.
#'
#' @param data a tibble of manipulated event and location data, with factor columns `year`, `location_id`, and integer columns c(`fa`, `f1`, `f0`, `fu`, `ma`, `m3`, `m2`, `m1`, `m0`, `mu`, `ua`, `u1`, `u0`, and `uu`)
#' @param numerator a character vector of sex-age codes to go in the numerator of the ratio
#' @param denominator a character vector of sex-age codes to go in the denominator of the ratio
#' @param years a character vector of years to include in the plot
#' @param locations a character vector of location_ids to include in the plot
#'
#' @return the original tibble, with additional columns `numerator`, `denominator`, and `ratio`
#' @export
#'
#' @examples
#' manipulate_ratios(
#'  data = manipulate_data_plot(event_data(), location_data()),
#'  numerator = "fa", 
#'  denominator = "ma", 
#'  years = "2021", 
#'  locations = "RLBH007"
#' )
manipulate_ratios <- function(data, numerator, denominator, years = unique(data$year), locations = unique(data$location_id)) {
  chk::chk_data(data)
  chk::chk_character(numerator)
  chk::chk_character(denominator)
  chk::chk_character_or_factor(years)
  chk::chk_character_or_factor(locations)
  chk::chk_true(all(years %in% data$year))
  chk::chk_true(all(locations %in% data$location_id))
  
  data$numerator <- rowSums(data[, numerator])
  data$denominator <- rowSums(data[, denominator])
  data$ratio <- data$numerator / (data$numerator + data$denominator)
  
  data <-
    data |> 
    dplyr::filter(
      !(numerator == 0 & denominator == 0),
      .data$year %in% years,
      .data$location_id %in% locations
    ) |> 
    dplyr::mutate(
      year = droplevels(.data$year),
      location_id = droplevels(.data$location_id)
    )
  
  data
}

# Tests;
# max ratio is 1