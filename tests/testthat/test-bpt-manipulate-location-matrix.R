# Unusual inputs
test_that("errors with null input", {
  expect_chk_error(
    bpt_location_matrix(NULL), 
    "The names of the data supplied in the `...` argument do not match the
      template names."
  )
})

test_that("errors with vector inputs", {
  expect_chk_error(
    bpt_location_matrix(c(1, 2, 3)), 
    "Column names in data must include 'latitude', 'location_id' and 'longitude'."
  )
})

test_that("errors with character latitude column", {
  expect_chk_error(
    bpt_location_matrix(
      location_data = bpt_location_data |> 
        dplyr::mutate(latitude = letters[seq_len(nrow(bpt_location_data))])
    ),
    "The following values in column 'latitude' should be a number: 'a', 'b', 'c' and 'd'."
  )
})

test_that("errors with character longitude column", {
  expect_chk_error(
    bpt_location_matrix(
      location_data = bpt_location_data |> 
        dplyr::mutate(longitude = letters[seq_len(nrow(bpt_location_data))])
    ),
    "The following values in column 'longitude' should be a number: 'a', 'b', 'c' and 'd'."
  )
})

# Outputs
x <- bpt_location_matrix(bpt_location_data)

test_that("returns a matrix", {
  expect_equal(class(x), c("matrix", "array"))
})

test_that("all values in matrix greater than or equal to 0", {
  expect_true(all(x >= 0))
})

test_that("rownames match the order of locations in location_data provided", {
  expect_true(all(rownames(x) == bpt_location_data$location_id))
})

test_that("colnames match the order of locations in location_data provided", {
  expect_true(all(colnames(x) == bpt_location_data$location_id))
})

test_that("matrix is symmetric", {
  expect_true(isSymmetric(x))
})

test_that("diagonal of matrix is all 0's", {
  expect_true(all(diag(x) == 0))
})

test_that("matrix dimensions match the number of rows in location data", {
  expect_true(all(dim(x) == c(nrow(bpt_location_data), nrow(bpt_location_data))))
})
