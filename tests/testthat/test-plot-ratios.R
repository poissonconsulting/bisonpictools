test_that("plot ratios", {
  plot <- plot_ratios(event_data(), location_data(), "fa", "ma")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot_1")
})

