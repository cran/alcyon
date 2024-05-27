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
shapeGraph <- as(lineStringMap, "AxialShapeGraph")

## -----------------------------------------------------------------------------
axMap <- as(shapeGraph, "sf")
plot(axMap[, "Connectivity"])

## -----------------------------------------------------------------------------
axialResult <- allToAllTraverse(
  shapeGraph,
  traversalType = TraversalType$Topological,
  radii = c("n", "3"),
  includeBetweenness = TRUE
)
axMap <- as(shapeGraph, "sf")
plot(axMap[, "Choice [Norm] R3"])
for (column in axialResult$newAttributes) {
  
}

## -----------------------------------------------------------------------------
depthResult <- oneToAllTraverse(
  shapeGraph,
  traversalType = TraversalType$Topological,
  fromX = 0982.8,
  fromY = -1620.3,
)

axMap <- as(shapeGraph, "sf")
for (column in depthResult$newAttributes) {
  plot(axMap[, column])
}

