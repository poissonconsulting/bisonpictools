# Copyright 2023 Province of Alberta

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Names of common ratios
#'
#' @param numerator a character vector of sex-age codes to go in the numerator 
#' of the ratio
#' @param denominator a character vector of sex-age codes to go in the 
#' denominator of the ratio
#'
#' @return character vector of common ratio name or "Ratio"
#' @export
#'
#' @examples
#' # Common ratio
#' bpt_ratio_names(c("f0", "u0", "m0"), "fa")
#' # Uncommon ratio
#' bpt_ratio_names("u0", "fa")
bpt_ratio_names <- function(numerator, denominator) {
  chk::chk_character(numerator)
  chk::chk_character(denominator)

  names <- dplyr::tribble(
    ~numerator, ~denominator, ~name,
    "fa", "ma", "adult cow:(bull + cow)",
    "ma", "fa", "adult bull:(cow + bull)",
    "fa", c("m2", "m3", "ma"), "mature cow:(bull + cow)",
    c("m2", "m3", "ma"), "fa", "mature bull:(cow + bull)",
    "f1", "m1", "yearling female:(male + female)",
    "m1", "f1", "yearling male:(female + male)",
    "f0", "m0", "calf female:(male + female)",
    "m0", "f0", "calf male:(female + male)",
    c("f0", "f1", "fa", "fu"), c("m0", "m1", "m2", "m3", "ma", "mu"), "female:(male + female)",
    c("f0", "f1", "fa"), c("m0", "m1", "m2", "m3", "ma"), "female:(male + female)",
    c("m0", "m1", "m2", "m3", "ma", "mu"), c("f0", "f1", "fa", "fu"), "male:(female + male)",
    c("m0", "m1", "m2", "m3", "ma"), c("f0", "f1", "fa"), "male:(female + male)",
    c("f0", "m0", "u0"), "fa", "calf:(cow + calf)",
    c("f0", "m0", "u0"), "ma", "calf:(bull + calf)",
  )

  match <- sapply(names$numerator, \(x) identical(sort(numerator), x)) &
    sapply(names$denominator, \(x) identical(sort(denominator), x))

  if (any(match)) {
    return(names$name[match])
  }

  "Ratio"
}
