% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/isovist.R
\name{isovist}
\alias{isovist}
\title{Create isovists at point and direction angle}
\usage{
isovist(boundaryMap, x, y, angle = NA, viewAngle = NA, verbose = FALSE)
}
\arguments{
\item{boundaryMap}{A ShapeMap with lines designating the isovist boundaries}

\item{x}{X coordinate of the origin points}

\item{y}{Y coordinate of the origin points}

\item{angle}{The angle (from the X axis) of the isovist look direction}

\item{viewAngle}{The angle signifying the isovist's field of view}

\item{verbose}{Optional. Show more information of the process.}
}
\value{
A ShapeMap with the isovist polygons
}
\description{
Create one or more isovists at particular points, given angle and field of
view
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
isovist(
  shapeMap,
  x = c(3.01, 1.3),
  y = c(6.70, 5.2),
  angle = 0.01,
  viewAngle = 3.14,
  FALSE
)
}
