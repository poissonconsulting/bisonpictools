% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bpt-plot-predictions.R
\name{bpt_plot_predictions}
\alias{bpt_plot_predictions}
\title{Plot predictions}
\usage{
bpt_plot_predictions(analysis, prediction = "abundance-total")
}
\arguments{
\item{analysis}{Analysis object from \code{bpt_analyse()}.}

\item{prediction}{One of the following:
\itemize{
\item "abundance-class": plots abundances by class and study year.
\item "abundance-total": plots total herd abundance by study year.
\item "survival": plots survival rates by class and study year (bull rate
includes M2, M3, MA).
\item "fecundity": plots fecundity rate and proportion of reproductive cows.
\item "ratios": plots ratios by study year.
}}
}
\value{
A \code{ggplot2} object.
}
\description{
Generates a plot of the specified prediction from the analysis object.
}
\examples{
\dontrun{
bpt_plot_predictions(analysis = analysis, prediction = "abundance-class")
bpt_plot_predictions(analysis = analysis, prediction = "abundance-total")
bpt_plot_predictions(analysis = analysis, prediction = "survival")
bpt_plot_predictions(analysis = analysis, prediction = "fecundity")
bpt_plot_predictions(analysis = analysis, prediction = "ratios")
}
}
