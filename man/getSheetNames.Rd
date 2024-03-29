% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{getSheetNames}
\alias{getSheetNames}
\title{Get names of worksheets}
\usage{
getSheetNames(file)
}
\arguments{
\item{file}{An xlsx or xlsm file.}
}
\value{
Character vector of worksheet names.
}
\description{
Returns the worksheet names within an xlsx file
}
\examples{
getSheetNames(system.file("extdata", "readTest.xlsx", package = "openxlsx"))
}
\author{
Alexander Walker
}
