#' Predict Abundance by Class
#'
#' Predicts abundances of each class for each study year.
#'
#' @inheritParams params
#'
#' @return A tibble of predicted abundances for each class and year, including
#'   the median posterior value (estimate) and lower and upper 95% credible
#'   intervals.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_abundance_class(analysis)
#' }
bpt_predict_abundance_class <- function(analysis) {
  abundance_f0 <- embr::predict(analysis, "annual", term = "eAbundanceF0") |>
    dplyr::mutate(class = "F0")
  abundance_f1 <- embr::predict(analysis, "annual", term = "eAbundanceF1") |>
    dplyr::mutate(class = "F1")
  abundance_fa <- embr::predict(analysis, "annual", term = "eAbundanceFA") |>
    dplyr::mutate(class = "FA")
  abundance_m0 <- embr::predict(analysis, "annual", term = "eAbundanceM0") |>
    dplyr::mutate(class = "M0")
  abundance_m1 <- embr::predict(analysis, "annual", term = "eAbundanceM1") |>
    dplyr::mutate(class = "M1")
  abundance_m2 <- embr::predict(analysis, "annual", term = "eAbundanceM2") |>
    dplyr::mutate(class = "M2")
  abundance_m3 <- embr::predict(analysis, "annual", term = "eAbundanceM3") |>
    dplyr::mutate(class = "M3")
  abundance_ma <- embr::predict(analysis, "annual", term = "eAbundanceMA") |>
    dplyr::mutate(class = "MA")

  abundance <-
    dplyr::bind_rows(
      abundance_f0, abundance_f1, abundance_fa,
      abundance_m0, abundance_m1, abundance_m2, abundance_m3, abundance_ma
    ) |>
    dplyr::select("annual", "class", "estimate", "lower", "upper")

  abundance
}
