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

#' Plot Ratios of Ronald Wood Bison Camera Events
#' 
#' Generates bubble plot of ratio of the sex-age classes supplied to `numerator` and `denominator`. The ratio is given as `numerator:(denominator + numerator))` to avoid infinite values when `numerator ≥ 1` and `denominator = 0`. Each point represents an event. The size of the point represents the total group size, and the colour of the point represents the value of the ratio.
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#' @param numerator a character vector of sex-age codes to go in the numerator of the ratio
#' @param denominator a character vector of sex-age codes to go in the denominator of the ratio
#' @param study_years a character vector of study years to include in the plot
#' @param locations a character vector of location_ids to include in the plot
#'
#' @return a `ggplot` object
#' @export
#'
#' @examples
#' # Plot calf:(cow + calf) ratio
#' bpt_plot_ratios(
#'   event_data = bpt_event_data, 
#'   location_data = bpt_location_data, 
#'   numerator = c("f0", "m0", "u0"), 
#'   denominator = c("fa")
#'  )
#' # Plot ratio of female:(male + female) of yearlings in 2021 at site RBLH007 only
#' bpt_plot_ratios(
#'   event_data = bpt_event_data, 
#'   location_data = bpt_location_data, 
#'   numerator = "f1", 
#'   denominator = "m1", 
#'   study_years = "2020-2021", 
#'   locations = "LOCID1"
#'  )
bpt_plot_ratios <- function(event_data, location_data, numerator, denominator, 
                        study_years = bpt_study_years(event_data),
                        locations = unique(location_data$location_id)) {
  
  data <- bpt_manipulate_data_plot(event_data, location_data)
  
  max_groupsize <- max(data$groupsize)
  
  data <- bpt_manipulate_ratios(
    data = data, 
    numerator = numerator, 
    denominator = denominator, 
    study_years = study_years, 
    locations = locations
  )
  
  study_year_start <- stringr::str_extract(study_years, "\\d{4}")

  seasons <- bpt_seasons_plot(study_year_start)
  
  ratio_name <- bpt_ratio_names(numerator, denominator)
  
  data$sqrt_groupsize <- sqrt(data$groupsize)
  
  if (nrow(data) == 0L) stop("There are 0 individuals in the selection for numerator and denominator. Ratio not plotted.")
  
  gp <- ggplot2::ggplot() +
    ggplot2::geom_rect(
      data = seasons,
      ggplot2::aes(
        fill = .data$season,
        xmin = .data$start_date_time,
        xmax = .data$end_date_time
      ),
      ymin = 0,
      ymax = nlevels(data$location_id) + 1,
      alpha = 0.1
    ) +
    ggplot2::geom_point(
      data = data,
      ggplot2::aes(
        x = .data$date_time,
        y = .data$location_id,
        alpha = .data$sqrt_groupsize,
        size = .data$ratio
      )
    ) +
    ggplot2::facet_wrap(~.data$study_year, scales = "free_x") +
    ggplot2::scale_x_datetime(
      date_breaks = "1 month",
      date_labels = "%b",
      expand = c(0.02, 0)
    ) +
    ggplot2::scale_fill_discrete(type = c("#63BB42", "#F7B500", "#7D7D7D")) +
    ggplot2::scale_size_continuous(
      breaks = (seq(0, 1, by = 0.2)),
      limits = c(0, 1)
    ) +
    ggplot2::scale_alpha_continuous(
      range = c(0, 1),
      limits = c(0, sqrt(max(data$groupsize))),
      labels = function(x) format(x^2, scientific = FALSE)
    ) +
    ggplot2::guides(
      fill = ggplot2::guide_legend(order = 1),
      size = ggplot2::guide_legend(show.limits = TRUE, order = 2),
      alpha = ggplot2::guide_legend(show.limits = TRUE, order = 3)
    ) +
    ggplot2::xlab("Date") +
    ggplot2::ylab("Location ID") +
    ggplot2::labs(alpha = "Group Size", size = ratio_name, fill = "Season") +
    NULL

  gp
}


bpt_seasons_plot <- function(study_year_start) {
  x <- dplyr::tibble(
    year = as.integer(study_year_start),
    year_diff = .data$year - 1972L
  )
  
  bpt_seasons() |> 
    dplyr::cross_join(x) |> 
    dplyr::mutate(
      start_date_time = dttr2::dtt_add_years(.data$start_dayte, .data$year_diff),
      end_date_time = dttr2::dtt_add_years(.data$end_dayte, .data$year_diff),
      study_year = stringr::str_c(as.character(.data$year), "-", as.character(.data$year + 1)),
      study_year = factor(.data$study_year),
      season = factor(.data$season, levels = c("Calving", "Summer/Fall", "Winter"))
    ) |> 
    dplyr::select(
      "season", "start_date_time", "end_date_time", 'study_year'
    )
}