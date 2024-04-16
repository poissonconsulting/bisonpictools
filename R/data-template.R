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

#' Raw Template for Bison Location and Event Data
#'
#' A list containing four data frames. Each data frame describes the required
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
#'   For more details see the package vignette.
#'
#' @format ##
#' A list of the following four data frames:
#'
#' @format ### 1. `location`
#' A data frame with columns:
#' \describe{
#'   \item{location_id}{Location name for  the camera}
#'   \item{latitude}{Latitude of camera location}
#'   \item{longitude}{Longitude of camera location}
#' }
#'
#' @format ### 2. `event`
#' A data frame with columns:
#' \describe{
#'   \item{location_id}{Location name for  the camera}
#'   \item{start_year, start_month, start_day, start_hour, start_minute}{Date
#'   and time when the event started}
#'   \item{fa, f1, f0, fu}{Count of female adults, yearlings, calves, and
#'   unknown ages}
#'   \item{ma, m3, m2, m1, m0, mu}{Count of male adults, 3-year-olds,
#'   2-year-olds, yearlings, calves, and unknown ages}
#'   \item{ua, u1, u0, uu}{Count of unknown sex adults, yearlings, calves, and
#'   unknown ages}
#' }
#'
#' @format ### 3. `census`
#' A data frame with columns:
#' \describe{
#'   \item{census_year, census_month, census_day}{Date of the census}
#'   \item{census}{Estimated census count}
#'   \item{census_cv}{Coefficient of variation (standard deviation / estimate)
#'   of census estimate}
#' }
#'
#' @format ### 4. `proportion_calf`
#' A data frame with columns:
#' \describe{
#'   \item{calf_proportion_year, calf_proportion_month, calf_proportion_day}{
#'   Date of the calf proportion survey}
#'   \item{calf_proportion}{Estimated calf proportion}
#'   \item{calf_proportion_cv}{Coefficient of variation (standard deviation /
#'   estimate) of calf proportion estimate}
#' }
#' @examples
#' template
"template"
