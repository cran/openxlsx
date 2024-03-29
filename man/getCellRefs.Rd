% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{getCellRefs}
\alias{getCellRefs}
\title{Return excel cell coordinates from (x,y) coordinates}
\usage{
getCellRefs(cellCoords)
}
\arguments{
\item{cellCoords}{A data.frame with two columns coordinate pairs.}
}
\value{
Excel alphanumeric cell reference
}
\description{
Return excel cell coordinates from (x,y) coordinates
}
\examples{
getCellRefs(data.frame(1, 2))
# "B1"
getCellRefs(data.frame(1:3, 2:4))
# "B1" "C2" "D3"
}
\author{
Philipp Schauberger, Alexander Walker
}
