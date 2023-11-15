#' Save analysis object
#'
#' Saves analysis object to the file location specified by `file`.
#'
#' @param analysis analysis object from `bpt_analyse()`
#' @param file file path to save analysis object to (file extension added
#' automatically)
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
