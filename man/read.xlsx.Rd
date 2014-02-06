\name{read.xlsx}
\alias{read.xlsx}
\title{Read data from a worksheet into a data.frame}
\usage{
read.xlsx(xlsxFile, sheet = 1, startRow = 1, colNames = TRUE)
}
\arguments{
  \item{xlsxFile}{A xlsx workbook}

  \item{sheet}{The name or index of the sheet to read data}

  \item{startRow}{startRow is used to specify where to
  begin looking for data.  Empty rows will be skipped
  regardless of the value of startRow.}

  \item{colNames}{IF TRUE, will attempt to look for column
  names.}
}
\value{
data.frame
}
\description{
Read data from a worksheet into a data.frame
}
\details{
Creates a data.frame of all data in worksheet. If the first
row of data consists entirely of strings, these will be
used as column names.
}
\examples{
xlsxFile <- system.file("readTest.xlsx", package = "openxlsx")
system.time({df1 <- read.xlsx(xlsxFile = xlsxFile, sheet = 1)})
system.time({df2 <- read.xlsx(xlsxFile = xlsxFile, sheet = 2)})
system.time({df3 <- read.xlsx(xlsxFile = xlsxFile, sheet = 3)}) ## empty columns are skipped
system.time({df4 <- read.xlsx(xlsxFile = xlsxFile, sheet = 4)}) ## Numeric columns are padded with 0
system.time({df5 <- read.xlsx(xlsxFile = xlsxFile, sheet = 5, startRow = 2)})
system.time({df6 <- read.xlsx(xlsxFile = xlsxFile, sheet = 6)}) ## NULL
system.time({df7 <- read.xlsx(xlsxFile = xlsxFile, sheet = 7)})
system.time({df8 <- read.xlsx(xlsxFile = xlsxFile, sheet = 8)}) ##
}
\author{
Alexander Walker
}
\seealso{
\code{\link{readWorkbook}}
}

