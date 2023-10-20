analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

preds <- bpt_predict_abundance_class(analysis)

test_that("output is a tibble", {
  expect_equal(class(preds), c("tbl_df", "tbl", "data.frame"))
})

test_that("no NAs", {
  expect_false(any(is.na(preds)))
})

test_that("prediction has nannual * nclass rows", {
  expect_equal(nrow(preds), 4 * 8)
})

test_that("prediction has correct columns", {
  expect_equal(
    colnames(preds),
    c("annual", "class", "estimate", "lower", "upper")
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

test_that("annual is a factor", {
  expect_true(is.factor(preds$annual))
})

test_that("annual has the correct levels", {
  expect_equal(
    levels(preds$annual),
    c("2018-2019", "2019-2020", "2020-2021", "2021-2022")
  )
})

test_that("classes have the correct names", {
  expect_equal(
    sort(unique(preds$class)),
    c("F0", "F1", "FA", "M0", "M1", "M2", "M3", "MA")
  )
})
