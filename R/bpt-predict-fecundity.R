#' Predict Fecundity
#'
#' Predicts the fecundity rate and proportion of reproductive cows
#'
#' @param analysis the analysis object from `bpt_analyse()`
#'
#' @return a tibble of predicted fecundity rate and proportion of reproductive
#'   cows, including the median posterior value (estimate) and lower and upper
#'   95% credible intervals
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_fecundity(analysis)
#' }
bpt_predict_fecundity <- function(analysis) {
  fecundity <- embr::predict(
    analysis,
    base::character(0),
    term = "PredFecundityReproductiveFA"
  ) |>
    dplyr::mutate(rate = "Fecundity")

  prop_reproductive <- embr::predict(
    analysis,
    base::character(0),
    term = "ePropReproductiveFA"
  ) |>
    dplyr::mutate(rate = "Proportion of Reproductive Cows")

  rates <- dplyr::bind_rows(fecundity, prop_reproductive) |>
    dplyr::select(
      "rate", "estimate", "lower", "upper"
    )

  rates
}
