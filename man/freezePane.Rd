% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{freezePane}
\alias{freezePane}
\title{Freeze a worksheet pane}
\usage{
freezePane(
  wb,
  sheet,
  firstActiveRow = NULL,
  firstActiveCol = NULL,
  firstRow = FALSE,
  firstCol = FALSE
)
}
\arguments{
\item{wb}{A workbook object}

\item{sheet}{A name or index of a worksheet}

\item{firstActiveRow}{Top row of active region}

\item{firstActiveCol}{Furthest left column of active region}

\item{firstRow}{If \code{TRUE}, freezes the first row (equivalent to firstActiveRow = 2)}

\item{firstCol}{If \code{TRUE}, freezes the first column (equivalent to firstActiveCol = 2)}
}
\description{
Freeze a worksheet pane
}
\examples{
## Create a new workbook
wb <- createWorkbook("Kenshin")

## Add some worksheets
addWorksheet(wb, "Sheet 1")
addWorksheet(wb, "Sheet 2")
addWorksheet(wb, "Sheet 3")
addWorksheet(wb, "Sheet 4")

## Freeze Panes
freezePane(wb, "Sheet 1", firstActiveRow = 5, firstActiveCol = 3)
freezePane(wb, "Sheet 2", firstCol = TRUE) ## shortcut to firstActiveCol = 2
freezePane(wb, 3, firstRow = TRUE) ## shortcut to firstActiveRow = 2
freezePane(wb, 4, firstActiveRow = 1, firstActiveCol = "D")

## Save workbook
\dontrun{
saveWorkbook(wb, "freezePaneExample.xlsx", overwrite = TRUE)
}
}
\author{
Alexander Walker
}
