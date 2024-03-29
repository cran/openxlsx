% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{modifyBaseFont}
\alias{modifyBaseFont}
\title{Modify the default font}
\usage{
modifyBaseFont(wb, fontSize = 11, fontColour = "black", fontName = "Calibri")
}
\arguments{
\item{wb}{A workbook object}

\item{fontSize}{font size}

\item{fontColour}{font colour}

\item{fontName}{Name of a font}
}
\description{
Modify the default font for this workbook
}
\details{
The font name is not validated in anyway.  Excel replaces unknown font names
with Arial. Base font is black, size 11, Calibri.
}
\examples{
## create a workbook
wb <- createWorkbook()
addWorksheet(wb, "S1")
## modify base font to size 10 Arial Narrow in red
modifyBaseFont(wb, fontSize = 10, fontColour = "#FF0000", fontName = "Arial Narrow")

writeData(wb, "S1", iris)
writeDataTable(wb, "S1", x = iris, startCol = 10) ## font colour does not affect tables
\dontrun{
saveWorkbook(wb, "modifyBaseFontExample.xlsx", overwrite = TRUE)
}
}
\author{
Alexander Walker
}
