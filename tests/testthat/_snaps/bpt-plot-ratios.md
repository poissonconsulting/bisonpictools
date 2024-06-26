# seasons plot function gets seasons 

    Code
      seasons_plot(c("2021", "2022"))
    Output
      # A tibble: 6 x 4
        season      start_date_time     end_date_time       study_year
        <fct>       <dttm>              <dttm>              <fct>     
      1 Calving     2021-04-01 00:00:00 2021-06-30 23:59:59 2021-2022 
      2 Calving     2022-04-01 00:00:00 2022-06-30 23:59:59 2022-2023 
      3 Summer/Fall 2021-07-01 00:00:00 2021-11-30 23:59:59 2021-2022 
      4 Summer/Fall 2022-07-01 00:00:00 2022-11-30 23:59:59 2022-2023 
      5 Winter      2021-12-01 00:00:00 2022-03-31 23:59:59 2021-2022 
      6 Winter      2022-12-01 00:00:00 2023-03-31 23:59:59 2022-2023 

# label function changes to true ratio

    Code
      ratio_labels(breaks)
    Output
       [1] "0"   "0.1" "0.2" "0.4" "0.7" "1"   "1.5" "2.3" "4"   "9"   "Inf"

