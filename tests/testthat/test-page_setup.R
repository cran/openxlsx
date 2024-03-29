

context("Page setup")


test_that("Page setup", {
  wb <- createWorkbook()
  addWorksheet(wb, "s1")
  addWorksheet(wb, "s2")


  pageSetup(wb,
    sheet = "s1", orientation = "landscape", scale = 100, left = 0.1,
    right = 0.1, top = .75, bottom = .75, header = 0.1, footer = 0.1,
    fitToWidth = TRUE, fitToHeight = TRUE, paperSize = 1,
    summaryRow = "below", summaryCol = "right"
  )


  pageSetup(wb,
    sheet = 2, orientation = "landscape", scale = 100, left = 0.1,
    right = 0.1, top = .75, bottom = .75, header = 0.1, footer = 0.1,
    fitToWidth = TRUE, fitToHeight = TRUE, paperSize = 1,
    summaryRow = "below", summaryCol = "right"
  )

  expect_equal(wb$worksheets[[1]]$pageSetup, wb$worksheets[[2]]$pageSetup)

  v <- gsub(" ", "", wb$worksheets[[1]]$pageSetup, fixed = TRUE)
  expect_true(grepl('paperSize="1"', v))
  expect_true(grepl('orientation="landscape"', v))
  expect_true(grepl('fitToWidth="1"', v))
  expect_true(grepl('fitToHeight="1"', v))

  pr <- wb$worksheets[[1]]$sheetPr

  # SheetPr will be a character vector of length 2; the first entry will
  # be for PageSetupPr, inserted by `fitToWidth`/`fitToHeight`.
  expect_true(grepl('<outlinePr summaryBelow="1" summaryRight="1"/>', pr[2], fixed = TRUE))
})
