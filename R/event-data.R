#Copyright 2023 Province of Alberta

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

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
    start_year	= rep(2021L, 2L),
    start_month	= c(4L, 7L),
    start_day	= c(12L, 14L),
    start_hour = c(13L, 14L),
    start_minute = c(50L, 52L),
    fa	= c(1L, 2L),
    f1	= c(1L, 2L),
    f0	= c(2L, 1L),
    fu	= c(0L, 2L),
    ma	= c(1L, 0L),
    m3	= c(0L, 1L),
    m2	= c(0L, 1L),
    m1	= c(1L, 0L),
    m0	= c(1L, 2L),
    mu	= c(0L, 0L),
    ua	= c(0L, 1L),
    u1	= c(1L, 2L),
    u0	= c(1L, 3L),
    uu	= c(1L, 1L)
  )
}