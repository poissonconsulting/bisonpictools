# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Unusual inputs
test_that("errors with null input", {
  expect_chk_error(
    bpt_location_matrix(NULL),
    regexp =
      "The names of the data supplied in the `...` argument do not match the
      template names."
  )
})

test_that("errors with vector inputs", {
  expect_chk_error(
    bpt_location_matrix(c(1, 2, 3)),
    regexp = paste0(
      "Column names in data must include 'latitude', 'location_id' and ",
      "'longitude'."
    )
  )
})

test_that("errors with character latitude column", {
  expect_chk_error(
    bpt_location_matrix(
      location_data = location_data |>
        dplyr::mutate(latitude = letters[seq_len(nrow(location_data))])
    ),
    regexp = paste0(
      "The following values in column 'latitude' should be a number: ",
      "'a', 'b', 'c' and 'd'."
    )
  )
})

test_that("errors with character longitude column", {
  expect_chk_error(
    bpt_location_matrix(
      location_data = location_data |>
        dplyr::mutate(longitude = letters[seq_len(nrow(location_data))])
    ),
    regexp = paste0(
      "The following values in column 'longitude' should be a number: ",
      "'a', 'b', 'c' and 'd'."
    )
  )
})

# Outputs
test_that("returns a matrix", {
  x <- bpt_location_matrix(location_data)
  expect_equal(class(x), c("matrix", "array"))
})

test_that("all values in matrix greater than or equal to 0", {
  x <- bpt_location_matrix(location_data)
  expect_true(all(x >= 0))
})

test_that("rownames match the order of locations in location_data provided", {
  x <- bpt_location_matrix(location_data)
  expect_true(all(rownames(x) == location_data$location_id))
})

test_that("colnames match the order of locations in location_data provided", {
  x <- bpt_location_matrix(location_data)
  expect_true(all(colnames(x) == location_data$location_id))
})

test_that("matrix is symmetric", {
  x <- bpt_location_matrix(location_data)
  expect_true(isSymmetric(x))
})

test_that("diagonal of matrix is all 0's", {
  x <- bpt_location_matrix(location_data)
  expect_true(all(diag(x) == 0))
})

test_that("matrix dimensions match the number of rows in location data", {
  x <- bpt_location_matrix(location_data)
  expect_true(
    all(dim(x) == c(nrow(location_data), nrow(location_data)))
  )
})
