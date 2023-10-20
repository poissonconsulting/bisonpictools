#' Save analysis object
#'
#' Saves analysis object to the file location specified by `file`.
#'
#' @param analysis analysis object from `bpt_analyse()`
#' @param file name of the file where the analysis object is saved to
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
