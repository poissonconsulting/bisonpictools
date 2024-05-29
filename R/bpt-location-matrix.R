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

#' Prepare Location Distance Matrix for Analysis
#'
#' @inheritParams params
#'
#' @return A matrix of distances between locations in kilometers.
#' @export
#'
#' @examples
#' bpt_location_matrix(location_data)
bpt_location_matrix <- function(location_data) {
  data <- bpt_check_data(location = location_data)$location

  location_distance <- data |>
    sf::st_as_sf(coords = c("longitude", "latitude"), crs = 4326)

  location_distance <-
    sf::st_distance(location_distance$geometry, location_distance$geometry) |>
    units::set_units("km") |>
    units::drop_units()

  colnames(location_distance) <- c(data$location_id)
  rownames(location_distance) <- c(data$location_id)

  location_distance
}
