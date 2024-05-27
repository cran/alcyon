## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(alcyon)

lineStringMap <- st_read(
  system.file(
    "extdata", "testdata", "barnsbury", "barnsbury_small_axial_original.mif",
    package = "alcyon"
  ),
  geometry_column = 1L, quiet = TRUE
)
axialShapeGraph <- as(lineStringMap, "AxialShapeGraph")
shapeGraph <- axialToSegmentShapeGraph(
  axialShapeGraph,
  stubRemoval = 0.4
)

## -----------------------------------------------------------------------------
segMap <- as(shapeGraph, "sf")
plot(segMap[, "Connectivity"])

## -----------------------------------------------------------------------------
segmentResult <- allToAllTraverse(
  shapeGraph,
  radii = c("n", "200"),
  radiusTraversalType = TraversalType$Metric,
  traversalType = TraversalType$Angular,
  quantizationWidth = pi / 1024,
  includeBetweenness = FALSE
)
segMap <- as(shapeGraph, "sf")
plot(segMap[, "T1024 Total Depth"])

## -----------------------------------------------------------------------------
segmentResult <- allToAllTraverse(
  shapeGraph,
  radii = c("n", "100"),
  radiusTraversalType = TraversalType$Topological,
  traversalType = TraversalType$Topological,
  includeBetweenness = FALSE
)
segMap <- as(shapeGraph, "sf")
plot(segMap[, "Topological Total Length R100 metric"])

## -----------------------------------------------------------------------------
segmentResult <- allToAllTraverse(
  shapeGraph,
  radii = c("n", "200"),
  radiusTraversalType = TraversalType$Metric,
  traversalType = TraversalType$Metric,
  includeBetweenness = FALSE
)
segMap <- as(shapeGraph, "sf")
plot(segMap[, "Metric Total Length R200 metric"])

## -----------------------------------------------------------------------------
depthResult <- oneToAllTraverse(
  shapeGraph,
  traversalType = TraversalType$Topological,
  fromX = 1217.1,
  fromY = -1977.3
)

segMap <- as(shapeGraph, "sf")
for (column in depthResult$newAttributes) {
  plot(segMap[, column])
}

## -----------------------------------------------------------------------------
depthResult <- oneToAllTraverse(
  shapeGraph,
  traversalType = TraversalType$Metric,
  fromX = 1217.1,
  fromY = -1977.3
)

segMap <- as(shapeGraph, "sf")
for (column in depthResult$newAttributes) {
  plot(segMap[, column])
}

## -----------------------------------------------------------------------------
depthResult <- oneToAllTraverse(
  shapeGraph,
  traversalType = TraversalType$Angular,
  fromX = 1217.1,
  fromY = -1977.3,
  quantizationWidth = pi / 1024
)

segMap <- as(shapeGraph, "sf")
for (column in depthResult$newAttributes) {
  plot(segMap[, column])
}

