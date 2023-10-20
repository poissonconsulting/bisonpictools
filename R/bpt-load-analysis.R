#' Load Analysis
#'
#' Loads analysis object from file path where it has been saved
#'
#' @param file path to file (excluding extension)
#'
#' @return the analysis object
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
