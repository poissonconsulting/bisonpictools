#' Predict Total Abundance
#'
#' Predicts the total herd abundance for each study year, as the sum of the
#' predicted abundances for each class.
#'
#' @param analysis the analysis object from `bpt_analyse()`
#'
#' @return a tibble of total abundances for each study year, including the
#'   median posterior value (estimate) and lower and upper 95% credible
#'   intervals
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_abundance_total(analysis)
#' }
bpt_predict_abundance_total <- function(analysis) {
  abundance <- embr::predict(analysis, "annual", term = "eAbundance") |>
    dplyr::select("annual", "estimate", "lower", "upper")
  abundance
}
