## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(alcyon)

lineStringMap <- st_read(
  system.file(
    "extdata", "testdata", "gallery",
    "gallery_lines.mif",
    package = "alcyon"
  ),
  geometry_column = 1L, quiet = TRUE
)

shapeMap <- as(lineStringMap, "ShapeMap")

## -----------------------------------------------------------------------------
isovistMap <- isovist(
  shapeMap,
  x = c(3.01),
  y = c(6.70),
  angle = 0.01,
  viewAngle = 3.14,
  FALSE
)

isovists <- shapeMapToPolygonSf(isovistMap)

## -----------------------------------------------------------------------------
plot(isovists$geometry)

