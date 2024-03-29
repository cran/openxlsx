% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{activeSheet}
\alias{activeSheet}
\alias{activeSheet<-}
\title{Get/set active sheet of the workbook}
\usage{
activeSheet(wb)

activeSheet(wb) <- value
}
\arguments{
\item{wb}{A workbook object}

\item{value}{index of the active sheet or name of the active sheet}
}
\value{
return the active sheet of the workbook
}
\description{
Get and set active sheet of the workbook
}
\examples{

wb <- createWorkbook()
addWorksheet(wb, sheetName = "S1")
addWorksheet(wb, sheetName = "S2")
addWorksheet(wb, sheetName = "S3")

activeSheet(wb) # default value is the first sheet active
activeSheet(wb) <- 1 ## active sheet S1
activeSheet(wb)
activeSheet(wb) <- "S2" ## active sheet S2
activeSheet(wb)
}
\author{
Philipp Schauberger
}
