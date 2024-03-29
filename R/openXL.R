#' @name openXL
#' @title Open a Microsoft Excel file (xls/xlsx) or an openxlsx Workbook
#' @author Luca Braglia
#' @description This function tries to open a Microsoft Excel
#' (xls/xlsx) file or an openxlsx Workbook with the proper
#' application, in a portable manner.
#'
#' In Windows (c) and Mac (c), it uses system default handlers,
#' given the file type.
#'
#' In Linux it searches (via `which`) for available xls/xlsx
#' reader applications (unless `options('openxlsx.excelApp')`
#' is set to the app bin path), and if it finds anything, sets
#' `options('openxlsx.excelApp')` to the program choosen by
#' the user via a menu (if many are present, otherwise it will
#' set the only available). Currently searched for apps are
#' Libreoffice/Openoffice (`soffice` bin), Gnumeric
#' (`gnumeric`) and Calligra Sheets (`calligrasheets`).
#'
#' @param file path to the Excel (xls/xlsx) file or Workbook object.
#' @usage openXL(file=NULL)
#' @export openXL
#' @examples
#' # file example
#' example(writeData)
#' # openXL("writeDataExample.xlsx")
#'
#' # (not yet saved) Workbook example
#' wb <- createWorkbook()
#' x <- mtcars[1:6, ]
#' addWorksheet(wb, "Cars")
#' writeData(wb, "Cars", x, startCol = 2, startRow = 3, rowNames = TRUE)
#' # openXL(wb)
openXL <- function(file = NULL) {
  op <- get_set_options()
  on.exit(options(op), add = TRUE)

  if (is.null(file)) stop("A file has to be specified.")

  ## workbook handling
  if ("Workbook" %in% class(file)) {
    file <- file$saveWorkbook()
  }

  if (!file.exists(file)) stop("Non existent file or wrong path.")

  ## execution should be in background in order to not block R
  ## interpreter
  file <- normalizePath(file)
  userSystem <- Sys.info()["sysname"]


  if ("Linux" == userSystem) {
    if (is.null(app <- unlist(options("openxlsx.excelApp")))) {
      app <- chooseExcelApp()
    }
    myCommand <- paste(app, file, "&", sep = " ")
    system(command = myCommand)
  } else if ("Windows" == userSystem) {
    shell(shQuote(string = file), wait = FALSE) #nolint
  } else if ("Darwin" == userSystem) {
    myCommand <- paste0("open ", file)
    system(command = myCommand)
  } else {
    warning("Operating system not handled.")
  }
}


chooseExcelApp <- function() {
  m <- c(
    `Libreoffice/OpenOffice` = "soffice",
    `Calligra Sheets` = "calligrasheets",
    `Gnumeric` = "gnumeric"
  )

  prog <- Sys.which(m)
  names(prog) <- names(m)
  nApps <- length(availProg <- prog["" != prog])

  if (0 == nApps) {
    stop(
      "No applications (detected) available.\n",
      "Set options('openxlsx.excelApp'), instead."
    )
  } else if (1 == nApps) {
    cat("Only", names(availProg), "found; I'll use it.\n")
    unnprog <- unname(availProg)
    options(openxlsx.excelApp = unnprog)
    invisible(unnprog)
  } else if (1 < nApps) {
    if (!interactive()) {
      stop(
        "Cannot choose an Excel file opener non-interactively.\n",
        "Set options('openxlsx.excelApp'), instead."
      )
    }
    res <- menu(names(availProg), title = "Excel Apps availables")
    unnprog <- unname(availProg[res])
    if (res > 0L) options(openxlsx.excelApp = unnprog)
    invisible(unname(unnprog))
  } else {
    stop("Unexpected error.")
  }
}
