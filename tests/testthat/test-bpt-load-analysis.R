path <- system.file(package = "bisonpictools", "test-objects/analysis.RDS")
# Remove file extension from path (to be added in by bpt_load_analysis)
path_no_ext <- strsplit(path, "\\.")[[1]][1]

analysis <- bpt_load_analysis(
  file = path_no_ext
)

analysis2 <- readRDS(path)

test_that("analysis object is an smb.analysis object", {
  expect_identical(class(analysis), c("smb_analysis", "mb_analysis"))
})

test_that("analysis object loaded is identical to that loaded by readRDS", {
  expect_identical(analysis, analysis2)
})
