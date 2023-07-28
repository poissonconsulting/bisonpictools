#' Plot Ratios of Ronald Wood Bison camera events
#'
#' @param event_data a tibble of templated event data
#' @param location_data a tibble of templated location data
#' @param numerator a character vector of sex-age codes to go in the numerator of the ratio
#' @param denominator a character vector of sex-age codes to go in the denominator of the ratio
#' @param years a numeric vector of years to include in the plot
#' @param locations a character vector of location_ids to include in the plot
#'
#' @return a `ggplot` object
#' @details
#' The ratio is presented as numerator:(denominator + numerator)) to avoid infinite values when the numerator is ≥ 1 and the denominator = 0. 
#' @export
#'
#' @examples
#' # Plot calf:(cow + calf) ratio
#' plot_ratios(event_data = event_data(), location_data = location_data(), numerator = c("f0", "m0", "u0"), denominator = c("fa"))
#' # Plot ratio of female:(male + female) of yearlings in 2021 at site RBLH007 only
#' plot_ratios(event_data = event_data(), location_data = location_data(), numerator = "f1", denominator = "m1", years = 2021, locations = "RBLH007")
plot_ratios <- function(event_data, location_data, numerator, denominator, 
                        years = unique(event_data$start_year),
                        locations = unique(location_data$location_id)) {
  
  data <- manipulate_data_plot(event_data, location_data)
  
  data$numerator <- rowSums(data[, numerator])
  data$denominator <- rowSums(data[, denominator])
  data$ratio <- data$numerator / (data$numerator + data$denominator)
  
  max_herdsize <- max(data$herdsize)
    
  data <-
    data %>% 
    dplyr::filter(
      !(numerator == 0 & denominator == 0),
      .data$year %in% years,
      .data$location_id %in% locations
    ) %>% 
    dplyr::mutate(
      year = droplevels(.data$year),
      location_id = droplevels(.data$location_id)
    )
  
  seasons <- 
    dplyr::tribble(
            ~season,           ~start_dayte,            ~end_dayte,
          "Calving",  "1972-04-01 00:00:00", "1972-06-30 00:00:00",
      "Summer/Fall",  "1972-07-01 00:00:00", "1972-11-30 00:00:00",
           "Winter",  "1972-12-01 00:00:00", "1972-12-31 00:00:00",
           "Winter",  "1972-01-01 00:00:00", "1972-03-31 00:00:00",
    ) %>% 
    dplyr::mutate(
      dplyr::across(
        dplyr::ends_with("dayte"), 
        \(x) dttr2::dtt_date_time(x) %>% 
          dttr2::dtt_dayte_time()
      )
    )
  
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
    ggplot2::labs(colour = "Ratio", size = "Herd Size", fill = "Season") +
    NULL

  gp
}
