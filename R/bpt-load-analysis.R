#' Load Analysis
#'
#' Loads analysis object from file path where it has been saved
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
