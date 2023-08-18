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
#' plot_ratios_pie(
#'   event_data = event_data(), 
#'   location_data = location_data()
#'  )
#' # Plot ratio of female:(male + female) of yearlings in 2021 at site RBLH007 only
#' plot_ratios_pie(
#'   event_data = event_data(), 
#'   location_data = location_data()
#'  )
plot_ratios_pie <- function(event_data, location_data) {
  
  data <- manipulate_data_plot(event_data, location_data)
  classes <- colnames(data)[3:16]
  data <- data |> 
    dplyr::mutate(
      dplyr::across(
        c("fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", "m0", "mu", 
          "ua", "u1", "u0", "uu", "groupsize"),
        \(x) as.numeric(x)
      )
    )
  
  max_groupsize <- max(data$groupsize)
  
  # study_years <- as.character(unique(data$study_year))
  # study_year_start <- stringr::str_extract(study_years, "\\d{4}")
  
  # seasons <- seasons_plot(study_year_start)
  
  gp <- ggplot2::ggplot() +
    # ggplot2::geom_rect(
    #   data = seasons,
    #   ggplot2::aes(
    #     fill = .data$season,
    #     xmin = .data$start_date_time,
    #     xmax = .data$end_date_time
    #   ),
    #   ymin = 0,
    #   ymax = nlevels(data$location_id) + 1,
    #   alpha = 0.1
    # ) +
    scatterpie::geom_scatterpie(
      data = data,
      ggplot2::aes(
        x = scale(as.numeric(.data$date_time)),
        y = scale(as.integer(.data$location_id)),
        r = .data$groupsize / 500
      ),
      cols = c("fa", "f1", "f0", "fu", "ma", "m3", "m2", "m1", "m0", "mu", 
               "ua", "u1", "u0", "uu"),
      alpha = 0.9
    ) +
    # ggplot2::geom_point(
    #   data = data,
    #   ggplot2::aes(
    #     x = .data$date_time,
    #     y = .data$location_id,
    #     alpha = .data$groupsize,
    #     # colour = .data$groupsize,
    #     size = .data$ratio
    #   ),
    #   alpha = 0.5
    # ) +
    ggplot2::facet_wrap(~.data$study_year, scales = "free_x") +
    ggplot2::scale_size_continuous(
      breaks = (seq(0, 1, by = 0.2)),
      limits = c(0, 1)
    ) +
    # ggplot2::scale_colour_gradient(
    #   n.breaks = 4
    # ) +
    # ggplot2::scale_fill_discrete(type = c("#63BB42", "#F7B500", "#7D7D7D")) +
    ggplot2::scale_x_datetime(
      date_breaks = "1 month",
      date_labels = "%b",
      expand = c(0.02, 0)
    ) +
    ggplot2::guides(
      # colour = ggplot2::guide_legend(show.limits = TRUE, order = 3),
      # alpha = ggplot2::guide_legend(show.limits = TRUE, order = 3),
      fill = ggplot2::guide_legend(order = 1),
      size = ggplot2::guide_legend(show.limits = TRUE, order = 2)
    ) +
    ggplot2::xlab("Date") +
    ggplot2::ylab("Location ID") +
    # ggplot2::labs(colour = "Group Size", size = ratio_name, fill = "Season") +
    # ggplot2::labs(alpha = "Group Size", size = ratio_name, fill = "Season") +
    NULL
  
  gp
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
