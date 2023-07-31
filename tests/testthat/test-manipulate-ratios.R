test_that("all ratios are ≤ 1", {
  expect_true(max(manipulate_ratios(manipulate_data_plot(event_data(), location_data()), "f1", "f0")$ratio) <= 1)
})

test_that("all ratios are ≥ 0", {
  expect_true(min(manipulate_ratios(manipulate_data_plot(event_data(), location_data()), "f1", "f0")$ratio) >= 0)
})
