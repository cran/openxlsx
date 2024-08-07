% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wrappers.R
\name{pageSetup}
\alias{pageSetup}
\title{Set page margins, orientation and print scaling}
\usage{
pageSetup(
  wb,
  sheet,
  orientation = NULL,
  scale = 100,
  left = 0.7,
  right = 0.7,
  top = 0.75,
  bottom = 0.75,
  header = 0.3,
  footer = 0.3,
  fitToWidth = FALSE,
  fitToHeight = FALSE,
  paperSize = NULL,
  printTitleRows = NULL,
  printTitleCols = NULL,
  summaryRow = NULL,
  summaryCol = NULL
)
}
\arguments{
\item{wb}{A workbook object}

\item{sheet}{A name or index of a worksheet}

\item{orientation}{Page orientation. One of "portrait" or "landscape"}

\item{scale}{Print scaling. Numeric value between 10 and 400}

\item{left}{left page margin in inches}

\item{right}{right page margin in inches}

\item{top}{top page margin in inches}

\item{bottom}{bottom page margin in inches}

\item{header}{header margin in inches}

\item{footer}{footer margin in inches}

\item{fitToWidth}{If \code{TRUE}, worksheet is scaled to fit to page width on printing.}

\item{fitToHeight}{If \code{TRUE}, worksheet is scaled to fit to page height on printing.}

\item{paperSize}{See details. Default value is 9 (A4 paper).}

\item{printTitleRows}{Rows to repeat at top of page when printing. Integer vector.}

\item{printTitleCols}{Columns to repeat at left when printing. Integer vector.}

\item{summaryRow}{Location of summary rows in groupings. One of "Above" or "Below".}

\item{summaryCol}{Location of summary columns in groupings. One of "Right" or "Left".}
}
\description{
Set page margins, orientation and print scaling
}
\details{
paperSize is an integer corresponding to:
\describe{
\item{\strong{1}}{ Letter paper (8.5 in. by 11 in.)}
\item{\strong{2}}{ Letter small paper (8.5 in. by 11 in.)}
\item{\strong{3}}{ Tabloid paper (11 in. by 17 in.)}
\item{\strong{4}}{ Ledger paper (17 in. by 11 in.)}
\item{\strong{5}}{ Legal paper (8.5 in. by 14 in.)}
\item{\strong{6}}{ Statement paper (5.5 in. by 8.5 in.)}
\item{\strong{7}}{ Executive paper (7.25 in. by 10.5 in.)}
\item{\strong{8}}{ A3 paper (297 mm by 420 mm)}
\item{\strong{9}}{ A4 paper (210 mm by 297 mm)}
\item{\strong{10}}{ A4 small paper (210 mm by 297 mm)}
\item{\strong{11}}{ A5 paper (148 mm by 210 mm)}
\item{\strong{12}}{ B4 paper (250 mm by 353 mm)}
\item{\strong{13}}{ B5 paper (176 mm by 250 mm)}
\item{\strong{14}}{ Folio paper (8.5 in. by 13 in.)}
\item{\strong{15}}{ Quarto paper (215 mm by 275 mm)}
\item{\strong{16}}{ Standard paper (10 in. by 14 in.)}
\item{\strong{17}}{ Standard paper (11 in. by 17 in.)}
\item{\strong{18}}{ Note paper (8.5 in. by 11 in.)}
\item{\strong{19}}{ #9 envelope (3.875 in. by 8.875 in.)}
\item{\strong{20}}{ #10 envelope (4.125 in. by 9.5 in.)}
\item{\strong{21}}{ #11 envelope (4.5 in. by 10.375 in.)}
\item{\strong{22}}{ #12 envelope (4.75 in. by 11 in.)}
\item{\strong{23}}{ #14 envelope (5 in. by 11.5 in.)}
\item{\strong{24}}{ C paper (17 in. by 22 in.)}
\item{\strong{25}}{ D paper (22 in. by 34 in.)}
\item{\strong{26}}{ E paper (34 in. by 44 in.)}
\item{\strong{27}}{ DL envelope (110 mm by 220 mm)}
\item{\strong{28}}{ C5 envelope (162 mm by 229 mm)}
\item{\strong{29}}{ C3 envelope (324 mm by 458 mm)}
\item{\strong{30}}{ C4 envelope (229 mm by 324 mm)}
\item{\strong{31}}{ C6 envelope (114 mm by 162 mm)}
\item{\strong{32}}{ C65 envelope (114 mm by 229 mm)}
\item{\strong{33}}{ B4 envelope (250 mm by 353 mm)}
\item{\strong{34}}{ B5 envelope (176 mm by 250 mm)}
\item{\strong{35}}{ B6 envelope (176 mm by 125 mm)}
\item{\strong{36}}{ Italy envelope (110 mm by 230 mm)}
\item{\strong{37}}{ Monarch envelope (3.875 in. by 7.5 in.).}
\item{\strong{38}}{ 6 3/4 envelope (3.625 in. by 6.5 in.)}
\item{\strong{39}}{ US standard fanfold (14.875 in. by 11 in.)}
\item{\strong{40}}{ German standard fanfold (8.5 in. by 12 in.)}
\item{\strong{41}}{ German legal fanfold (8.5 in. by 13 in.)}
\item{\strong{42}}{ ISO B4 (250 mm by 353 mm)}
\item{\strong{43}}{ Japanese double postcard (200 mm by 148 mm)}
\item{\strong{44}}{ Standard paper (9 in. by 11 in.)}
\item{\strong{45}}{ Standard paper (10 in. by 11 in.)}
\item{\strong{46}}{ Standard paper (15 in. by 11 in.)}
\item{\strong{47}}{ Invite envelope (220 mm by 220 mm)}
\item{\strong{50}}{ Letter extra paper (9.275 in. by 12 in.)}
\item{\strong{51}}{ Legal extra paper (9.275 in. by 15 in.)}
\item{\strong{52}}{ Tabloid extra paper (11.69 in. by 18 in.)}
\item{\strong{53}}{ A4 extra paper (236 mm by 322 mm)}
\item{\strong{54}}{ Letter transverse paper (8.275 in. by 11 in.)}
\item{\strong{55}}{ A4 transverse paper (210 mm by 297 mm)}
\item{\strong{56}}{ Letter extra transverse paper (9.275 in. by 12 in.)}
\item{\strong{57}}{ SuperA/SuperA/A4 paper (227 mm by 356 mm)}
\item{\strong{58}}{ SuperB/SuperB/A3 paper (305 mm by 487 mm)}
\item{\strong{59}}{ Letter plus paper (8.5 in. by 12.69 in.)}
\item{\strong{60}}{ A4 plus paper (210 mm by 330 mm)}
\item{\strong{61}}{ A5 transverse paper (148 mm by 210 mm)}
\item{\strong{62}}{ JIS B5 transverse paper (182 mm by 257 mm)}
\item{\strong{63}}{ A3 extra paper (322 mm by 445 mm)}
\item{\strong{64}}{ A5 extra paper (174 mm by 235 mm)}
\item{\strong{65}}{ ISO B5 extra paper (201 mm by 276 mm)}
\item{\strong{66}}{ A2 paper (420 mm by 594 mm)}
\item{\strong{67}}{ A3 transverse paper (297 mm by 420 mm)}
\item{\strong{68}}{ A3 extra transverse paper (322 mm by 445 mm)}
}
}
\examples{
wb <- createWorkbook()
addWorksheet(wb, "S1")
addWorksheet(wb, "S2")
writeDataTable(wb, 1, x = iris[1:30, ])
writeDataTable(wb, 2, x = iris[1:30, ], xy = c("C", 5))

## landscape page scaled to 50\%
pageSetup(wb, sheet = 1, orientation = "landscape", scale = 50)

## portrait page scales to 300\% with 0.5in left and right margins
pageSetup(wb, sheet = 2, orientation = "portrait", scale = 300, left = 0.5, right = 0.5)


## print titles
addWorksheet(wb, "print_title_rows")
addWorksheet(wb, "print_title_cols")

writeData(wb, "print_title_rows", rbind(iris, iris, iris, iris))
writeData(wb, "print_title_cols", x = rbind(mtcars, mtcars, mtcars), rowNames = TRUE)

pageSetup(wb, sheet = "print_title_rows", printTitleRows = 1) ## first row
pageSetup(wb, sheet = "print_title_cols", printTitleCols = 1, printTitleRows = 1)
\dontrun{
saveWorkbook(wb, "pageSetupExample.xlsx", overwrite = TRUE)
}
}
\author{
Alexander Walker, Joshua Sturm
}
