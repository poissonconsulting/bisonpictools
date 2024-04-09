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

test_that("correct number of new objects added to data list", {
  data <- list(
    annual = as.factor(c("2021-2022", "2022-2023")),
    x = 1:2,
    y = 10:11
  )
  modified_data <- bpt_modify_data(
    data = data,
    levels_annual = levels(data$annual),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(length(modified_data) - length(data), 10L)
})

test_that("ncensus is 1", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(modified_data$ncensus, 1L)
})

test_that("all census values have length 1", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(length(modified_data$census), 1L)
  expect_equal(length(modified_data$sCensus), 1L)
  expect_equal(length(modified_data$annual_census), 1L)
  expect_equal(length(modified_data$doy_census), 1L)
})

test_that("nprop_calf is 2", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(modified_data$nprop_calf, 2L)
})

test_that("all prop_calf values have length 2", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(length(modified_data$prop_calf), 2L)
  expect_equal(length(modified_data$sPropCalf), 2L)
  expect_equal(length(modified_data$annual_prop_calf), 2L)
  expect_equal(length(modified_data$doy_prop_calf), 2L)
})

# Array type
test_that("census value is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$census), "array")
})

test_that("sCensus value is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$sCensus), "array")
})

test_that("annual_census value is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$annual_census), "array")
})

test_that("doy_census value is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$doy_census), "array")
})

test_that("prop_calf values is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$prop_calf), "array")
})

test_that("sPropCalf values is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$sPropCalf), "array")
})

test_that("annual_prop_calf values is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$annual_prop_calf), "array")
})

test_that("doy_prop_calf values is an array", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(class(modified_data$doy_prop_calf), "array")
})

# Check appropriate transformations were done
test_that("census is the same number provided", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_true(is.integer(modified_data$census))
  expect_equal(as.numeric(modified_data$census), 200L)
})

test_that("prop_calf is the same number provided", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(as.numeric(modified_data$prop_calf), c(0.2, 0.3))
})

test_that("census sd is census_cv * census", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(
    as.numeric(modified_data$sCensus),
    0.2 * 200L
  )
})

test_that("prop_calf sd is prop_calf_cv * prop_calf", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_equal(
    as.numeric(modified_data$sPropCalf),
    c(0.5, 0.5) * c(0.2, 0.3)
  )
})

test_that("annual_census is the appropriate integer", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_true(is.integer(modified_data$annual_census))
  expect_equal(
    as.integer(modified_data$annual_census),
    1
  )
})


test_that("annual_prop_calf is the appropriate integer", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_true(is.integer(modified_data$annual_prop_calf))
  expect_equal(
    as.integer(modified_data$annual_prop_calf),
    c(1, 2)
  )
})

test_that("doy_census is the same number provided", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_true(is.integer(modified_data$doy_census))
  expect_equal(
    as.integer(modified_data$doy_census),
    365L
  )
})

test_that("doy_prop_calf is the same number provided", {
  modified_data <- bpt_modify_data(
    data = list(
      annual = as.factor(c("2021-2022", "2022-2023")),
      x = 1:2,
      y = 10:11
    ),
    levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
    census = 200L,
    census_cv = 0.2,
    census_study_year = "2021-2022",
    census_day_of_year = 365L,
    proportion_calf = c(0.2, 0.3),
    proportion_calf_cv = c(0.5, 0.5),
    proportion_calf_study_year = c("2021-2022", "2022-2023"),
    proportion_calf_day_of_year = c(365L, 365L)
  )
  expect_true(is.integer(modified_data$doy_prop_calf))
  expect_equal(
    as.integer(modified_data$doy_prop_calf),
    c(365L, 365L)
  )
})

# Check input checks
test_that("data provided as a dataframe errors", {
  expect_error(
    modified_data <- bpt_modify_data(
      data = data.frame(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = "2021-2022",
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "Data must be in a list format as passed through embr::analyse()"
  )
})

test_that("errors if census_study_year is not a subset of levels_annual", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2025-2026"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    regexp = paste0(
      "`census_study_year` must match '2021-2022' or '2022-2023', not ",
      "'2025-2026'."
    )
  )
})

test_that(
  "errors if proportion_calf_study_year is not a subset of levels_annual",
  {
    expect_chk_error(
      bpt_modify_data(
        data = list(
          annual = as.factor(c("2021-2022", "2022-2023")),
          x = 1:2,
          y = 10:11
        ),
        levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
        census = 200L,
        census_cv = 0.2,
        census_study_year = c("2021-2022"),
        census_day_of_year = 365L,
        proportion_calf = c(0.2, 0.3),
        proportion_calf_cv = c(0.5, 0.5),
        proportion_calf_study_year = c("2021-2022", "2026-2027"),
        proportion_calf_day_of_year = c(365L, 365L)
      ),
      regexp = paste0(
        "`proportion_calf_study_year` must have values matching '2021-2022' ",
        "or '2022-2023'."
      )
    )
  }
)


test_that("errors if census_day_of_year is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 0.1,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "`census_day_of_year` must be integer."
  )
})

test_that("errors if proportion_calf_day_of_year is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(1.5, 365L)
    ),
    "`proportion_calf_day_of_year` must be integer."
  )
})

test_that("errors if census_day_of_year is not between 1 and 366", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 400L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    regexp = paste0(
      "`census_day_of_year` must match 1, 2, 3, 4, 5, 6, 7, 8, ... or 366, ",
      "not 400."
    )
  )
})

test_that("errors if proportion_calf_day_of_year is not between 1 and 366", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(0L, 10L)
    ),
    regexp = paste0(
      "`proportion_calf_day_of_year` must have values matching ",
      "1, 2, 3, 4, 5, 6, 7, 8, ... or 366."
    )
  )
})

test_that("errors if census is not an integer", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 1.5,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "`census` must be integer."
  )
})

test_that("errors if proportion_calf is not a number between 0 and 1", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 1.2),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "`proportion_calf` must have values between 0 and 1."
  )
})

test_that("errors if census cv is less than 0", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = -0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "`census_cv` must be greater than 0, not -0.2."
  )
})

test_that("errors if proportion_calf cv is less than 0", {
  expect_chk_error(
    bpt_modify_data(
      data = list(
        annual = as.factor(c("2021-2022", "2022-2023")),
        x = 1:2,
        y = 10:11
      ),
      levels_annual = levels(as.factor(c("2021-2022", "2022-2023"))),
      census = 200L,
      census_cv = 0.2,
      census_study_year = c("2021-2022"),
      census_day_of_year = 365L,
      proportion_calf = c(0.2, 0.3),
      proportion_calf_cv = c(-0.5, 0.5),
      proportion_calf_study_year = c("2021-2022", "2022-2023"),
      proportion_calf_day_of_year = c(365L, 365L)
    ),
    "`proportion_calf_cv` must have values greater than 0."
  )
})
