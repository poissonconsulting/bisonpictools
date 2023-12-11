# Wrong input type
test_that("errors with null input in location_data", {
  expect_chk_error(
    bpt_manipulate_data_analysis(bpt_event_data, NULL, NULL, NULL),
    "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("errors with null input in event_data", {
  expect_chk_error(
    bpt_manipulate_data_analysis(NULL, bpt_location_data, NULL, NULL),
    "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument."
  )
})

test_that("errors with vector inputs", {
  expect_chk_error(
    bpt_manipulate_data_analysis(c(1, 2, 3), c(1, 2, 3), c(1, 2, 3), c(1, 2, 3)),
    "Column names in data must include 'f0', 'f1', 'fa', 'fu', 'location_id', 'm0', 'm1', 'm2', ... and 'uu'."
  )
})

test_that("coerces to integer with character f0 column", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data |>
      dplyr::mutate(f0 = as.numeric(.data$f0)),
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.integer(x$data$f0))
})

test_that("non-coercable characters in 'f0' column produces error", {
  expect_chk_error(
    bpt_manipulate_data_analysis(
      event_data = bpt_event_data |>
        dplyr::mutate(f0 = letters[seq_len(nrow(bpt_event_data))]),
      location_data = bpt_location_data,
      census_data = bpt_census_data,
      proportion_calf_data = bpt_proportion_calf_data
    ),
    "The following values in column 'f0' should be a integer: 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', ... and 'l'."
  )
})

test_that("errors if census date is outside of range of study years in event_data", {
  expect_chk_error(
    bpt_manipulate_data_analysis(
      bpt_event_data,
      bpt_location_data,
      bpt_census_data |>
        dplyr::mutate(census_year = c(2030, 2031)),
      bpt_proportion_calf_data
    ),
    "Census data must include only dates that are within the study years of the event data."
  )
})

# Expected outputs
test_that("returns list", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.list(x))
})

test_that("list elements have correct names", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_equal(names(x)[1], "data")
  expect_equal(names(x)[2], "census_data")
  expect_equal(names(x)[3], "prop_calf_data")
})

test_that("list elements are data frames", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.data.frame(x$data))
  expect_true(is.data.frame(x$census_data))
  expect_true(is.data.frame(x$prop_calf_data))
})

# Analysis data (x$data)
test_that("number output rows less than or equal to number of input rows", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(nrow(x$data) <= nrow(bpt_event_data))
})

test_that("annual column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$annual))
})

test_that("annual column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$annual) ==
        c("2018-2019", "2019-2020", "2020-2021", "2021-2022")
    )
  )
})

test_that("week column is an integer", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.integer(x$data$week))
})

test_that("week_fac column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$weekfac))
})


test_that("week_fac column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$weekfac) ==
        c("1", "22", "35", "42", "49", "51", "79", "92", "100", "111", "130", "148")
    )
  )
})

test_that("season column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$season))
})

test_that("season column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$season) ==
        c("Summer/Fall", "Winter")
    )
  )
})

test_that("season_annual column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$season_annual))
})

test_that("season_annual column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$season_annual) ==
        c(
          "Winter 2018-2019", "Summer/Fall 2019-2020", "Winter 2019-2020",
          "Summer/Fall 2020-2021", "Winter 2020-2021", "Summer/Fall 2021-2022",
          "Winter 2021-2022"
        )
    )
  )
})

test_that("doy column is an integer", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    is.integer(x$data$doy)
  )
})

test_that("doy_fac column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    is.factor(x$data$doy_fac)
  )
})

test_that("doy_fac column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$doy_fac) ==
        c(
          "12", "122", "146", "158", "212", "246", "261", "269", "302",
          "313", "327", "336"
        )
    )
  )
})

test_that("location column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$location))
})

test_that("location column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$location) ==
        c("LOCID1", "LOCID2", "LOCID3", "LOCID4")
    )
  )
})

test_that("location_weekfac column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$location))
})

test_that("location_weekfac column has correct levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$location_weekfac) ==
        c(
          "LOCID1 130", "LOCID1 22", "LOCID1 79", "LOCID2 35", "LOCID2 92",
          "LOCID3 100", "LOCID3 42", "LOCID3 51", "LOCID4 1", "LOCID4 148",
          "LOCID4 49"
        )
    )
  )
})

test_that("id column is a factor", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.factor(x$data$id))
})

test_that("id column has expected levels", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(
    all(
      levels(x$data$id) ==
        c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11")
    )
  )
})

test_that("id column has same number of levels as output has rows", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(levels(x$data$id) == seq_len(nrow(x$data))))
})

test_that("count columns are integers", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(is.integer(x$data$fa))
  expect_true(is.integer(x$data$f1))
  expect_true(is.integer(x$data$f0))
  expect_true(is.integer(x$data$ma))
  expect_true(is.integer(x$data$m3))
  expect_true(is.integer(x$data$m2))
  expect_true(is.integer(x$data$m1))
  expect_true(is.integer(x$data$m0))
  expect_true(is.integer(x$data$ua))
  expect_true(is.integer(x$data$u1))
  expect_true(is.integer(x$data$u0))
  expect_true(is.integer(x$data$groupsize_total))
  expect_true(is.integer(x$data$calf))
  expect_true(is.integer(x$data$yearling))
  expect_true(is.integer(x$data$adult))
})

test_that("count columns are positive", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$data$fa >= 0))
  expect_true(all(x$data$f1 >= 0))
  expect_true(all(x$data$f0 >= 0))
  expect_true(all(x$data$ma >= 0))
  expect_true(all(x$data$m3 >= 0))
  expect_true(all(x$data$m2 >= 0))
  expect_true(all(x$data$m1 >= 0))
  expect_true(all(x$data$m0 >= 0))
  expect_true(all(x$data$ua >= 0))
  expect_true(all(x$data$u1 >= 0))
  expect_true(all(x$data$u0 >= 0))
  expect_true(all(x$data$groupsize_total >= 0))
  expect_true(all(x$data$calf >= 0))
  expect_true(all(x$data$yearling >= 0))
  expect_true(all(x$data$adult >= 0))
})

# Extra data
# Census (x$census_data)
test_that("census column is positive integer", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$census_data$census >= 0))
  expect_true(all(is.integer(x$census_data$census)))
})

test_that("census_cv column is a number greater than 0", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$census_data$census_cv > 0))
  expect_true(all(is.numeric(x$census_data$census_cv)))
})

test_that("census_study_year is within the levels of `annual` in data", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$census_data$census_study_year %in% x$data$annual))
})

test_that("census_doy column is an integer between 1 and 365", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$census_data$census_doy >= 1 & x$census_data$census_doy <= 365))
  expect_true(all(is.integer(x$census_data$census_doy)))
})

# Prop calf (x$prop_calf_data)
test_that("prop_calf column is a probability", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$prop_calf_data$prop_calf >= 0 & x$prop_calf_data$prop_calf <= 1))
  expect_true(all(is.numeric(x$prop_calf_data$prop_calf)))
})

test_that("prop_calf_cv column is a number greater than 0", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$prop_calf_data$prop_calf_cv > 0))
  expect_true(all(is.numeric(x$prop_calf_data$prop_calf_cv)))
})

test_that("prop_calf_study_year is within the levels of `annual` in data", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$prop_calf_data$prop_calf_study_year %in% x$data$annual))
})

test_that("prop_calf_doy column is an integer between 1 and 365", {
  x <- bpt_manipulate_data_analysis(
    event_data = bpt_event_data,
    location_data = bpt_location_data,
    census_data = bpt_census_data,
    proportion_calf_data = bpt_proportion_calf_data
  )
  expect_true(all(x$prop_calf_data$prop_calf_doy >= 1 & x$prop_calf_data$prop_calf_doy <= 365))
  expect_true(all(is.integer(x$prop_calf_data$prop_calf_doy)))
})
