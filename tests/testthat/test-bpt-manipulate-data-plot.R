# Unusual inputs
test_that("errors with null input", {
  expect_chk_error(bpt_manipulate_data_plot(NULL), "`event_data` must be a data.frame.")  
  expect_chk_error(bpt_manipulate_data_plot(bpt_event_data(), NULL), "`location_data` must be a data.frame.")  })

test_that("errors with vector inputs", {
  expect_error(bpt_manipulate_data_plot(c(1, 2, 3), c(1, 2, 3)))
})

# Expected outputs
x <- bpt_manipulate_data_plot(
  event_data = bpt_event_data(), 
  location_data = bpt_location_data()
)

test_that("returns tibble", {
  expect_true(all(attributes(x)$class == c("tbl_df", "tbl", "data.frame")))
})

test_that("same number of rows as event input data", {
  expect_equal(nrow(x), nrow(bpt_event_data()))
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

test_that("all count columns are positive", {
  expect_true(all(x$fa >= 0))
  expect_true(all(x$f1 >= 0))
  expect_true(all(x$f0 >= 0))
  expect_true(all(x$fu >= 0))
  expect_true(all(x$ma >= 0))
  expect_true(all(x$m3 >= 0))
  expect_true(all(x$m1 >= 0))
  expect_true(all(x$m1 >= 0))
  expect_true(all(x$m0 >= 0))
  expect_true(all(x$ua >= 0))
  expect_true(all(x$u1 >= 0))
  expect_true(all(x$u0 >= 0))
  expect_true(all(x$uu >= 0))
  expect_true(all(x$groupsize >= 0))
})
