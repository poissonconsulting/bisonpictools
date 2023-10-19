# Wrong input type
test_that("errors with null input in location_data", {
  expect_chk_error(
    bpt_manipulate_data_analysis(bpt_event_data, NULL),
    "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("errors with null input in event_data", {
  expect_chk_error(
    bpt_manipulate_data_analysis(NULL, bpt_location_data),
    "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})


test_that("errors with vector inputs", {
  expect_chk_error(
    bpt_manipulate_data_analysis(c(1, 2, 3), c(1, 2, 3)),
    "Column names in data must include 'f0', 'f1', 'fa', 'fu', 'location_id', 'm0', 'm1', 'm2', ... and 'uu'."
  )
})

test_that("coerces to integer with character f0 column", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data |>
      dplyr::mutate(f0 = as.numeric(.data$f0)),
    location_data = bpt_location_data
  )
  expect_true(is.integer(x$f0))
})

test_that("non-coercable characters in 'f0' column produces error", {
  expect_chk_error(
    bpt_manipulate_data_analysis(
      event_data = bpt_event_data |>
        dplyr::mutate(f0 = letters[seq_len(nrow(bpt_event_data))]),
      location_data = bpt_location_data
    ),
    "The following values in column 'f0' should be a integer: 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', ... and 'l'."
  )
})

# Expected outputs
x <- bpt_manipulate_data_analysis(
  event_data = bpt_event_data,
  location_data = bpt_location_data
)

test_that("returns tibble", {
  expect_true(all(attributes(x)$class == c("tbl_df", "tbl", "data.frame")))
})

test_that("number output rows less than or equal to number of input rows", {
  expect_true(nrow(x) <= nrow(bpt_event_data))
})

test_that("annual column is a factor", {
  expect_true(is.factor(x$annual))
})

test_that("annual column has correct levels", {
  expect_true(
    all(
      levels(x$annual) ==
        c("2018-2019", "2019-2020", "2020-2021", "2021-2022")
    )
  )
})

test_that("week column is an integer", {
  expect_true(is.integer(x$week))
})

test_that("week_fac column is a factor", {
  expect_true(is.factor(x$weekfac))
})


test_that("week_fac column has correct levels", {
  expect_true(
    all(
      levels(x$weekfac) ==
        c("1", "22", "35", "42", "49", "51", "79", "92", "100", "111", "130", "148")
    )
  )
})

test_that("season column is a factor", {
  expect_true(is.factor(x$season))
})

test_that("season column has correct levels", {
  expect_true(
    all(
      levels(x$season) ==
        c("Summer/Fall", "Winter")
    )
  )
})

test_that("season_annual column is a factor", {
  expect_true(is.factor(x$season_annual))
})

test_that("season_annual column has correct levels", {
  expect_true(
    all(
      levels(x$season_annual) ==
        c(
          "Winter 2018-2019", "Summer/Fall 2019-2020", "Winter 2019-2020",
          "Summer/Fall 2020-2021", "Winter 2020-2021", "Summer/Fall 2021-2022",
          "Winter 2021-2022"
        )
    )
  )
})

test_that("doy column is an integer", {
  expect_true(
    is.integer(x$doy)
  )
})

test_that("doy_fac column is a factor", {
  expect_true(
    is.factor(x$doy_fac)
  )
})

test_that("doy_fac column has correct levels", {
  expect_true(
    all(
      levels(x$doy_fac) ==
        c(
          "12", "122", "146", "158", "212", "246", "261", "269", "302",
          "313", "327", "336"
        )
    )
  )
})

test_that("location column is a factor", {
  expect_true(is.factor(x$location))
})

test_that("location column has correct levels", {
  expect_true(
    all(
      levels(x$location) ==
        c("LOCID1", "LOCID2", "LOCID3", "LOCID4")
    )
  )
})

test_that("location_weekfac column is a factor", {
  expect_true(is.factor(x$location))
})

test_that("location_weekfac column has correct levels", {
  expect_true(
    all(
      levels(x$location_weekfac) ==
        c(
          "LOCID1 130", "LOCID1 22", "LOCID1 79", "LOCID2 35", "LOCID2 92",
          "LOCID3 100", "LOCID3 42", "LOCID3 51", "LOCID4 1", "LOCID4 148",
          "LOCID4 49"
        )
    )
  )
})

test_that("id column is a factor", {
  expect_true(is.factor(x$id))
})

test_that("id column has expected levels", {
  expect_true(
    all(
      levels(x$id) ==
        c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11")
    )
  )
})

test_that("id column has same number of levels as output has rows", {
  expect_true(all(levels(x$id) == seq_len(nrow(x))))
})

test_that("count columns are integers", {
  expect_true(is.integer(x$fa))
  expect_true(is.integer(x$f1))
  expect_true(is.integer(x$f0))
  expect_true(is.integer(x$ma))
  expect_true(is.integer(x$m3))
  expect_true(is.integer(x$m2))
  expect_true(is.integer(x$m1))
  expect_true(is.integer(x$m0))
  expect_true(is.integer(x$ua))
  expect_true(is.integer(x$u1))
  expect_true(is.integer(x$u0))
  expect_true(is.integer(x$groupsize_total))
  expect_true(is.integer(x$calf))
  expect_true(is.integer(x$yearling))
  expect_true(is.integer(x$adult))
})

test_that("count columns are positive", {
  expect_true(all(x$fa >= 0))
  expect_true(all(x$f1 >= 0))
  expect_true(all(x$f0 >= 0))
  expect_true(all(x$ma >= 0))
  expect_true(all(x$m3 >= 0))
  expect_true(all(x$m2 >= 0))
  expect_true(all(x$m1 >= 0))
  expect_true(all(x$m0 >= 0))
  expect_true(all(x$ua >= 0))
  expect_true(all(x$u1 >= 0))
  expect_true(all(x$u0 >= 0))
  expect_true(all(x$groupsize_total >= 0))
  expect_true(all(x$calf >= 0))
  expect_true(all(x$yearling >= 0))
  expect_true(all(x$adult >= 0))
})
