if (FALSE) {
  location_data <- bisonpictools::bpt_location_data
  event_data <- bisonpictools::bpt_event_data
  census_data <- bisonpictools::bpt_census_data
  proportion_calf_data <- bisonpictools::bpt_proportion_calf_data
  analysis <- bpt_analyse(
    event_data = event_data,
    location_data = location_data,
    census_data = census_data,
    proportion_calf_data = proportion_calf_data,
    nthin = 1L,
    analysis_mode = "quick"
  )
  bpt_save_analysis(analysis, "inst/test-objects/analysis")
  glance <- embr::glance(analysis)
  saveRDS(glance, "inst/test-objects/glance.RDS")
}
