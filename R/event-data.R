#' Generate example event data
#'
#' @return tibble of example event data
#' @export
#'
#' @examples
#' event_data()
event_data <- function() {
  dplyr::tibble(
    location_id	= c("RLBH006", "RLBH007"),
    start_year	= rep(2021, 2),
    start_month	= c(04, 07),
    start_day	= c(12, 14),
    start_hour = c(13, 14),
    start_minute = c(50, 52),
    fa	= c(1, 2),
    f1	= c(1, 2),
    f0	= c(2, 1),
    fu	= c(0, 2),
    ma	= c(1, 0),
    m3	= c(0, 1),
    m2	= c(0, 1),
    m1	= c(1, 0),
    m0	= c(1, 2),
    mu	= c(0, 0),
    ua	= c(0, 1),
    u1	= c(1, 2),
    u0	= c(1, 3),
    uu	= c(1, 1)
  )
}