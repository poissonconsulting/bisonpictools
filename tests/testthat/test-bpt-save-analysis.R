analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

dir <- tempdir()

bpt_save_analysis(analysis, file = paste0(dir, "/analysis"))

files <- list.files(dir)

test_that("analysis file was saved to temporary directory", {
  expect_true("analysis.RDS" %in% files)
})

analysis2 <- readRDS(file = paste0(dir, "/analysis.RDS"))

test_that("analysis file read back in is the same as the initial file", {
  expect_identical(analysis, analysis2)
})
