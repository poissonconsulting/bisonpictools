% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bpt-predict-abundance-total.R
\name{bpt_predict_abundance_total}
\alias{bpt_predict_abundance_total}
\title{Predict total abundance}
\usage{
bpt_predict_abundance_total(analysis)
}
\arguments{
\item{analysis}{Analysis object from \code{bpt_analyse()}.}
}
\value{
A tibble of total abundances for each study year, including the
median posterior value (estimate) and lower and upper 95\% credible
intervals.
}
\description{
Predicts the total herd abundance for each study year, as the sum of the
predicted abundances for each class.
}
\examples{
\dontrun{
bpt_predict_abundance_total(analysis)
}
}
