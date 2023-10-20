analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

coef_table <- bpt_coefficient_table(analysis)

test_that("returns a tibble", {
  expect_s3_class(coef_table, c("tbl_df", "tbl", "data.frame"))
})

test_that("coefficient table has correct column names", {
  expect_identical(
    names(coef_table),
    c("term", "estimate", "lower", "upper", "svalue")
  )
})

test_that("there are no NAs in coefficient table", {
  expect_false(any(is.na(coef_table)))
})

test_that("lower CI is less that estimate", {
  expect_true(all(coef_table$lower <= coef_table$estimate))
})

test_that("upper CI is greater than estimate", {
  expect_true(all(coef_table$upper >= coef_table$estimate))
})
