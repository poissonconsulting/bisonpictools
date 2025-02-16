% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bpt-check-data.R
\name{bpt_check_data}
\alias{bpt_check_data}
\title{Data checks based on the template}
\usage{
bpt_check_data(
  event = NULL,
  location = NULL,
  census = NULL,
  proportion_calf = NULL,
  complete = FALSE,
  join = FALSE,
  check_study_years = FALSE
)
}
\arguments{
\item{event}{A data frame of event data.}

\item{location}{A data frame of location data.}

\item{census}{A data frame of census data.}

\item{proportion_calf}{A data frame of calf proportion data.}

\item{complete}{A flag indicating if all data frames need to be supplied.}

\item{join}{A flag indicating if joins should be checked.}

\item{check_study_years}{A flag indicating if study years should be checked
(census and calf proportion data must be within the same study years as the
event data)}
}
\value{
A list of data frames.
}
\description{
Confirms the columns types match the
template, the values follow the allowed ranges of the template and tables can
be joined appropriately.
}
\examples{
\dontrun{
# When all data sets are present
data <- bpt_check_data(
  event = event_data,
  location = location_data,
  census = census_data,
  proportion_calf = proportion_calf_data,
  complete = TRUE,
  join = TRUE,
  check_study_years = TRUE
)
event_data <- data$event
location_data <- data$location
# To check only a single data set
data_1 <- bpt_check_data(location = location_data)
data_2 <- bpt_check_data(event = event_data)
data_3 <- bpt_check_data(census = census_data)
data_4 <- bpt_check_data(proportion_calf = proportion_calf_data)
# Should error, as `complete = TRUE` requires all 4 data sets be provided
try(event <- bpt_check_data(event = event_data, complete = TRUE))
}
}
