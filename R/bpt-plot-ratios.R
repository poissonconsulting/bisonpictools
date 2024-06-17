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

#' Plot Ratios of Wood Bison Camera Events
#'
#' Generates bubble plot of ratio of the sex-age classes supplied to `numerator`
#' and `denominator`. Each point represents an event. The size of the point 
#' represents the total group size, and the colour of the point represents the 
#' value of the ratio. Note that a ratio value of "Inf" (infinity) indicates 
#' that the group in a particular camera trap event has no individuals in the 
#' denominator class. Similarly, a ratio of "0" indicates that the ratio in 
#' a particular camera trap event has no individuals in the numerator class.
#'
#' @inheritParams params
#' @param ratio_name An alternate name for the label for the value of the ratio
#' on the plot legend. Defaults to "Ratio".
#'
#' @return A `ggplot` object.
#' @export
#'
#' @examples
#' # Plot calf:cow ratio
#' bpt_plot_ratios(
#'   event_data = event_data,
#'   location_data = location_data,
#'   numerator = c("f0", "m0", "u0"),
#'   denominator = c("fa")
#' )
#' # Plot ratio of female:male yearling ratio in 2020-2021 at site RBLH007
#' bpt_plot_ratios(
#'   event_data = event_data,
#'   location_data = location_data,
#'   numerator = "f1",
#'   denominator = "m1",
#'   study_years = "2020-2021",
#'   locations = "LOCID1"
#' )
bpt_plot_ratios <- function(
    event_data,
    location_data,
    numerator,
    denominator,
    study_years = bpt_study_years(event_data),
    locations = unique(location_data$location_id),
    ratio_name = "Ratio") {
  data <- bpt_manipulate_data_plot(
    event_data,
    location_data
  )

  data <- bpt_manipulate_ratios(
    data = data,
    numerator = numerator,
    denominator = denominator,
    study_years = study_years,
    locations = locations
  )

  study_year_start <- stringr::str_extract(study_years, "\\d{4}")
  seasons <- bpt_seasons_plot(study_year_start)
  data$sqrt_groupsize <- sqrt(data$groupsize)

  if (nrow(data) == 0L) {
    stop(
      paste0(
        "There are 0 individuals in the selection for numerator and ",
        "denominator. Ratio not plotted."
      )
    )
  }

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
    ggplot2::facet_wrap(~ .data$study_year, scales = "free_x") +
    ggplot2::scale_x_datetime(
      date_breaks = "1 month",
      date_labels = "%b",
      expand = c(0.02, 0)
    ) +
    ggplot2::scale_fill_discrete(type = c("#63BB42", "#F7B500", "#7D7D7D")) +
    ggplot2::scale_size_continuous(
      labels = function(breaks) {
        labels <- -breaks / (breaks - 1)
        labels <- round(labels, digits = 1)
        labels[labels == -Inf] <- "Inf"
        labels
      }
    ) +
    ggplot2::scale_alpha_continuous(
      range = c(0, 1),
      limits = c(0, sqrt(max(data$groupsize))),
      labels = function(x) format(x^2, scientific = FALSE)
    ) +
    ggplot2::guides(
      x = ggplot2::guide_axis(angle = 45),
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
      start_date_time = dttr2::dtt_add_years(
        .data$start_dayte,
        .data$year_diff
      ),
      end_date_time = dttr2::dtt_add_years(
        .data$end_dayte,
        .data$year_diff
      ),
      study_year = stringr::str_c(
        as.character(.data$year),
        "-",
        as.character(.data$year + 1)
      ),
      study_year = factor(.data$study_year),
      season = factor(
        .data$season,
        levels = c("Calving", "Summer/Fall", "Winter")
      )
    ) |>
    dplyr::select(
      "season", "start_date_time", "end_date_time", "study_year"
    )
}
