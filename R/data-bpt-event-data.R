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

#' Sample Data for Camera Trap Events
#'
#' A data set of invented camera trap event data
#'
#' @format
#' A tibble with 12 rows and 20 columns:
#' \describe{
#'   \item{location_id}{The ID code for the location of the camera trap}
#'   \item{start_year}{Year of start time of event}
#'   \item{start_month}{Month of start time of event}
#'   \item{start_day}{Day of start time of event}
#'   \item{start_hour}{Hour of start time of event}
#'   \item{start_minute}{Minute of start time of event}
#'   \item{fa}{Number of female adults}
#'   \item{f1}{Number of female yearlings}
#'   \item{f0}{Number of female calves}
#'   \item{fu}{Number of females of unknown age}
#'   \item{ma}{Number of male adults}
#'   \item{m3}{Number of male 3-year-olds}
#'   \item{m2}{Number of male 2-year-olds}
#'   \item{m1}{Number of male 1-year-olds}
#'   \item{m0}{Number of male calves}
#'   \item{mu}{Number of males of unknown age}
#'   \item{ua}{Number of adults of unknown sex}
#'   \item{u1}{Number of yearlings of unknown sex}
#'   \item{u0}{Number of calves of unknown sex}
#'   \item{uu}{Number of individuals of unknown age and unknown sex}
#' }
#'
"bpt_event_data"
