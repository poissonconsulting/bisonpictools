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

#' Predict fecundity
#'
#' Predicts the fecundity rate and proportion of reproductive cows.
#'
#' @inheritParams params
#'
#' @return A tibble of predicted fecundity rate and proportion of reproductive
#'   cows, including the median posterior value (estimate) and lower and upper
#'   95% credible intervals.
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
