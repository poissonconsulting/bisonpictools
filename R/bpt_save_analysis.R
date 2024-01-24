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
