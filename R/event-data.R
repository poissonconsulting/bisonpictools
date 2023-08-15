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
    location_id	= c(rep("RLBH006", 3), rep("RLBH007", 4)),
    start_year = c(2021L, 2022L, 2021L, 2022L, 2021L, 2022L, 2023L),
    start_month	= c(4L, 7L, 8L, 9L, 10L, 12L, 3L),
    start_day	= c(12L, 14L, 30L, 1L, 31L, 24L, 9L),
    start_hour = c(13L, 14L, 11L, 12L, 6L, 8L, 19L),
    start_minute = c(50L, 52L, 3L, 2L, 10L, 1L, 7L),
    fa	= c(1L, 2L, 1L, 4L, 8L, 3L, 4L),
    f1	= c(1L, 2L, 0L, 1L, 2L, 0L, 1L),
    f0	= c(2L, 1L, 0L, 0L, 2L, 1L, 1L),
    fu	= c(0L, 2L, 0L, 1L, 0L, 0L, 0L),
    ma	= c(1L, 0L, 0L, 1L, 1L, 0L, 0L),
    m3	= c(0L, 1L, 0L, 0L, 1L, 0L, 0L),
    m2	= c(0L, 1L, 0L, 0L, 1L, 0L, 1L),
    m1	= c(1L, 0L, 1L, 1L, 2L, 0L, 0L),
    m0	= c(1L, 2L, 1L, 1L, 2L, 1L, 1L),
    mu	= c(0L, 0L, 0L, 0L, 1L, 1L, 1L),
    ua	= c(0L, 1L, 1L, 0L, 0L, 0L, 0L),
    u1	= c(1L, 2L, 0L, 0L, 1L, 0L, 0L),
    u0	= c(1L, 3L, 0L, 0L, 0L, 1L, 0L),
    uu	= c(1L, 1L, 0L, 0L, 0L, 0L, 1L)
  )
}