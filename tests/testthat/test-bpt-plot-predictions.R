analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

test_that("plot predicted total abundances", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot-total-abundance")
})

test_that("plot predicted abundances by class", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "abundance-class")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot-abundance-class")
})

test_that("plot predicted survival rates", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "survival")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot-survival")
})

test_that("plot predicted fecundity rates", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "fecundity")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot-fecundity")
})

test_that("plot predicted ratios", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "ratios")
  expect_s3_class(plot, "ggplot")
  expect_snapshot_plot(plot, "plot-ratios")
})

test_that("plot is ggplot if we turn off snapshots", {
  plot <- bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
  expect_s3_class(plot, "ggplot")
})

test_that("default prediction type gives same type as the abundance-total specifies", {
  plot1 <- bpt_plot_predictions(analysis = analysis)
  plot2 <- bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
  expect_equal(plot1, plot2)
})
