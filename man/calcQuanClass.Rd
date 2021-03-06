% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calcQuanClass.R
\name{calcQuanClass}
\alias{calcQuanClass}
\title{Calculate and return quantile class by year and month}
\usage{
calcQuanClass(
  data,
  dateCol = "date",
  valueCol = "flow",
  transform = logtrans,
  numClasses = 4,
  startYear,
  endYear,
  yearType = "calendar",
  report = TRUE
)
}
\arguments{
\item{data}{Data table to analyze. Must have two columns: \code{dateCol} and
\code{valueCol} which contain a date and value to analyze, respectively}

\item{dateCol}{Column name that contains date}

\item{valueCol}{Column name that contains values for analyzing for quantiles}

\item{transform}{if set to "logtrans" then values are log transformed before analysis}

\item{numClasses}{Number of classes for computing quantiles}

\item{startYear}{First year to maintain in returned data set}

\item{endYear}{Last year to maintain in returned data set}

\item{yearType}{Indicate whether to perform analysis on a "calendar" or
"water" year}

\item{report}{Indicate whether to print table}
}
\value{
data table with cross tabulation of quantiles by year and month
}
\description{
Calculate and return quantile class by year and month
}
\details{
Quantiles are computed using all provided data, i.e., long-term
quantiles. The \code{startYear} and \code{endYear} limit the returned
data table to the desired year. 

Setting \code{probabilities} to \code{seq(0, 1, length.out = 5)} results in
probabilities being set to 0, 0.25, 0.50, 0.75, and 1.00; This leads to four
(4) classes being assigned where the leftmost interval corresponds to level
one, the next leftmost to level two and so on. Setting \code{length.out = 6}
will yield probabilities of 0, 0.2, 0.4, 0.6, 0.8, 1.0.
}
\examples{
# TBD

}
\seealso{
\code{\link{readTextFile}}
}
