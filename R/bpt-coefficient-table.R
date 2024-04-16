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

#' Extract Coefficient Table
#' Extracts the coefficient table from the analysis object.
#'
#' @inheritParams params
#'
#' @return A tibble of coefficients with the following columns:
#'  - `term` the name of the term,
#'  - `estimate` the median posterior estimate,
#'  - `lower` the lower 95% credible interval,
#'  - `upper` the upper 95% credible interval,
#'  - `svalue` a measure of directionality with respect to zero,
#'    - an s-value of 4.32 bits is equivalent to a p-value of 0.05.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_coefficient_table(analysis)
#' }
bpt_coefficient_table <- function(analysis) {
  coef <- coef(analysis, simplify = TRUE)
  coef
}
