#' Generate example location data
#'
#' @return tibble of example location data
#' @export
#'
#' @examples
#' location_data()
location_data <- function() {
  dplyr::tibble( 
    location_id = c("RLBH006", "RLBH007"),
    latitude = c(57.555, 56.444),
    longitude = c(-111.757, -111.444)
  )
}