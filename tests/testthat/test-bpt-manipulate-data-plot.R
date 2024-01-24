# Unusual inputs
test_that("errors with null input", {
  expect_error(
    bpt_manipulate_data_plot(NULL),
    "argument \"location_data\" is missing, with no default"
  )
  expect_error(
    bpt_manipulate_data_plot(bpt_event_data, NULL),
    regexp = paste0(
      "The pkey values in the parent table must match the columns listed ",
      "in the child table in the join row"
    )
  )
})

test_that("errors with vector inputs", {
  expect_chk_error(
    bpt_manipulate_data_plot(c(1, 2, 3), c(1, 2, 3)),
    regexp = paste0(
      "Column names in data must include 'f0', 'f1', 'fa', 'fu', ",
      "'location_id', 'm0', 'm1', 'm2', ... and 'uu'."
    )
  )
})

# Wrong input type
# event_data ----
test_that("errors with numeric location_id column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data |>
        dplyr::mutate(location_id = seq_len(nrow(bpt_event_data))),
      location_data = bpt_location_data
    ),
    regexp = paste0(
      "All 'location_id' values in the event table must be in the location ",
      "table. The following rows\\(s\\) in the event table are causing the ",
      "issue: 1, 2, 3, 4, 5, 6, 7."
    )
  )
})

test_that("coerces to integer with character f0 column", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data |>
      dplyr::mutate(f0 = as.numeric(.data$f0)),
    location_data = bpt_location_data
  )
  expect_true(is.integer(x$f0))
})

test_that("letters in 'f0' column produces error", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data |>
        dplyr::mutate(f0 = letters[seq_len(nrow(bpt_event_data))]),
      location_data = bpt_location_data
    ),
    regexp = paste0(
      "The following values in column 'f0' should be a integer: 'a', 'b', ",
      "'c', 'd', 'e', 'f', 'g', 'h', ... and 'l'."
    )
  )
})

# location_data ----
test_that("errors with numeric location_id column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data,
      location_data = bpt_location_data |>
        dplyr::mutate(location_id = seq_len(nrow(bpt_location_data)))
    ),
    regexp = paste0(
      "All 'location_id' values in the event table must be in the location ",
      "table. The following rows\\(s\\) in the event table are causing the ",
      "issue: 1, 2, 3, 4, 5, 6, 7."
    )
  )
})

test_that("errors with character latitude column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data,
      location_data = bpt_location_data |>
        dplyr::mutate(latitude = letters[seq_len(nrow(bpt_location_data))])
    ),
    regexp = paste0(
      "The following values in column 'latitude' should be a number: ",
      "'a', 'b', 'c' and 'd'."
    )
  )
})

test_that("errors with character longitude column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data,
      location_data = bpt_location_data |>
        dplyr::mutate(longitude = letters[seq_len(nrow(bpt_location_data))])
    ),
    regexp = paste0(
      "The following values in column 'longitude' should be a number: ",
      "'a', 'b', 'c' and 'd'."
    )
  )
})

# Join error
test_that(
  paste0(
    "errors if `event_data` has location_id's that are not present in ",
    "`location_data`"
  ),
  {
    expect_chk_error(
      bpt_manipulate_data_plot(
        event_data = bpt_event_data |>
          dplyr::mutate(
            location_id = c(
              rep("LOCID10", nrow(bpt_event_data))
            )
          ),
        location_data = bpt_location_data
      ),
      regexp = paste0(
        "All 'location_id' values in the event table must be in the location ",
        "table. The following rows\\(s\\) in the event table are causing the ",
        "issue: 1, 2, 3, 4, 5, 6, 7, 8, ..., 12."
      )
    )

    expect_chk_error(
      bpt_manipulate_data_plot(
        event_data = bpt_event_data |>
          dplyr::mutate(
            location_id = dplyr::if_else(
              location_id == "LOCID1",
              "LOCID10",
              location_id
            )
          ),
        location_data = bpt_location_data
      ),
      regexp = paste0(
        "All 'location_id' values in the event table must be in the location ",
        "table. The following rows\\(s\\) in the event table are causing the ",
        "issue: 1, 2, 3."
      )
    )
  }
)

# Expected outputs
test_that("returns tibble", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_true(attributes(x)$class[1] == "tbl_df")
  expect_true(attributes(x)$class[2] == "tbl")
  expect_true(attributes(x)$class[3] == "data.frame")
})

test_that("same number of rows as event input data", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_equal(nrow(x), nrow(bpt_event_data))
})

test_that("location_id column is a factor", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_true(is.factor(x$location_id))
})

test_that("year column is a factor", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_true(is.factor(x$year))
})

test_that("all count columns are integers", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_true(is.integer(x$fa))
  expect_true(is.integer(x$f1))
  expect_true(is.integer(x$f0))
  expect_true(is.integer(x$fu))
  expect_true(is.integer(x$ma))
  expect_true(is.integer(x$m3))
  expect_true(is.integer(x$m2))
  expect_true(is.integer(x$m1))
  expect_true(is.integer(x$m0))
  expect_true(is.integer(x$mu))
  expect_true(is.integer(x$ua))
  expect_true(is.integer(x$u1))
  expect_true(is.integer(x$u0))
  expect_true(is.integer(x$uu))
  expect_true(is.integer(x$groupsize))
})

test_that("all count columns are positive", {
  x <- bpt_manipulate_data_plot(
    event_data = bpt_event_data,
    location_data = bpt_location_data
  )

  expect_true(all(x$fa >= 0))
  expect_true(all(x$f1 >= 0))
  expect_true(all(x$f0 >= 0))
  expect_true(all(x$fu >= 0))
  expect_true(all(x$ma >= 0))
  expect_true(all(x$m3 >= 0))
  expect_true(all(x$m2 >= 0))
  expect_true(all(x$m1 >= 0))
  expect_true(all(x$m0 >= 0))
  expect_true(all(x$mu >= 0))
  expect_true(all(x$ua >= 0))
  expect_true(all(x$u1 >= 0))
  expect_true(all(x$u0 >= 0))
  expect_true(all(x$uu >= 0))
  expect_true(all(x$groupsize >= 0))
})
