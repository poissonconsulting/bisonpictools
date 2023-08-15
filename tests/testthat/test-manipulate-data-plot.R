# Unusual inputs
test_that("errors with null input", {
  expect_chk_error(manipulate_data_plot(NULL), "`event_data` must be a data.frame.")  
  expect_chk_error(manipulate_data_plot(event_data(), NULL), "`location_data` must be a data.frame.")  })

test_that("errors with vector inputs", {
  expect_error(manipulate_data_plot(c(1, 2, 3), c(1, 2, 3)))
})

# Expected outputs
x <- manipulate_data_plot(
  event_data = event_data(), 
  location_data = location_data()
)

test_that("returns tibble", {
  expect_true(all(attributes(x)$class == c("tbl_df", "tbl", "data.frame")))
})

test_that("same number of rows as event input data", {
  expect_equal(nrow(x), nrow(event_data()))
})

test_that("location_id column is a factor", {
  expect_true(is.factor(x$location_id))
})

test_that("year column is a factor", {
  expect_true(is.factor(x$year))
})

test_that("all count columns are integers", {
  expect_true(is.integer(x$fa))
  expect_true(is.integer(x$f1))
  expect_true(is.integer(x$f0))
  expect_true(is.integer(x$fu))
  expect_true(is.integer(x$ma))
  expect_true(is.integer(x$m3))
  expect_true(is.integer(x$m1))
  expect_true(is.integer(x$m1))
  expect_true(is.integer(x$m0))
  expect_true(is.integer(x$ua))
  expect_true(is.integer(x$u1))
  expect_true(is.integer(x$u0))
  expect_true(is.integer(x$uu))
  expect_true(is.integer(x$groupsize))
})
