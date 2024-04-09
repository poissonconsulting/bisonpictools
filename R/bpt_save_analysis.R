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

#' Save analysis object
#'
#' Saves analysis object to the file location specified by `file`.
#'
#' @inheritParams params
#'
#' @param file File path to save analysis object to (file extension added
#' automatically).
#'
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_save_analysis(analysis, "output/analysis")
#' }
bpt_save_analysis <- function(analysis, file) {
  base::saveRDS(object = analysis, file = base::paste0(file, ".RDS"))
}
