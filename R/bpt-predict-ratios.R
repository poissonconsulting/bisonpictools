#' Predict Ratios
#'
#' Predicts the following ratios for each study year: M0:F0, M1:F1, Calf:FA,
#' Yearling:FA, M2:FA, M3:FA, MA:FA
#'
#' @param analysis the analysis object from `bpt_analyse()`
#'
#' @return a tibble of predicted ratios for each study year, including the
#'   median posterior value (estimate) and lower and upper 95% credible
#'   intervals
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_ratios(analysis)
#' }
bpt_predict_ratios <- function(analysis) {
  m0_f0 <- embr::predict(analysis, "annual", term = "m0_f0") |> 
    dplyr::mutate(ratio = "M0:F0")
  m1_f1 <- embr::predict(analysis, "annual", term = "m1_f1") |> 
    dplyr::mutate(ratio = "M1:F1")
  calf_fa <- embr::predict(analysis, "annual", term = "calf_fa") |>
    dplyr::mutate(ratio = "Calf:FA")
  yearling_fa <- embr::predict(analysis, "annual", term = "yearling_fa") |>
    dplyr::mutate(ratio = "Yearling:FA")
  m2_fa <- embr::predict(analysis, "annual", term = "m2_fa") |> 
    dplyr::mutate(ratio = "M2:FA")
  m3_fa <- embr::predict(analysis, "annual", term = "m3_fa") |> 
    dplyr::mutate(ratio = "M3:FA")
  ma_fa <- embr::predict(analysis, "annual", term = "ma_fa") |> 
    dplyr::mutate(ratio = "MA:FA")
  
  ratios <- dplyr::bind_rows(
    m0_f0, m1_f1, calf_fa, yearling_fa, m2_fa, m3_fa, ma_fa
  ) |>
    dplyr::mutate(
      ratio = base::factor(
        .data$ratio, 
        levels = c(
          "M0:F0", "M1:F1", "Calf:FA", "Yearling:FA", "M2:FA", "M3:FA", "MA:FA"
        )
      )
    ) |> 
    dplyr::select(
      "annual", "ratio", "estimate", "lower", "upper"
    )
  
  ratios
}