#' Names of common ratios
#'
#' @param numerator a character vector of sex-age codes to go in the numerator of the ratio
#' @param denominator a character vector of sex-age codes to go in the denominator of the ratio
#'
#' @return character vector of common ratio name or "Ratio"
#' @export 
#' 
#' @examples
#' # Common ratio
#' ratio_names(c("f0", "u0", "m0"), "fa")
#' # Uncommon ratio
#' ratio_names("u0", "fa")
ratio_names <- function(numerator, denominator) {
  chk::chk_character(numerator)
  chk::chk_character(denominator)
  
  names <- dplyr::tribble(
    ~numerator, ~denominator, ~name,
    "fa", "ma", "cow:(bull + cow)",
    "ma", "fa", "bull:(cow + bull)",
    "f1", "m1", "yearling female:(male + female)",
    "m1", "f1", "yearling male:(female + male)",
    "f0", "m0", "calf female:(male + female)",
    "m0", "f0", "calf male:(female + male)",
    c("f0", "f1", "fa"), c("m0", "m1", "m2", "m3", "ma"), "female:(male + female)",
    c("m0", "m1", "m2", "m3", "ma"), c("f0", "f1", "fa"), "male:(female + male)",
    c("f0", "m0", "u0"), "fa", "calf:(cow + calf)",
    c("f0", "m0", "u0"), "ma", "calf:(bull + calf)",
  )
  
  match <- sapply(names$numerator, \(x) identical(sort(numerator), x)) &
    sapply(names$denominator, \(x) identical(sort(denominator), x))
  
  if (any(match)) return(names$name[match])
  
  "Ratio"
}