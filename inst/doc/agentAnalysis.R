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
agentAnalysis = agentAnalysis(pointMap,
                              timesteps = 10000,
                              releaseRate = 0.1,
                              agentLifeTimesteps = 1000,
                              agentFov = 16,
                              agentStepsToDecision = 3,
                              agentLookMode = AgentLookMode$Standard)
plot(agentAnalysis$pointMap["Gate Counts"])

## -----------------------------------------------------------------------------
agentAnalysis = agentAnalysis(pointMap,
                              timesteps = 10000,
                              releaseRate = 0.1,
                              agentLifeTimesteps = 1000,
                              agentFov = 16,
                              agentStepsToDecision = 3,
                              agentLookMode = AgentLookMode$Standard,
                              numberOfTrails = 50)
plot(agentAnalysis$trailMap)

