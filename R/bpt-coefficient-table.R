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
