# Unusual inputs
test_that("errors with null input", {
  expect_error(bpt_manipulate_data_plot(NULL), "argument \"location_data\" is missing, with no default")  
  expect_chk_error(bpt_manipulate_data_plot(bpt_event_data(), NULL), "The `complete = TRUE` argument was provided but not all data sets were
        supplied. Either change `complete = FALSE` or supply all the data in the
        `...` argument.")  
})

test_that("errors with vector inputs", {
  expect_chk_error(bpt_manipulate_data_plot(c(1, 2, 3), c(1, 2, 3)), "Column names in data must include 'f0', 'f1', 'fa', 'fu', 'location_id', 'm0', 'm1', 'm2', ... and 'uu'.")
})

# Wrong input type 
# event_data ----
test_that("errors with numeric location_id column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(location_id = 1:nrow(bpt_event_data())),
      location_data = bpt_location_data() 
    ),
    "All 'location_id' values in the event table must be in the location table. The following rows\\(s\\) in the event table are causing the issue: 1, 2, 3, 4, 5, 6, 7."
  )
})

test_that("errors with real f0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(f0 = as.numeric(.data$f0)),
      location_data = bpt_location_data()
    ), # This isn't producing an error? Is it because it can be coerced to integer?
    "`event_data\\$f0` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character f0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(f0 = as.character(.data$f0)),
      location_data = bpt_location_data()
    ), # Is this also because it can be coerced to integer?
    "`event_data\\$f0` must inherit from S3 class 'integer'."
  )
  
  # Produces informative error when it's letters instead
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(f0 = letters[1:nrow(bpt_event_data())]),
      location_data = bpt_location_data()
    ), # Is this also because it can be coerced to integer?
    "The following values in column 'f0' should be a integer: 'a', 'b', 'c', 'd', 'e', 'f' and 'g'."
  )
})

test_that("errors with real f1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(f1 = as.numeric(.data$f1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$f1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character f1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(f1 = as.character(.data$f1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$f1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real fa column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(fa = as.numeric(.data$fa)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$fa` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character fa column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(fa = as.character(.data$fa)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$fa` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real fu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(fu = as.numeric(.data$fu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$fu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character fu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(fu = as.character(.data$fu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$fu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real m0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m0 = as.numeric(.data$m0)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m0` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character m0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m0 = as.character(.data$m0)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m0` must inherit from S3 class 'integer'."
  )
})


test_that("errors with real m1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m1 = as.numeric(.data$m1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character m1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m1 = as.character(.data$m1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real m2 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m2 = as.numeric(.data$m2)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m2` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character m2 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m2 = as.character(.data$m2)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m2` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real m3 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m3 = as.numeric(.data$m3)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m3` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character m3 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(m3 = as.character(.data$m3)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$m3` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real ma column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(ma = as.numeric(.data$ma)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$ma` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character ma column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(ma = as.character(.data$ma)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$ma` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real mu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(mu = as.numeric(.data$mu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$mu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character mu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(mu = as.character(.data$mu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$mu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real u0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(u0 = as.numeric(.data$u0)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$u0` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character u0 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(u0 = as.character(.data$u0)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$u0` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real u1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(u1 = as.numeric(.data$u1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$u1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character u1 column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(u1 = as.character(.data$u1)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$u1` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real ua column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(ua = as.numeric(.data$ua)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$ua` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character ua column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(ua = as.character(.data$ua)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$ua` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real uu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(uu = as.numeric(.data$uu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$uu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character uu column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(uu = as.character(.data$uu)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$uu` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real start_year column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_year = as.numeric(.data$start_year)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_year` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character start_year column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_year = as.character(.data$start_year)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_year` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real start_month column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_month = as.numeric(.data$start_month)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_month` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character start_month column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_month = as.character(.data$start_month)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_month` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real start_day column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_day = as.numeric(.data$start_day)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_day` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character start_day column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_day = as.character(.data$start_day)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_day` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real start_hour column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_hour = as.numeric(.data$start_hour)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_hour` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character start_hour column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_hour = as.character(.data$start_hour)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_hour` must inherit from S3 class 'integer'."
  )
})

test_that("errors with real start_minute column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_minute = as.numeric(.data$start_minute)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_minute` must inherit from S3 class 'integer'."
  )
})

test_that("errors with character start_minute column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(start_minute = as.character(.data$start_minute)),
      location_data = bpt_location_data()
    ),
    "`event_data\\$start_minute` must inherit from S3 class 'integer'."
  )
})

# location_data ----
test_that("errors with numeric location_id column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data(),
      location_data = bpt_location_data() |> 
        dplyr::mutate(location_id = 1:nrow(bpt_location_data()))
    ),
    "`location_data\\$location_id` must inherit from S3 class 'character'."
  )
})

test_that("errors with character latitude column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data(),
      location_data = bpt_location_data() |> 
        dplyr::mutate(latitude = as.character(.data$latitude))
    ),
    "`location_data\\$latitude` must inherit from S3 class 'numeric'"
  )
})

test_that("errors with character longitude column", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data(),
      location_data = bpt_location_data() |> 
        dplyr::mutate(longitude = as.character(.data$longitude))
    ),
    "`location_data\\$longitude` must inherit from S3 class 'numeric'"
  )
})

# Join error
test_that("errors if `event_data` has location_id's that are not present in `location_data`", {
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(
          location_id = c(
            "RLBH008", "RLBH299", "RLBH101", "RLBH999", "RLBH1000", "RLBH010", 
            "RLBH000"
          )
        ),
      location_data = bpt_location_data()
    ),
    "All 'location_id' values in the event table must be in the location table. The following rows\\(s\\) in the event table are causing the issue: 1, 2, 3, 4, 5, 6, 7."
  )
  
  expect_chk_error(
    bpt_manipulate_data_plot(
      event_data = bpt_event_data() |> 
        dplyr::mutate(
          location_id = dplyr::if_else(location_id == "RLBH007", "RLBH012", location_id)
        ),
      location_data = bpt_location_data()
    ),
    "All 'location_id' values in the event table must be in the location table. The following rows\\(s\\) in the event table are causing the issue: 4, 5, 6, 7."
  )
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
