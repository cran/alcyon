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
  gridSize = 0.04
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap["Connectivity"])

## -----------------------------------------------------------------------------
linkCoords(pointMap, 1.74, 6.7, 5.05, 5.24)

## -----------------------------------------------------------------------------
vgaResult <- allToAllTraverse(
  pointMap,
  traversalType = TraversalType$Metric,
  radii = -1,
  radiusTraversalType = TraversalType$None
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- allToAllTraverse(
  pointMap,
  traversalType = TraversalType$Angular,
  radii = -1,
  radiusTraversalType = TraversalType$None
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- allToAllTraverse(
  pointMap,
  traversalType = TraversalType$Topological,
  radii = -1,
  radiusTraversalType = TraversalType$None
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- vgaThroughVision(pointMap)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- vgaVisualLocal(pointMap, FALSE)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
boundaryMap <- as(galleryMap, "ShapeMap")
vgaResult <- vgaIsovist(pointMap, boundaryMap)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- oneToAllTraverse(
  pointMap,
  traversalType = TraversalType$Metric,
  fromX = 3.01,
  fromY = 6.7
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- oneToAllTraverse(
  pointMap,
  traversalType = TraversalType$Angular,
  fromX = 3.01,
  fromY = 6.7
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

## -----------------------------------------------------------------------------
vgaResult <- oneToAllTraverse(
  pointMap,
  traversalType = TraversalType$Topological,
  fromX = 3.01,
  fromY = 6.7
)
vgaMap <- as(pointMap, "SpatialPixelsDataFrame")
plot(vgaMap[vgaResult$newAttributes[[1]]],
     main = vgaResult$newAttributes[[1]])

