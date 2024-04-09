# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Predict Survival
#'
#' Predicts the survival rates for each class for each study
#' year. Bull survival corresponds to the M2, M3, and MA classes
#'
#' @inheritParams params
#'
#' @return A tibble of predicted survival rates for each study year, including
#'   the median posterior value (estimate) and lower and upper 95% credible
#'   intervals.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_predict_survival(analysis)
#' }
bpt_predict_survival <- function(analysis) {
  data <- embr::data_set(analysis)
  seq_annual <- newdata::new_data(data, seq = "annual")

  survival_f0 <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvF0Annual"
  ) |>
    dplyr::mutate(class = "F0")
  survival_m0 <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvM0Annual"
  ) |>
    dplyr::mutate(class = "M0")
  survival_f1 <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvF1Annual"
  ) |>
    dplyr::mutate(class = "F1")
  survival_m1 <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvM1Annual"
  ) |>
    dplyr::mutate(class = "M1")
  survival_fa <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvFAAnnual"
  ) |>
    dplyr::mutate(class = "FA")
  survival_bull <- embr::predict(
    analysis,
    seq_annual,
    term = "PredSurvBullAnnual"
  ) |>
    dplyr::mutate(class = "Bull")

  survival <- dplyr::bind_rows(
    survival_f0,
    survival_m0,
    survival_f1,
    survival_m1,
    survival_fa,
    survival_bull
  ) |>
    dplyr::mutate(
      class = base::factor(
        .data$class,
        levels = c("F0", "M0", "F1", "M1", "FA", "Bull")
      )
    ) |>
    dplyr::select(
      "annual", "class", "estimate", "lower", "upper"
    )

  survival
}
