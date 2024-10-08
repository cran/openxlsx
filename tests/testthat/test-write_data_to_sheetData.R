


context("Converting R types to Excel types")



test_that("Converting R types to Excel types", {
  wb <- createWorkbook()
  addWorksheet(wb, "S1")
  addWorksheet(wb, "S2")
  addWorksheet(wb, "S3")

  writeDataTable(wb, "S1", x = iris)

  n_values <- prod(dim(iris)) + ncol(iris)

  sheet_data <- wb$worksheets[[1]]$sheet_data

  sheet_v <- sheet_data$v
  sheet_t <- sheet_data$t
  sheet_f <- sheet_data$f
  sheet_row <- sheet_data$rows
  sheet_col <- sheet_data$cols

  sheet_v <- as.numeric(sheet_v)

  expect_length(sheet_row, n_values)
  expect_length(sheet_col, n_values)
  expect_length(sheet_t, n_values)
  expect_length(sheet_v, n_values)
  expect_length(sheet_f, n_values)


  ## rows/cols
  expect_equal(sheet_row, rep(1:151, each = 5))
  expect_equal(sheet_col, rep(1:5, times = 151))

  ## header types
  expect_equal(sheet_t[1:5], rep(1, 5))

  ## data.frame t & v
  expect_equal(sheet_t[6:n_values], rep(c(0, 0, 0, 0, 1), 150))
  expect_equal(sheet_v[1:5], 0:4)

  expected_v <- c(
    5.1, 3.5, 1.4, 0.2, 5, 4.9, 3, 1.4, 0.2, 5, 4.7, 3.2, 1.3,
    0.2, 5, 4.6, 3.1, 1.5, 0.2, 5, 5, 3.6, 1.4, 0.2, 5, 5.4, 3.9,
    1.7, 0.4, 5, 4.6, 3.4, 1.4, 0.3, 5, 5, 3.4, 1.5, 0.2, 5, 4.4,
    2.9, 1.4, 0.2, 5, 4.9, 3.1, 1.5, 0.1, 5, 5.4, 3.7, 1.5, 0.2,
    5, 4.8, 3.4, 1.6, 0.2, 5, 4.8, 3, 1.4, 0.1, 5, 4.3, 3, 1.1, 0.1,
    5, 5.8, 4, 1.2, 0.2, 5, 5.7, 4.4, 1.5, 0.4, 5, 5.4, 3.9, 1.3,
    0.4, 5, 5.1, 3.5, 1.4, 0.3, 5, 5.7, 3.8, 1.7, 0.3, 5, 5.1, 3.8,
    1.5, 0.3, 5, 5.4, 3.4, 1.7, 0.2, 5, 5.1, 3.7, 1.5, 0.4, 5, 4.6,
    3.6, 1, 0.2, 5, 5.1, 3.3, 1.7, 0.5, 5, 4.8, 3.4, 1.9, 0.2, 5,
    5, 3, 1.6, 0.2, 5, 5, 3.4, 1.6, 0.4, 5, 5.2, 3.5, 1.5, 0.2, 5,
    5.2, 3.4, 1.4, 0.2, 5, 4.7, 3.2, 1.6, 0.2, 5, 4.8, 3.1, 1.6,
    0.2, 5, 5.4, 3.4, 1.5, 0.4, 5, 5.2, 4.1, 1.5, 0.1, 5, 5.5, 4.2,
    1.4, 0.2, 5, 4.9, 3.1, 1.5, 0.2, 5, 5, 3.2, 1.2, 0.2, 5, 5.5,
    3.5, 1.3, 0.2, 5, 4.9, 3.6, 1.4, 0.1, 5, 4.4, 3, 1.3, 0.2, 5,
    5.1, 3.4, 1.5, 0.2, 5, 5, 3.5, 1.3, 0.3, 5, 4.5, 2.3, 1.3, 0.3,
    5, 4.4, 3.2, 1.3, 0.2, 5, 5, 3.5, 1.6, 0.6, 5, 5.1, 3.8, 1.9,
    0.4, 5, 4.8, 3, 1.4, 0.3, 5, 5.1, 3.8, 1.6, 0.2, 5, 4.6, 3.2,
    1.4, 0.2, 5, 5.3, 3.7, 1.5, 0.2, 5, 5, 3.3, 1.4, 0.2, 5, 7, 3.2,
    4.7, 1.4, 6, 6.4, 3.2, 4.5, 1.5, 6, 6.9, 3.1, 4.9, 1.5, 6, 5.5,
    2.3, 4, 1.3, 6, 6.5, 2.8, 4.6, 1.5, 6, 5.7, 2.8, 4.5, 1.3, 6,
    6.3, 3.3, 4.7, 1.6, 6, 4.9, 2.4, 3.3, 1, 6, 6.6, 2.9, 4.6, 1.3,
    6, 5.2, 2.7, 3.9, 1.4, 6, 5, 2, 3.5, 1, 6, 5.9, 3, 4.2, 1.5,
    6, 6, 2.2, 4, 1, 6, 6.1, 2.9, 4.7, 1.4, 6, 5.6, 2.9, 3.6, 1.3,
    6, 6.7, 3.1, 4.4, 1.4, 6, 5.6, 3, 4.5, 1.5, 6, 5.8, 2.7, 4.1,
    1, 6, 6.2, 2.2, 4.5, 1.5, 6, 5.6, 2.5, 3.9, 1.1, 6, 5.9, 3.2,
    4.8, 1.8, 6, 6.1, 2.8, 4, 1.3, 6, 6.3, 2.5, 4.9, 1.5, 6, 6.1,
    2.8, 4.7, 1.2, 6, 6.4, 2.9, 4.3, 1.3, 6, 6.6, 3, 4.4, 1.4, 6,
    6.8, 2.8, 4.8, 1.4, 6, 6.7, 3, 5, 1.7, 6, 6, 2.9, 4.5, 1.5, 6,
    5.7, 2.6, 3.5, 1, 6, 5.5, 2.4, 3.8, 1.1, 6, 5.5, 2.4, 3.7, 1,
    6, 5.8, 2.7, 3.9, 1.2, 6, 6, 2.7, 5.1, 1.6, 6, 5.4, 3, 4.5, 1.5,
    6, 6, 3.4, 4.5, 1.6, 6, 6.7, 3.1, 4.7, 1.5, 6, 6.3, 2.3, 4.4,
    1.3, 6, 5.6, 3, 4.1, 1.3, 6, 5.5, 2.5, 4, 1.3, 6, 5.5, 2.6, 4.4,
    1.2, 6, 6.1, 3, 4.6, 1.4, 6, 5.8, 2.6, 4, 1.2, 6, 5, 2.3, 3.3,
    1, 6, 5.6, 2.7, 4.2, 1.3, 6, 5.7, 3, 4.2, 1.2, 6, 5.7, 2.9, 4.2,
    1.3, 6, 6.2, 2.9, 4.3, 1.3, 6, 5.1, 2.5, 3, 1.1, 6, 5.7, 2.8,
    4.1, 1.3, 6, 6.3, 3.3, 6, 2.5, 7, 5.8, 2.7, 5.1, 1.9, 7, 7.1,
    3, 5.9, 2.1, 7, 6.3, 2.9, 5.6, 1.8, 7, 6.5, 3, 5.8, 2.2, 7, 7.6,
    3, 6.6, 2.1, 7, 4.9, 2.5, 4.5, 1.7, 7, 7.3, 2.9, 6.3, 1.8, 7,
    6.7, 2.5, 5.8, 1.8, 7, 7.2, 3.6, 6.1, 2.5, 7, 6.5, 3.2, 5.1,
    2, 7, 6.4, 2.7, 5.3, 1.9, 7, 6.8, 3, 5.5, 2.1, 7, 5.7, 2.5, 5,
    2, 7, 5.8, 2.8, 5.1, 2.4, 7, 6.4, 3.2, 5.3, 2.3, 7, 6.5, 3, 5.5,
    1.8, 7, 7.7, 3.8, 6.7, 2.2, 7, 7.7, 2.6, 6.9, 2.3, 7, 6, 2.2,
    5, 1.5, 7, 6.9, 3.2, 5.7, 2.3, 7, 5.6, 2.8, 4.9, 2, 7, 7.7, 2.8,
    6.7, 2, 7, 6.3, 2.7, 4.9, 1.8, 7, 6.7, 3.3, 5.7, 2.1, 7, 7.2,
    3.2, 6, 1.8, 7, 6.2, 2.8, 4.8, 1.8, 7, 6.1, 3, 4.9, 1.8, 7, 6.4,
    2.8, 5.6, 2.1, 7, 7.2, 3, 5.8, 1.6, 7, 7.4, 2.8, 6.1, 1.9, 7,
    7.9, 3.8, 6.4, 2, 7, 6.4, 2.8, 5.6, 2.2, 7, 6.3, 2.8, 5.1, 1.5,
    7, 6.1, 2.6, 5.6, 1.4, 7, 7.7, 3, 6.1, 2.3, 7, 6.3, 3.4, 5.6,
    2.4, 7, 6.4, 3.1, 5.5, 1.8, 7, 6, 3, 4.8, 1.8, 7, 6.9, 3.1, 5.4,
    2.1, 7, 6.7, 3.1, 5.6, 2.4, 7, 6.9, 3.1, 5.1, 2.3, 7, 5.8, 2.7,
    5.1, 1.9, 7, 6.8, 3.2, 5.9, 2.3, 7, 6.7, 3.3, 5.7, 2.5, 7, 6.7,
    3, 5.2, 2.3, 7, 6.3, 2.5, 5, 1.9, 7, 6.5, 3, 5.2, 2, 7, 6.2,
    3.4, 5.4, 2.3, 7, 5.9, 3, 5.1, 1.8, 7
  )

  expect_equal(sheet_v[6:n_values], expected_v)



  ############################ SPECIAL DATA TYPES

  df <- data.frame(
    "Date" = as.Date("2016-12-5") - 0:19,
    "T" = TRUE,
    "F" = FALSE,
    "Time" = as.POSIXct("2016-12-05 20:31:12 AEDT") - 0:19 * 60 * 60,
    "Cash" = paste("$", 1:20),
    "Cash2" = 31:50,
    "hLink" = "https://CRAN.R-project.org/",
    "Percentage" = seq(0, 1, length.out = 20),
    "TinyNumbers" = 1:20 / 1E9, stringsAsFactors = FALSE
  )

  ## openxlsx will apply default Excel styling for these classes
  class(df$Cash) <- "currency"
  class(df$Cash2) <- "accounting"
  class(df$hLink) <- "hyperlink"
  class(df$Percentage) <- "percentage"
  class(df$TinyNumbers) <- "scientific"

  writeDataTable(wb, "S3", x = df, startRow = 4, rowNames = TRUE, tableStyle = "TableStyleMedium9")




  ## Get all data
  sheet_data <- wb$worksheets[[3]]$sheet_data
  n_values <- (nrow(df) + 1) * (ncol(df) + 1)
  sheet_v <- sheet_data$v
  sheet_t <- sheet_data$t
  sheet_f <- sheet_data$f
  sheet_row <- sheet_data$rows
  sheet_col <- sheet_data$cols

  sheet_v <- as.numeric(sheet_v)


  expect_length(sheet_row, n_values)
  expect_length(sheet_t, n_values)

  ## rows/cols
  expect_equal(sheet_row, rep(4:24, each = ncol(df) + 1L))
  expect_equal(sheet_col, rep(1:10, times = nrow(df) + 1L))

  ## header types
  expect_equal(sheet_t[1:(ncol(df) + 1)], rep(1, ncol(df) + 1))

  ## data.frame t & v
  expect_equal(sheet_t[(ncol(df) + 2):n_values], rep(c(1, 0, 2, 2, 0, 0, 0, 1, 0, 0), 20))
  expect_equal(sheet_v[1:(ncol(df) + 1)], 8:17)


  expected_v <- c(
    18, 42709, 1, 0, 42709.86, 1, 31, 19, 0, 0.000000001, 20, 42708,
    1, 0, 42709.81, 2, 32, 19, 0.05263158, 0.000000002, 21, 42707,
    1, 0, 42709.77, 3, 33, 19, 0.10526316, 0.000000003, 22, 42706,
    1, 0, 42709.73, 4, 34, 19, 0.15789474, 0.000000004, 23, 42705,
    1, 0, 42709.69, 5, 35, 19, 0.21052632, 0.000000005, 24, 42704,
    1, 0, 42709.65, 6, 36, 19, 0.26315789, 0.000000006, 25, 42703,
    1, 0, 42709.61, 7, 37, 19, 0.31578947, 0.000000007, 26, 42702,
    1, 0, 42709.56, 8, 38, 19, 0.36842105, 0.000000008, 27, 42701,
    1, 0, 42709.52, 9, 39, 19, 0.42105263, 0.000000009, 28, 42700,
    1, 0, 42709.48, 10, 40, 19, 0.47368421, 0.00000001, 29, 42699,
    1, 0, 42709.44, 11, 41, 19, 0.52631579, 0.000000011, 30, 42698,
    1, 0, 42709.4, 12, 42, 19, 0.57894737, 0.000000012, 31, 42697,
    1, 0, 42709.36, 13, 43, 19, 0.63157895, 0.000000013, 32, 42696,
    1, 0, 42709.31, 14, 44, 19, 0.68421053, 0.000000014, 33, 42695,
    1, 0, 42709.27, 15, 45, 19, 0.73684211, 0.000000015, 34, 42694,
    1, 0, 42709.23, 16, 46, 19, 0.78947368, 0.000000016, 35, 42693,
    1, 0, 42709.19, 17, 47, 19, 0.84210526, 0.000000017, 36, 42692,
    1, 0, 42709.15, 18, 48, 19, 0.89473684, 0.000000018, 37, 42691,
    1, 0, 42709.11, 19, 49, 19, 0.94736842, 0.000000019, 38, 42690,
    1, 0, 42709.06, 20, 50, 19, 1, 0.00000002
  )


  # expect_equal(sheet_v[(ncol(df)+2):n_values], expected_v)
})




test_that("Write zero rows & columns", {
  tempFile <- temp_xlsx()
  wb <- createWorkbook()
  addWorksheet(wb, "s1")
  addWorksheet(wb, "s2")

  ## ZERO ROWS

  ## headers only
  writeData(wb, sheet = 1, x = mtcars[0, ], colNames = TRUE, rowNames = FALSE)

  ## no headers
  writeData(wb, sheet = 1, x = mtcars[0, ], colNames = FALSE, rowNames = FALSE, startRow = 5)

  ## row names
  writeData(wb, sheet = 1, x = mtcars[0, ], colNames = TRUE, rowNames = TRUE, startRow = 10)

  ## row names only
  writeData(wb, sheet = 1, x = mtcars[0, ], colNames = FALSE, rowNames = TRUE, startRow = 15)


  ## ZERO COLS
  ## headers only
  writeData(wb, sheet = 2, x = mtcars[, 0], colNames = TRUE, rowNames = FALSE)

  ## no headers
  writeData(wb, sheet = 2, x = mtcars[, 0], colNames = FALSE, rowNames = FALSE, startRow = 5)

  ## row names
  writeData(wb, sheet = 2, x = mtcars[, 0], colNames = TRUE, rowNames = TRUE, startRow = 10)

  ## row names only
  writeData(wb, sheet = 2, x = mtcars[, 0], colNames = FALSE, rowNames = TRUE, startRow = 15)

  saveWorkbook(wb, tempFile, overwrite = TRUE)
  unlink(tempFile)
})




test_that("too much data", {
            wb <- createWorkbook()
            addWorksheet(wb, "test1")
            addWorksheet(wb, "test2")
            df1 <-
              data.frame(Col1 = paste(rep(1, 32768 + 100), collapse = ""))
            df2 <-
              data.frame(Col1 = paste(rep(1, 32768), collapse = ""))
            expect_warning(
              writeData(wb, 1, df1),
              "1 is truncated. 
Number of characters exeed the limit of 32767."
            )
            expect_warning(
              writeData(wb, 2, df2),
              "1 is truncated. 
Number of characters exeed the limit of 32767."
            )
          })

# example from gh issue #200
test_that("write hyperlinks", {
  
  tmp <- openxlsx:::temp_xlsx()
  tmp_dir <- tempdir()
  
  
  # create data
  channels <- data.frame(
    channel = c("ABC", "BBC", "CBC"),
    homepage = c("https://www.abc.net.au/",
                 "https://www.bbc.com/",
                 "https://www.cbc.ca/"),
    stringsAsFactors = FALSE
  )
  
  channels$formula <- paste0('=HYPERLINK("',
                             channels$homepage,
                             '","',
                             channels$channel,
                             '")')
  
  
  # create xlsx
  wb <- createWorkbook()
  addWorksheet(wb, "channels")
  writeDataTable(wb, "channels", channels, tableName = "channels")
  writeFormula(wb, "channels", channels$formula, startRow = 2, startCol = 1)
  freezePane(wb, "channels", firstRow = TRUE)
  setColWidths(wb, "channels", cols = seq_along(channels), widths = "auto")
  saveWorkbook(wb, file = tmp, overwrite = TRUE)
  
  # check the xls file for the correct string
  unzip(tmp, exdir = tmp_dir)
  sheet1 <- readLines(paste0(tmp_dir, "/xl/worksheets/sheet1.xml"), warn = FALSE)
  res <- sapply(replaceIllegalCharacters(channels$formula),
                FUN = function(str) grepl(str, x = sheet1, fixed = TRUE))
  
  
  expect_true(all(res))
})


test_that("write list containing NA",{
  
  data <- data.frame(i=1:3)
  data$x <- list(1, c(2, 3), c(4, NA, 5))
  
  xlsx_file <- temp_xlsx()
  wb <- createWorkbook()
  addWorksheet(wb, "Sheet1")
  writeData(wb, sheet = 1, data, sep = ";", na.string = "")
  saveWorkbook(wb, file = xlsx_file, overwrite=TRUE)
  
  res <- read.xlsx(xlsx_file)
  exp <- data.frame(i = 1:3,
                    x = c("1", "2;3", "4;;5"),
                    stringsAsFactors = FALSE)
  
  expect_equal(exp, res)
  
})
