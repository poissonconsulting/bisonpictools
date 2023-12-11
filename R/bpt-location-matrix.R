#' Prepare Location Distance Matrix for Analysis
#'
#' @inheritParams params
#'
#' @return a matrix of distances between locations in kilometers
#' @export
#'
#' @examples
#' bpt_location_matrix(bpt_location_data)
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
