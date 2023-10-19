#' Predict Abundance by Class
#'
#' Predicts abundances of each class for each study year.
#'
#' @param analysis the analysis object from `bpt_analyse()`
#'
#' @return a tibble of predicted abundances for each class and year, including
#'   the median posterior value (estimate) and lower and upper 95% credible
#'   intervals
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_abundance_class(analysis)
#' }
bpt_predict_abundance_class <- function(analysis) {
  abundance_F0 <- embr::predict(analysis, "annual", term = "eAbundanceF0") |> 
    dplyr::mutate(class = "F0")
  abundance_F1 <- embr::predict(analysis, "annual", term = "eAbundanceF1") |> 
    dplyr::mutate(class = "F1")
  abundance_FA <- embr::predict(analysis, "annual", term = "eAbundanceFA") |>
    dplyr::mutate(class = "FA")
  abundance_M0 <- embr::predict(analysis, "annual", term = "eAbundanceM0") |> 
    dplyr::mutate(class = "M0")
  abundance_M1 <- embr::predict(analysis, "annual", term = "eAbundanceM1") |> 
    dplyr::mutate(class = "M1")
  abundance_M2 <- embr::predict(analysis, "annual", term = "eAbundanceM2") |> 
    dplyr::mutate(class = "M2")
  abundance_M3 <- embr::predict(analysis, "annual", term = "eAbundanceM3") |> 
    dplyr::mutate(class = "M3")
  abundance_MA <- embr::predict(analysis, "annual", term = "eAbundanceMA") |> 
    dplyr::mutate(class = "MA")
  
  abundance <- 
    dplyr::bind_rows(
      abundance_F0, abundance_F1, abundance_FA, 
      abundance_M0, abundance_M1, abundance_M2, abundance_M3, abundance_MA
    ) |> 
    dplyr::select("annual", "class", "estimate", "lower", "upper")
  
  abundance
}