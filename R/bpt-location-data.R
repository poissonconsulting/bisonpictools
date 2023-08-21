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

#' Generate example location data
#'
#' @return tibble of example location data
#' @export
#'
#' @examples
#' bpt_location_data()
bpt_location_data <- function() {
  dplyr::tibble( 
    location_id = c("RLBH006", "RLBH007"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )
}