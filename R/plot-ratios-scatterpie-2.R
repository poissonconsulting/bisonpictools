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

#' Plot Ratios of Ronald Wood Bison camera events
#' 
#' Generates bubble plot of ratio of the sex-age classes supplied to `numerator` and `denominator`. The ratio is given as `numerator:(denominator + numerator))` to avoid infinite values when `numerator ≥ 1` and `denominator = 0`. Each point represents an event. The size of the point represents the total group size, and the colour of the point represents the value of the ratio.
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#'
#' @return a `ggplot` object
#' @export
#'
#' @examples
#' # Plot calf:(cow + calf) ratio
#' plot_ratios_pie2(
#'   event_data = event_data(), 
#'   location_data = location_data(),
#'   numerator = c("f0", "m0", "u0"), 
#'   denominator = c("fa")
#'  )
#' # Plot ratio of female:(male + female) of yearlings in 2021 at site RBLH007 only
#' plot_ratios_pie2(
#'   event_data = event_data(), 
#'   location_data = location_data(),
#'   numerator = "f1", 
#'   denominator = "m1", 
#'  )
plot_ratios_pie2 <- function(event_data, location_data, numerator, denominator) {
  
  data <- manipulate_data_plot(event_data, location_data)
  data$numerator <- rowSums(data[, numerator])
  data$denominator <- rowSums(data[, denominator])
  data$date = dttr2::dtt_date(data$date_time)
  data <- data |> 
    tidyr::pivot_longer(
      cols = c("numerator", "denominator"),
      names_to = "num_denom"
    ) |>
    dplyr::select(
      "location_id", "date", "groupsize", "study_year", "num_denom", "value"
    )
  
  plot_dat <-
    data |> 
    dplyr::group_nest(
      .data$location_id, 
      .data$date, 
      .data$groupsize, 
      .key = "nest"
    ) |>
    dplyr::mutate(
      date = factor(date),
      # date = factor(date, levels = seq(min(data$date), max(data$date), by = "day")),
      x = as.integer(date), ### TODO: make this more formal
      y = as.integer(location_id),
      plot = purrr::map(
        .x = .data$nest,
        .f = ~ggplot2::ggplot(.x) + 
          ggplot2::aes(
            x = "",
            y = value,
            fill = num_denom
          ) +
          ggplot2::geom_bar(
            width = 1, 
            stat = "identity", 
            alpha = 0.6
          ) +
          ggplot2::scale_fill_discrete(type = c("#E8613C", "#3063A3")) +
          ggplot2::coord_polar("y") +
          ggplot2::theme(
            axis.text.x = ggplot2::element_blank(),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            panel.border = element_blank(),
            panel.grid=element_blank(),
            axis.ticks = element_blank(),
            axis.text.y = element_blank(),
            panel.background = element_rect(fill='transparent', color=NA),
            plot.background = element_rect(fill='transparent', color=NA),
            legend.position = "none"
          ) +
          ggplot2::labs(fill = "Class") 
      ),
      annotation = purrr::pmap(
        .l = list(x, y, plot, groupsize),
        .f = ~ggplot2::annotation_custom(
          ggplot2::ggplotGrob(..3),
          xmin = ..1 - 0.1 * sqrt(..4),
          xmax = ..1 + 0.1 * sqrt(..4),
          ymin = ..2 - 0.1 * sqrt(..4),
          ymax = ..2 + 0.1 * sqrt(..4)
        )
      )
    )
  
  ggplot2::ggplot(plot_dat) + 
    ggplot2::aes(x = date, y = location_id) +
    ggplot2::geom_point(alpha = 0) +
    dplyr::pull(plot_dat, annotation) +
    ggplot2::labs(size = "Manipulated Group Size")
}


seasons_plot <- function(study_year_start) {
  x <- dplyr::tibble(
    year = as.integer(study_year_start),
    year_diff = .data$year - 1972L
  )
  
  seasons() |> 
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
