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

#' Predict total abundance
#'
#' Predicts the total herd abundance for each study year, as the sum of the
#' predicted abundances for each class.
#'
#' @inheritParams params
#'
#' @return A tibble of total abundances for each study year, including the
#'   median posterior value (estimate) and lower and upper 95% credible
#'   intervals.
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
