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

#' Load analysis
#'
#' Loads analysis object from file path where it has been saved.
#'
#' @param file Path to file where analysis object is saved (excluding file
#' extension).
#'
#' @return An smb_analysis object.
#' @export
#'
#' @examples
#' \dontrun{
#' bpt_load_analysis("file_path/analysis")
#' }
bpt_load_analysis <- function(file) {
  analysis <- readRDS(paste0(file, ".RDS"))
  analysis
}
