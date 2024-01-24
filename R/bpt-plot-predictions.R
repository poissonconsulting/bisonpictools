#' Plot Predictions
#'
#' Generates a plot of the specified prediction
#'
#' @inheritParams params
#'
#' @return A `ggplot2` object.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_plot_predictions(analysis = analysis, prediction = "abundance-class")
#' bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
#' bpt_plot_predictions(analysis = analysis, prediction = "survival")
#' bpt_plot_predictions(analysis = analysis, prediction = "fecundity")
#' bpt_plot_predictions(analysis = analysis, prediction = "ratios")
#' }
bpt_plot_predictions <- function(analysis, prediction = "abundance-total") {
  preds <- base::switch(prediction,
    "abundance-class" = bisonpictools::bpt_predict_abundance_class(analysis),
    "abundance-total" = bisonpictools::bpt_predict_abundance_total(analysis),
    "survival" = bisonpictools::bpt_predict_survival(analysis),
    "fecundity" = bisonpictools::bpt_predict_fecundity(analysis),
    "ratios" = bisonpictools::bpt_predict_ratios(analysis)
  )

  xvar <- base::switch(prediction,
    "abundance-class" = "annual",
    "abundance-total" = "annual",
    "survival" = "annual",
    "fecundity" = "rate",
    "ratios" = "annual"
  )

  facets <- base::switch(prediction,
    "abundance-class" = "class",
    "survival" = "class",
    "ratios" = "ratio",
    "fecundity" = NA_character_,
    "abundance-total" = NA_character_
  )

  scales <- base::switch(prediction,
    "abundance-class" = "free_y",
    "survival" = "free_y",
    "ratios" = "free_y"
  )

  xlab <- base::switch(prediction,
    "abundance-class" = "Study Year",
    "abundance-total" = "Study Year",
    "survival" = "Study Year",
    "fecundity" = "Term",
    "ratios" = "Study Year"
  )

  ylab <- base::switch(prediction,
    "abundance-class" = "Abundance",
    "abundance-total" = "Abundance",
    "survival" = "Survival Rate (%)",
    "fecundity" = "Rate (%)",
    "ratios" = "Ratio"
  )

  expand_lims <- base::switch(prediction,
    "abundance-class" = c(0),
    "abundance-total" = c(0),
    "survival" = c(0, 1),
    "fecundity" = c(0, 1),
    "ratios" = c(0)
  )


  gp <- ggplot2::ggplot(preds) +
    ggplot2::geom_pointrange(
      ggplot2::aes(
        x = .data[[xvar]],
        y = .data$estimate,
        ymin = .data$lower,
        ymax = .data$upper
      )
    ) +
    ggplot2::expand_limits(y = c(expand_lims[1], expand_lims[2])) +
    ggplot2::xlab(xlab) +
    ggplot2::ylab(ylab) +
    NULL

  if (!is.na(facets)) {
    gp <- gp +
      ggplot2::facet_wrap(
        facets = facets,
        scales = scales
      ) +
      ggplot2::guides(x = ggplot2::guide_axis(angle = 45))
  }

  gp
}
