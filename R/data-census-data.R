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

#' Sample Data for census counts
#'
#' A data set of invented census data
#'
#' @format
#' A tibble with 2 rows and 5 columns:
#' \describe{
#'   \item{census_year}{The year of the census survey}
#'   \item{census_month}{The month of the census survey}
#'   \item{census_day}{The day of the census survey}
#'   \item{census}{Estimated census count}
#'   \item{census_cv}{Coefficient of variation (standard deviation / estimate)
#'   of census estimate}
#' }
#'
"census_data"
