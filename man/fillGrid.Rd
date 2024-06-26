% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepareVGA.R
\name{fillGrid}
\alias{fillGrid}
\title{Fill a PointMap's grid starting from one or more points}
\usage{
fillGrid(pointMap, fillX, fillY, copyMap = TRUE, verbose = FALSE)
}
\arguments{
\item{pointMap}{The input PointMap}

\item{fillX}{X coordinate of the fill points}

\item{fillY}{Y coordinate of the fill points}

\item{copyMap}{Optional. Copy the internal sala map}

\item{verbose}{Optional. Show more information of the process.}
}
\value{
A new PointMap with filled points
}
\description{
Fill a PointMap's grid starting from one or more points
}
\examples{
mifFile <- system.file(
    "extdata", "testdata", "simple",
    "simple_interior.mif",
    package = "alcyon"
  )
  sfMap <- st_read(mifFile,
    geometry_column = 1L, quiet = TRUE
  )
  shapeMap <- as(sfMap[, vector()], "ShapeMap")
lineStringMap <- as(sfMap, "sf")
mapRegion <- sf::st_bbox(lineStringMap)
pointMap <- createGrid(
  minX = mapRegion[["xmin"]],
  minY = mapRegion[["ymin"]],
  maxX = mapRegion[["xmax"]],
  maxY = mapRegion[["ymax"]],
  gridSize = 0.04
)
pointMap <- blockLines(
  pointMap = pointMap,
  lineStringMap = lineStringMap[vector()]
)
fillGrid(
  pointMap = pointMap,
  fillX = 3.01,
  fillY = 6.7
)
}
