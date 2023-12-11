data <- list(
  annual = as.factor(c("2021-2022", "2022-2023")),
  x = 1:2,
  y = 10:11
)

levels_annual <- levels(data$annual)

given_census <- 200L
given_census_cv <- 0.2
given_census_study_year <- "2021-2022"
given_census_day_of_year <- 365L
given_proportion_calf <- c(0.2, 0.3)
given_proportion_calf_cv <- c(0.5, 0.5)
given_proportion_calf_study_year <- c("2021-2022", "2022-2023")
given_proportion_calf_day_of_year <- c(365L, 365L)

modified_data <- bpt_modify_data(
  data = data,
  levels_annual = levels_annual,
  census = given_census,
  census_cv = given_census_cv,
  census_study_year = given_census_study_year,
  census_day_of_year = given_census_day_of_year,
  proportion_calf = given_proportion_calf,
  proportion_calf_cv = given_proportion_calf_cv,
  proportion_calf_study_year = given_proportion_calf_study_year,
  proportion_calf_day_of_year = given_proportion_calf_day_of_year
)

test_that("correct number of new objects added to data list", {
  expect_equal(length(modified_data) - length(data), 10L)
})

test_that("ncensus is 1", {
  expect_equal(modified_data$ncensus, 1L)
})

test_that("all census values have length 1", {
  expect_equal(length(modified_data$census), 1L)
  expect_equal(length(modified_data$sCensus), 1L)
  expect_equal(length(modified_data$annual_census), 1L)
  expect_equal(length(modified_data$doy_census), 1L)
})

test_that("nprop_calf is 2", {
  expect_equal(modified_data$nprop_calf, 2L)
})

test_that("all prop_calf values have length 2", {
  expect_equal(length(modified_data$prop_calf), 2L)
  expect_equal(length(modified_data$sPropCalf), 2L)
  expect_equal(length(modified_data$annual_prop_calf), 2L)
  expect_equal(length(modified_data$doy_prop_calf), 2L)
})

# Array type
test_that("census value is an array", {
  expect_equal(class(modified_data$census), "array")
})

test_that("sCensus value is an array", {
  expect_equal(class(modified_data$sCensus), "array")
})

test_that("annual_census value is an array", {
  expect_equal(class(modified_data$annual_census), "array")
})

test_that("doy_census value is an array", {
  expect_equal(class(modified_data$doy_census), "array")
})

test_that("prop_calf values is an array", {
  expect_equal(class(modified_data$prop_calf), "array")
})

test_that("sPropCalf values is an array", {
  expect_equal(class(modified_data$sPropCalf), "array")
})

test_that("annual_prop_calf values is an array", {
  expect_equal(class(modified_data$annual_prop_calf), "array")
})

test_that("doy_prop_calf values is an array", {
  expect_equal(class(modified_data$doy_prop_calf), "array")
})

# Check appropriate transformations were done
test_that("census is the same number provided", {
  expect_true(is.integer(modified_data$census))
  expect_equal(as.numeric(modified_data$census), given_census)
})

test_that("prop_calf is the same number provided", {
  expect_equal(as.numeric(modified_data$prop_calf), given_proportion_calf)
})

test_that("census sd is census_cv * census", {
  expect_equal(
    as.numeric(modified_data$sCensus),
    given_census_cv * given_census
  )
})

test_that("prop_calf sd is prop_calf_cv * prop_calf", {
  expect_equal(
    as.numeric(modified_data$sPropCalf),
    c(given_proportion_calf_cv * given_proportion_calf)
  )
})

test_that("annual_census is the appropriate integer", {
  expect_true(is.integer(modified_data$annual_census))
  expect_equal(
    as.integer(modified_data$annual_census),
    which(levels_annual == given_census_study_year)
  )
})


test_that("annual_prop_calf is the appropriate integer", {
  expect_true(is.integer(modified_data$annual_prop_calf))
  expect_equal(
    as.integer(modified_data$annual_prop_calf),
    which(levels_annual == given_proportion_calf_study_year)
  )
})

test_that("doy_census is the same number provided", {
  expect_true(is.integer(modified_data$doy_census))
  expect_equal(
    as.integer(modified_data$doy_census),
    given_census_day_of_year
  )
})

test_that("doy_prop_calf is the same number provided", {
  expect_true(is.integer(modified_data$doy_prop_calf))
  expect_equal(
    as.integer(modified_data$doy_prop_calf),
    given_proportion_calf_day_of_year
  )
})

# Check input checks
test_that("data provided as a dataframe errors", {
  expect_error(
    bpt_modify_data(
      data = data.frame(
        year = 2021L,
        doy = 1L,
        n = 1L,
        prop_calf = 0.2
      ),
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "Data must be in a list format as passed through embr::analyse()"
  )
})

test_that("errors if census_study_year is not a subset of levels_annual", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = c("2025-2026"),
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`census_study_year` must match '2021-2022' or '2022-2023', not '2025-2026'."
  )
})

test_that("errors if proportion_calf_study_year is not a subset of levels_annual", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = c("2021-2022", "2026-2027"),
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`proportion_calf_study_year` must have values matching '2021-2022' or '2022-2023'."
  )
})


test_that("errors if census_day_of_year is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = 1.5,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`census_day_of_year` must be integer."
  )
})

test_that("errors if proportion_calf_day_of_year is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = c(1.5, 1L)
    ),
    "`proportion_calf_day_of_year` must be integer."
  )
})

test_that("errors if census_day_of_year is not between 1 and 365", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = 400L,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`census_day_of_year` must match 1, 2, 3, 4, 5, 6, 7, 8, ... or 365, not 400."
  )
})

test_that("errors if proportion_calf_day_of_year is not between 1 and 365", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = c(0L, 10L)
    ),
    regexp = paste0(
      "`proportion_calf_day_of_year` must have values matching ",
      "1, 2, 3, 4, 5, 6, 7, 8, ... or 365."
    )
  )
})

test_that("errors if census is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = 1.5,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`census` must be integer."
  )
})

test_that("errors if proportion_calf is not a number between 0 and 1", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = c(0.2, 1.2),
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`proportion_calf` must have values between 0 and 1."
  )
})

test_that("errors if census cv is less than 0", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = -0.1,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = given_proportion_calf_cv,
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`census_cv` must be greater than 0, not -0.1."
  )
})

test_that("errors if proportion_calf cv is less than 0", {
  expect_chk_error(
    bpt_modify_data(
      data = data,
      levels_annual = levels_annual,
      census = given_census,
      census_cv = given_census_cv,
      census_study_year = given_census_study_year,
      census_day_of_year = given_census_day_of_year,
      proportion_calf = given_proportion_calf,
      proportion_calf_cv = c(-0.1, 0.2),
      proportion_calf_study_year = given_proportion_calf_study_year,
      proportion_calf_day_of_year = given_proportion_calf_day_of_year
    ),
    "`proportion_calf_cv` must have values greater than 0."
  )
})
