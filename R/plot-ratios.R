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
#' Generates bubble plot of ratio of the sex-age classes supplied to `numerator` and `denominator`. The ratio is given as numerator`:(`denominator` + `numerator`)) to avoid infinite values when the numerator is ≥ 1 and the denominator = 0. Each point represents an event. The size of the point represents the total herd size, and the colour of the point represents the value of the ratio.
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#' @param numerator a character vector of sex-age codes to go in the numerator of the ratio
#' @param denominator a character vector of sex-age codes to go in the denominator of the ratio
#' @param years a numeric vector of years to include in the plot
#' @param locations a character vector of location_ids to include in the plot
#'
#' @return a `ggplot` object
#' @export
#'
#' @examples
#' # Plot calf:(cow + calf) ratio
#' plot_ratios(
#'   event_data = event_data(), 
#'   location_data = location_data(), 
#'   numerator = c("f0", "m0", "u0"), 
#'   denominator = c("fa")
#'  )
#' # Plot ratio of female:(male + female) of yearlings in 2021 at site RBLH007 only
#' plot_ratios(
#'   event_data = event_data(), 
#'   location_data = location_data(), 
#'   numerator = "f1", 
#'   denominator = "m1", 
#'   years = "2021", 
#'   locations = "RLBH007"
#'  )
plot_ratios <- function(event_data, location_data, numerator, denominator, 
                        years = unique(as.character(event_data$start_year)),
                        locations = unique(location_data$location_id)) {
  
  data <- manipulate_data_plot(event_data, location_data)
  
  max_herdsize <- max(data$herdsize)
  
  data <- manipulate_ratios(
    data = data, 
    numerator = numerator, 
    denominator = denominator, 
    years = years, 
    locations = locations
  )

  seasons <- seasons()
  
  ratio_name <- ratio_names(numerator, denominator)
  
  gp <- ggplot2::ggplot() +
    ggplot2::geom_rect(
      data = seasons,
      ggplot2::aes(
        fill = .data$season,
        xmin = .data$start_dayte,
        xmax = .data$end_dayte
      ),
      ymin = 0,
      ymax = nlevels(data$location_id) + 1,
      alpha = 0.1
    ) +
    ggplot2::geom_point(
      data = data,
      ggplot2::aes(
        x = .data$dayte_time,
        y = .data$location_id,
        size = .data$herdsize,
        colour = .data$ratio
      ),
      alpha = 0.5
    ) +
    ggplot2::facet_wrap(~.data$year) +
    ggplot2::scale_size_continuous(
      breaks = round(seq(1, max_herdsize, length.out = 4)),
      limits = c(0, max_herdsize)
    ) +
    ggplot2::scale_fill_discrete(type = c("#63BB42", "#F7B500", "#7D7D7D")) +
    ggplot2::scale_x_datetime(
      date_breaks = "1 month", 
      date_labels = "%b", 
      expand = c(0.02, 0)
    ) +
    ggplot2::scale_colour_gradient(
      breaks = seq(0, 1, by = 0.2),
      limits = c(0, 1)
    ) +
    ggplot2::guides(
      colour = ggplot2::guide_legend(show.limits = TRUE, order = 3),
      fill = ggplot2::guide_legend(order = 1),
      size = ggplot2::guide_legend(order = 2)
    ) +
    ggplot2::expand_limits(
      x = c(
        as.POSIXct("1972-01-01 00:00:00"), 
        as.POSIXct("1972-12-31 11:59:59")
      )
    ) +
    ggplot2::xlab("Date") +
    ggplot2::ylab("Location ID") +
    ggplot2::labs(colour = ratio_name, size = "Herd Size", fill = "Season") +
    NULL

  gp
}
