
# Workbook ----------------------------------------------------------------

Workbook <- setRefClass("Workbook",
  fields = c(
    "sheet_names" = "character",

    "charts" = "ANY",
    "isChartSheet" = "logical",

    "colOutlineLevels" = "ANY",
    "colWidths" = "ANY",
    "connections" = "ANY",
    "Content_Types" = "character",
    "core" = "character",
    "drawings" = "ANY",
    "drawings_rels" = "ANY",
    "embeddings" = "ANY",
    "externalLinks" = "ANY",
    "externalLinksRels" = "ANY",

    "headFoot" = "ANY",
    "media" = "ANY",
    "outlineLevels" = "ANY",
    
    "persons" = "ANY",

    "pivotTables" = "ANY",
    "pivotTables.xml.rels" = "ANY",
    "pivotDefinitions" = "ANY",
    "pivotRecords" = "ANY",
    "pivotDefinitionsRels" = "ANY",

    "queryTables" = "ANY",
    "rowHeights" = "ANY",

    "slicers" = "ANY",
    "slicerCaches" = "ANY",

    "sharedStrings" = "ANY",
    "styleObjects" = "ANY",

    "styles" = "ANY",
    "tables" = "ANY",
    "tables.xml.rels" = "ANY",
    "theme" = "ANY",

    "vbaProject" = "ANY",
    "vml" = "ANY",
    "vml_rels" = "ANY",
    "comments" = "ANY",
    "threadComments" = "ANY",

    "workbook" = "ANY",
    "workbook.xml.rels" = "ANY",
    "worksheets" = "ANY",
    "worksheets_rels" = "ANY",
    "sheetOrder" = "integer",
    "ActiveSheet" = "integer"
  )
)

# Style -------------------------------------------------------------------

Style <- setRefClass("Style",
  fields = c(
    "fontName",
    "fontColour",
    "fontSize",
    "fontFamily",
    "fontScheme",
    "fontDecoration",
    "borderTop",
    "borderLeft",
    "borderRight",
    "borderBottom",
    "borderTopColour",
    "borderLeftColour",
    "borderRightColour",
    "borderBottomColour",
    "borderDiagonal",
    "borderDiagonalColour",
    "borderDiagonalUp",
    "borderDiagonalDown",
    "halign",
    "valign",
    "indent",
    "textRotation",
    "numFmt",
    "fill",
    "wrapText",
    "locked",
    "hidden",
    "xfId"
  ),
  methods = list()
)

# Sheet_Data --------------------------------------------------------------

Sheet_Data <- setRefClass("Sheet_Data",
  fields = c(
    "rows" = "integer",
    "cols" = "integer",
    "t" = "integer",
    "v" = "character",
    "f" = "character",
    "style_id" = "ANY",
    "data_count" = "integer",
    "n_elements" = "integer"
  )
)


# Worksheet ---------------------------------------------------------------

WorkSheet <- setRefClass("WorkSheet",
  fields = c(
    "sheetPr" = "character",
    "dimension" = "character",
    "sheetViews" = "character",
    "sheetFormatPr" = "character",
    "cols" = "character",

    "sheet_data" = "Sheet_Data",

    "autoFilter" = "character",
    "mergeCells" = "ANY",
    "conditionalFormatting" = "character",
    "dataValidations" = "ANY",
    "dataValidationsLst" = "character",

    "freezePane" = "character",
    "hyperlinks" = "ANY",

    "sheetProtection" = "character",
    "pageMargins" = "character",
    "pageSetup" = "character",
    "headerFooter" = "ANY",
    "rowBreaks" = "character",
    "colBreaks" = "character",
    "drawing" = "character",
    "legacyDrawing" = "character",
    "legacyDrawingHF" = "character",
    "oleObjects" = "character",
    "tableParts" = "character",
    "extLst" = "character"
  )
)

# ChartSheet --------------------------------------------------------------

ChartSheet <- setRefClass("ChartSheet",
  fields = c(
    "sheetPr" = "character",
    "sheetViews" = "character",
    "pageMargins" = "character",
    "drawing" = "character",
    "hyperlinks" = "ANY"
  )
)
