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

#' Generate Seasons Data
#' 
#' Generates a table of the dates of different seasons relevant to Ronald Wood Bison movement patterns: calving, summer/fall, and winter. Start and end dates of each season are based in the year 1972.
#'
#' @return A tibble
#' @export
#'
#' @examples
#' seasons()
seasons <- function() {
  dplyr::tribble(
          ~season,           ~start_dayte,            ~end_dayte,
        "Calving",  "1972-04-01 00:00:00", "1972-06-30 00:00:00",
    "Summer/Fall",  "1972-07-01 00:00:00", "1972-11-30 00:00:00",
         "Winter",  "1972-12-01 00:00:00", "1972-12-31 00:00:00",
         "Winter",  "1972-01-01 00:00:00", "1972-03-31 00:00:00",
  ) |> 
  dplyr::mutate(
    dplyr::across( 
      c("start_dayte", "end_dayte"),
      \(x) dttr2::dtt_date_time(x) |> 
        dttr2::dtt_dayte_time()
    )
  )
}