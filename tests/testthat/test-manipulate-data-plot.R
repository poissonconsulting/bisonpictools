test_event <- tibble::tibble(
  location_id	= "RLBH006",
  start_year	= 2021,
  start_month	= 04,
  start_day	= 12,
  start_hour = 13,
  start_minute = 50,
  fa	= 1,
  f1	= 1,
  f0	= 2,
  fu	= 0,
  ma	= 1,
  m3	= 0,	
  m2	= 0,
  m1	= 1,	
  m0	= 1,
  mu	= 0,
  ua	= 0,
  u1	= 1,
  u0	= 1,
  uu	= 1,
)

test_location <- tibble::tibble( 
  location_id = "RLBH006",
  latitude = 57.895690000000002,
  longitude = -111.67757
)

test_that("returns tibble", {
  x <- manipulate_data_plot(event_data = test_event, location_data = test_location)
  expect_true(all(attributes(x)$class == c("tbl_df", "tbl", "data.frame")))
})
