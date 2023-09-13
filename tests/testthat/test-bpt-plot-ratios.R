test_that("plot ratios cow:bull", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = "fa", 
    denominator = "ma"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_cow_bull")
})

test_that("plot ratios f1:m1", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = "f1", 
    denominator = "m1"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_f1_m1")
})

test_that("plot ratios calf:cow", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow")
})

test_that("plot ratios yearling:cow", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m1", "f1", "u1"), 
    denominator = "fa"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_yearling_cow")
})

test_that("plot ratios calf:cow 2021-2022", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    study_years = "2021-2022"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_2021_2022")
})

test_that("plot ratios calf:cow 2019-2020", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    study_years = "2019-2020"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_2019_2020")
})

test_that("plot ratios calf:cow LOCID1", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    locations = "LOCID1"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_LOCID1")
})

test_that("plot ratios calf:cow LOCID2", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    locations = "LOCID2"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_LOCID2")
})

test_that("plot ratios calf:cow LOCID3 2019-2020", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    study_years = "2019-2020",
    locations = "LOCID3"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_2019_2020_LOCID3")
})

test_that("plot ratios calf:cow LOCID4 2021-2022", {
  plot <- bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "fa",
    study_years = "2021-2022",
    locations = "LOCID4"
  )
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_calf_cow_2021_2022_LOCID4")
})

test_that("plot unknown class errors denominator", {
  expect_error(bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = c("m0", "f0", "u0"), 
    denominator = "f5",
    study_years = "2021-2022"
  ),
  "Denominator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("plot unknown class errors numerator", {
  expect_error(bpt_plot_ratios(
    event_data = bpt_event_data, 
    location_data = bpt_location_data, 
    numerator = "f10", 
    denominator = "f1",
    study_years = "2021-2022"
  ),
  "Numerator is not a compatible class. Ensure all elements are in: c\\('fa', 'f1', f0', 'fu', 'ma', 'm3', 'm2', 'm1', 'm0', 'mu', 'ua', 'u1', 'u0', 'uu'\\)."
  )
})

test_that("plot with 0 individuals in ratio", {
 expect_error(
   bpt_plot_ratios(
      event_data = bpt_event_data,
      location_data = bpt_location_data,
      numerator = "fu",
      denominator = "mu",
      study_years = "2018-2019",
      locations = "LOCID1"
    ),
  "There are 0 individuals in the selection for numerator and denominator. Ratio not plotted."
 )
})
