## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(alcyon)

galleryMap <- st_read(
  system.file(
    "extdata", "testdata", "gallery",
    "gallery_lines.mif",
    package = "alcyon"
  ),
  geometry_column = 1L, quiet = TRUE
)

## -----------------------------------------------------------------------------
pointMap <- makeVGAPointMap(
  galleryMap,
  fillX = 3.01,
  fillY = 6.7,
  gridSize = 0.06
)
plot(pointMap["Connectivity"])

## -----------------------------------------------------------------------------
linkedPointMap = linkCoords(pointMap, 1.74, 6.7, 5.05, 5.24)

## -----------------------------------------------------------------------------
vgaMap <- allToAllTraverse(
  pointMap,
  traversalType = TraversalType$Metric,
  radii = -1,
  radiusTraversalType = TraversalType$None
)
plot(vgaMap["Metric Mean Shortest-Path Angle"])

## -----------------------------------------------------------------------------
vgaMap <- allToAllTraverse(
  vgaMap,
  traversalType = TraversalType$Angular,
  radii = -1,
  radiusTraversalType = TraversalType$None
)

plot(vgaMap["Angular Mean Depth"])

## -----------------------------------------------------------------------------
vgaMap <- allToAllTraverse(
  vgaMap,
  traversalType = TraversalType$Topological,
  radii = -1,
  radiusTraversalType = TraversalType$None
)
plot(vgaMap["Visual Integration [HH]"])

## -----------------------------------------------------------------------------
vgaMap <- vgaThroughVision(vgaMap)
plot(vgaMap["Through vision"])

## -----------------------------------------------------------------------------
vgaMap <- vgaVisualLocal(vgaMap, FALSE)
plot(vgaMap["Visual Control"])

## -----------------------------------------------------------------------------
boundaryMap <- as(galleryMap[, vector()], "ShapeMap")
vgaMap <- vgaIsovist(vgaMap, boundaryMap)
plot(vgaMap["Isovist Area"])

## -----------------------------------------------------------------------------
vgaMap <- oneToAllTraverse(
  vgaMap,
  traversalType = TraversalType$Metric,
  fromX = 3.01,
  fromY = 6.7
)
plot(vgaMap["Metric Step Shortest-Path Angle"])

## -----------------------------------------------------------------------------
vgaMap <- oneToAllTraverse(
  vgaMap,
  traversalType = TraversalType$Angular,
  fromX = 3.01,
  fromY = 6.7
)
plot(vgaMap["Angular Step Depth"])

## -----------------------------------------------------------------------------
vgaMap <- oneToAllTraverse(
  vgaMap,
  traversalType = TraversalType$Topological,
  fromX = 3.01,
  fromY = 6.7
)
plot(vgaMap["Visual Step Depth"])

