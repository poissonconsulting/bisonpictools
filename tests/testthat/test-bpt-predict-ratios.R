analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

test_that("output is a tibble", {
  preds <- bpt_predict_ratios(analysis)
  expect_equal(class(preds), c("tbl_df", "tbl", "data.frame"))
})

test_that("no NAs", {
  preds <- bpt_predict_ratios(analysis)
  expect_false(any(is.na(preds)))
})

test_that("prediction has correct number of rows", {
  preds <- bpt_predict_ratios(analysis)
  expect_equal(nrow(preds), 4 * 7)
})

test_that("prediction has correct columns", {
  preds <- bpt_predict_ratios(analysis)
  expect_equal(
    colnames(preds),
    c("annual", "ratio", "estimate", "lower", "upper")
  )
})

test_that("estimates are greater than 0", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(all(preds$estimate > 0))
})

test_that("lower CIs are greater than 0", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(all(preds$lower > 0))
})

test_that("upper CIs are greater than 0", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(all(preds$upper > 0))
})

test_that("lower CIs are less than estimates", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(all(preds$lower < preds$estimate))
})

test_that("upper CIs are greater than estimates", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(all(preds$upper > preds$estimate))
})

test_that("annual is a factor", {
  preds <- bpt_predict_ratios(analysis)
  expect_true(is.factor(preds$annual))
})

test_that("annual has the correct levels", {
  preds <- bpt_predict_ratios(analysis)
  expect_equal(
    levels(preds$annual),
    c("2018-2019", "2019-2020", "2020-2021", "2021-2022")
  )
})

test_that("classes have the correct names", {
  preds <- bpt_predict_ratios(analysis)
  expect_equal(
    levels(preds$ratio),
    c("M0:F0", "M1:F1", "Calf:FA", "Yearling:FA", "M2:FA", "M3:FA", "MA:FA")
  )
})
