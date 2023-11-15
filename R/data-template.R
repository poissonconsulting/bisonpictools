#' Raw Template for Bison Location and Event Data
#'
#' A list containing two data frames. Each data frame describes the required
#' format for each data set. This is the raw non human readable version of the
#' template used by the package developers.
#'
#' @details Raw data should be entered according to the template requirements.
#'   To use the template you will need to delete the `name` column and all rows
#'   except row 1 which contains the column names. Once only the column names
#'   are remaining your raw data can be entered into each excel sheet.
#'
#'   The name row provides the names of each column. The example row provides an
#'   example of the column. The description row provides a written description
#'   of the column. The chk row provides details on the constraints placed on
#'   the values of the column, which may include only allowing certain words, a
#'   range of values or certain types. The pkey row indicates which columns make
#'   up the primary key by putting TRUE in the column. The join row indicates if
#'   the table is a child table joined by the column.
#'
#' @format ## `location`
#' A data frame with columns:
#' \describe{
#'   \item{location_id}{Location name for  the camera}
#'   \item{latitude}{Latitude of camera location}
#'   \item{longitude}{Longitude of camera location}
#' }
#'
#' @format ## `event`
#' A data frame with columns:
#' \describe{
#'   \item{location_id}{Location name for  the camera}
#'   \item{start_year}{The year when the event started}
#'   \item{start_month}{The month when the event started}
#'   \item{start_day}{The day when the event started}
#'   \item{start_hour}{The hour the event started}
#'   \item{start_minute}{The minute the event started}
#'   \item{fa}{Count of female adults}
#'   \item{f1}{Count of female yearlings}
#'   \item{f0}{Count of female calves}
#'   \item{fu}{Count of female unkowns}
#'   \item{ma}{Count of male adults}
#'   \item{m3}{Count of male three year olds}
#'   \item{m2}{Count of male two year olds}
#'   \item{m1}{Count of male yearlings}
#'   \item{m0}{Count of male calves}
#'   \item{mu}{Count of male unknowns}
#'   \item{ua}{Count of unknown adults}
#'   \item{u1}{Count of unknown yearlings}
#'   \item{u0}{Count of unknown calves}
#'   \item{uu}{Count of unknown unknowns}
#' }
#' 
#' @format ## `census`
#' A data frame with columns:
#' \describe{
#'   \item{census_year}{The year of the census survey}
#'   \item{census_month}{The month of the census survey}
#'   \item{census_day}{The day of the census survey}
#'   \item{census}{Estimated census count}
#'   \item{census_cv}{Coefficient of variation (standard deviation / estimate) of census estimate}
#' }
#' 
#' @format ## `proportion_calf`
#' A data frame with columns:
#' \describe{
#'   \item{calf_proportion_year}{The year of the calf proportion survey}
#'   \item{calf_proportion_month}{The month of the calf proportion survey}
#'   \item{calf_proportion_day}{The day of the calf proportion survey}
#'   \item{calf_proportion}{Estimated calf proportion}
#'   \item{calf_proportion_cv}{Coefficient of variation (standard deviation / estimate) of calf proportion estimate}
#' }
#' @examples
#' template
"template"
