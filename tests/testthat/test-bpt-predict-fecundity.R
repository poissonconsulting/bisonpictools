analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.rds")
)

preds <- bpt_predict_fecundity(analysis)

test_that("output is a tibble", {
  expect_equal(class(preds), c("tbl_df", "tbl", "data.frame"))
})

test_that("no NAs", {
  expect_false(any(is.na(preds)))
})

test_that("prediction has correct number of rows", {
  expect_equal(nrow(preds), 2)
})

test_that("prediction has correct columns", {
  expect_equal(
    colnames(preds), 
    c("rate", "estimate", "lower", "upper")
  )
})

test_that("estimates are greater than 0", {
  expect_true(all(preds$estimate > 0))
})

test_that("lower CIs are greater than 0", {
  expect_true(all(preds$lower > 0))
})

test_that("upper CIs are greater than 0", {
  expect_true(all(preds$upper > 0))
})

test_that("lower CIs are less than estimates", {
  expect_true(all(preds$lower < preds$estimate))
})

test_that("upper CIs are greater than estimates", {
  expect_true(all(preds$upper > preds$estimate))
})

test_that("terms have the correct names", {
  expect_equal(
    unique(preds$rate),
    c("Fecundity", "Proportion of Reproductive Cows")
  )
})
