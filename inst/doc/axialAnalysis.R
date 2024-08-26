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
axMap <- as(lineStringMap, "AxialShapeGraph")

## -----------------------------------------------------------------------------
plot(axMap[, "Connectivity"])

## -----------------------------------------------------------------------------
axAnalysed <- allToAllTraverse(
    axMap,
    traversalType = TraversalType$Topological,
    radii = c("n", "3"),
    includeBetweenness = TRUE
)
plot(axAnalysed[, "Choice [Norm] R3"])

## -----------------------------------------------------------------------------
axAnalysed <- oneToAllTraverse(
    axAnalysed,
    traversalType = TraversalType$Topological,
    fromX = 0982.8,
    fromY = -1620.3,
)
plot(axAnalysed["Step Depth"])

