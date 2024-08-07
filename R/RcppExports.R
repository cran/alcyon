# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

Rcpp_PointMap_createFromGrid <- function(minX, minY, maxX, maxY, gridSize) {
    .Call('_alcyon_createFromGrid', PACKAGE = 'alcyon', minX, minY, maxX, maxY, gridSize)
}

Rcpp_PointMap_blockLines <- function(pointMapPtr, boundaryMapPtr, copyMapNV = NULL) {
    .Call('_alcyon_blockLines', PACKAGE = 'alcyon', pointMapPtr, boundaryMapPtr, copyMapNV)
}

Rcpp_PointMap_fill <- function(pointMapPtr, pointCoords, copyMapNV = NULL) {
    .Call('_alcyon_fill', PACKAGE = 'alcyon', pointMapPtr, pointCoords, copyMapNV)
}

Rcpp_PointMap_makeGraph <- function(pointMapPtr, boundaryGraph, maxVisibility, copyMapNV = NULL) {
    .Call('_alcyon_makeGraph', PACKAGE = 'alcyon', pointMapPtr, boundaryGraph, maxVisibility, copyMapNV)
}

Rcpp_PointMap_unmakeGraph <- function(pointMapPtr, removeLinksWhenUnmaking, copyMapNV = NULL) {
    .Call('_alcyon_unmakeGraph', PACKAGE = 'alcyon', pointMapPtr, removeLinksWhenUnmaking, copyMapNV)
}

Rcpp_PointMap_getName <- function(pointMapPtr) {
    .Call('_alcyon_pointMapGetName', PACKAGE = 'alcyon', pointMapPtr)
}

Rcpp_PointMap_getLinks <- function(pointMapPtr) {
    .Call('_alcyon_pointMapGetLinks', PACKAGE = 'alcyon', pointMapPtr)
}

Rcpp_PointMap_getConnections <- function(pointMapPtr) {
    .Call('_alcyon_pointMapGetConnections', PACKAGE = 'alcyon', pointMapPtr)
}

Rcpp_PointMap_getGridCoordinates <- function(pointMapPtr) {
    .Call('_alcyon_getGridCoordinates', PACKAGE = 'alcyon', pointMapPtr)
}

Rcpp_PointMap_getAttributeNames <- function(pointMap) {
    .Call('_alcyon_getPointMapAttributeNames', PACKAGE = 'alcyon', pointMap)
}

Rcpp_PointMap_getAttributeData <- function(pointMap, attributeNames) {
    .Call('_alcyon_getPointMapAttributeData', PACKAGE = 'alcyon', pointMap, attributeNames)
}

Rcpp_PointMap_getPropertyData <- function(pointMap, propertyNames) {
    .Call('_alcyon_getPointMapPropertyData', PACKAGE = 'alcyon', pointMap, propertyNames)
}

Rcpp_PointMap_getFilledPoints <- function(pointMapPtr) {
    .Call('_alcyon_getFilledPoints', PACKAGE = 'alcyon', pointMapPtr)
}

Rcpp_ShapeGraph_getAxialConnections <- function(shapeGraphPtr) {
    .Call('_alcyon_getAxialConnections', PACKAGE = 'alcyon', shapeGraphPtr)
}

Rcpp_ShapeGraph_getSegmentConnections <- function(shapeGraphPtr) {
    .Call('_alcyon_getSegmentConnections', PACKAGE = 'alcyon', shapeGraphPtr)
}

Rcpp_ShapeGraph_getLinksUnlinks <- function(shapeGraphPtr) {
    .Call('_alcyon_getLinksUnlinks', PACKAGE = 'alcyon', shapeGraphPtr)
}

Rcpp_ShapeMap_make <- function(name) {
    .Call('_alcyon_make', PACKAGE = 'alcyon', name)
}

Rcpp_ShapeMap_getName <- function(shapeMap) {
    .Call('_alcyon_getName', PACKAGE = 'alcyon', shapeMap)
}

Rcpp_ShapeMap_getAttributeNames <- function(shapeMap) {
    .Call('_alcyon_getShapeMapAttributeNames', PACKAGE = 'alcyon', shapeMap)
}

Rcpp_ShapeMap_getAttributeData <- function(shapeMap, attributeNames) {
    .Call('_alcyon_getShapeMapAttributeData', PACKAGE = 'alcyon', shapeMap, attributeNames)
}

Rcpp_ShapeMap_getShapesAsLineCoords <- function(shapeMap) {
    .Call('_alcyon_getShapesAsLineCoords', PACKAGE = 'alcyon', shapeMap)
}

Rcpp_ShapeMap_getShapesAsPolygonCoords <- function(shapeMap) {
    .Call('_alcyon_getShapesAsPolygonCoords', PACKAGE = 'alcyon', shapeMap)
}

Rcpp_ShapeMap_getShapesAsPolylineCoords <- function(shapeMap) {
    .Call('_alcyon_getShapesAsPolylineCoords', PACKAGE = 'alcyon', shapeMap)
}

Rcpp_ShapeMap_getShapeCoords <- function(shapeMapPtr, ref) {
    .Call('_alcyon_getShapeCoords', PACKAGE = 'alcyon', shapeMapPtr, ref)
}

Rcpp_ShapeMap_getShapeAttributes <- function(shapeMapPtr, ref) {
    .Call('_alcyon_getShapeAttributes', PACKAGE = 'alcyon', shapeMapPtr, ref)
}

Rcpp_agentAnalysis <- function(pointMapPtr, systemTimesteps, releaseRate, agentLifeTimesteps, agentFov, agentStepsToDecision, agentLookMode, agentReleaseLocations, randomReleaseLocationSeed, recordTrailForAgents, getGateCounts, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_agentAnalysis', PACKAGE = 'alcyon', pointMapPtr, systemTimesteps, releaseRate, agentLifeTimesteps, agentFov, agentStepsToDecision, agentLookMode, agentReleaseLocations, randomReleaseLocationSeed, recordTrailForAgents, getGateCounts, copyMapNV, verboseNV, progressNV)
}

Rcpp_makeAllLineMap <- function(boundsMap, seedX, seedY) {
    .Call('_alcyon_makeAllLineMap', PACKAGE = 'alcyon', boundsMap, seedX, seedY)
}

Rcpp_extractFewestLineMaps <- function(allLineMap, mapData) {
    .Call('_alcyon_extractFewestLineMaps', PACKAGE = 'alcyon', allLineMap, mapData)
}

Rcpp_runAxialAnalysis <- function(shapeGraph, radii, weightedMeasureColNameNV = NULL, includeChoiceNV = NULL, includeIntermediateMetricsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runAxialAnalysis', PACKAGE = 'alcyon', shapeGraph, radii, weightedMeasureColNameNV, includeChoiceNV, includeIntermediateMetricsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_runAxialLocalAnalysis <- function(shapeGraph, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runAxialLocalAnalysis', PACKAGE = 'alcyon', shapeGraph, copyMapNV, verboseNV, progressNV)
}

Rcpp_axialStepDepth <- function(shapeGraph, stepType, stepDepthPointsX, stepDepthPointsY, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_axialStepDepth', PACKAGE = 'alcyon', shapeGraph, stepType, stepDepthPointsX, stepDepthPointsY, copyMapNV, verboseNV, progressNV)
}

Rcpp_getSfShapeMapExpectedColName <- function(df, rColIdx) {
    .Call('_alcyon_getSfShapeMapExpectedColName', PACKAGE = 'alcyon', df, rColIdx)
}

Rcpp_getAxialToSegmentExpectedColName <- function(colName) {
    .Call('_alcyon_getAxialToSegmentExpectedColName', PACKAGE = 'alcyon', colName)
}

Rcpp_toShapeMap <- function(df, keepColumnIdxsNV = NULL) {
    .Call('_alcyon_toShapeMap', PACKAGE = 'alcyon', df, keepColumnIdxsNV)
}

Rcpp_toAxialShapeGraph <- function(shapeMap, nameNV = NULL, copydataNV = NULL) {
    .Call('_alcyon_toAxialShapeGraph', PACKAGE = 'alcyon', shapeMap, nameNV, copydataNV)
}

Rcpp_axialToSegment <- function(shapeGraph, nameNV = NULL, copydataNV = NULL, stubremovalNV = NULL) {
    .Call('_alcyon_axialToSegment', PACKAGE = 'alcyon', shapeGraph, nameNV, copydataNV, stubremovalNV)
}

Rcpp_shapeMapToSegment <- function(shapeMap, nameNV = NULL, keeporiginalNV = NULL, copydataNV = NULL, stubremovalNV = NULL) {
    .Call('_alcyon_shapeMapToSegment', PACKAGE = 'alcyon', shapeMap, nameNV, keeporiginalNV, copydataNV, stubremovalNV)
}

Rcpp_makeIsovists <- function(boundsMap, pointCoords, directionAngles, fieldOfViewAngles, simple_version) {
    .Call('_alcyon_makeIsovists', PACKAGE = 'alcyon', boundsMap, pointCoords, directionAngles, fieldOfViewAngles, simple_version)
}

Rcpp_ShapeGraph_linkCoords <- function(shapeGraphPtr, coords, copyMapNV = NULL) {
    .Call('_alcyon_shapeGraphLinkCoords', PACKAGE = 'alcyon', shapeGraphPtr, coords, copyMapNV)
}

Rcpp_ShapeGraph_linkRefs <- function(shapeGraphPtr, refs, copyMapNV = NULL) {
    .Call('_alcyon_shapeGraphLinkRefs', PACKAGE = 'alcyon', shapeGraphPtr, refs, copyMapNV)
}

Rcpp_PointMap_linkCoords <- function(pointMapPtr, coords, copyMapNV = NULL) {
    .Call('_alcyon_pointMapLinkCoords', PACKAGE = 'alcyon', pointMapPtr, coords, copyMapNV)
}

Rcpp_PointMap_linkRefs <- function(pointMapPtr, refs, copyMapNV = NULL) {
    .Call('_alcyon_pointMapLinkRefs', PACKAGE = 'alcyon', pointMapPtr, refs, copyMapNV)
}

Rcpp_ShapeGraph_unlinkCoords <- function(shapeGraphPtr, coords, copyMapNV = NULL) {
    .Call('_alcyon_shapeMapUnlinkCoords', PACKAGE = 'alcyon', shapeGraphPtr, coords, copyMapNV)
}

Rcpp_ShapeGraph_unlinkAtCrossPoint <- function(shapeGraphPtr, coords, copyMapNV = NULL) {
    .Call('_alcyon_shapeGraphUnlinkAtCrossPoint', PACKAGE = 'alcyon', shapeGraphPtr, coords, copyMapNV)
}

Rcpp_ShapeGraph_unlinkRefs <- function(shapeGraphPtr, refs, copyMapNV = NULL) {
    .Call('_alcyon_shapeMapUnlinkRefs', PACKAGE = 'alcyon', shapeGraphPtr, refs, copyMapNV)
}

Rcpp_PointMap_unlinkCoords <- function(pointMapPtr, coords, copyMapNV = NULL) {
    .Call('_alcyon_pointMapUnlinkCoords', PACKAGE = 'alcyon', pointMapPtr, coords, copyMapNV)
}

Rcpp_PointMap_unlinkRefs <- function(pointMapPtr, refs, copyMapNV = NULL) {
    .Call('_alcyon_pointMapUnlinkRefs', PACKAGE = 'alcyon', pointMapPtr, refs, copyMapNV)
}

Rcpp_MetaGraph_read <- function(fileName, verboseNV = NULL) {
    .Call('_alcyon_readMetaGraph', PACKAGE = 'alcyon', fileName, verboseNV)
}

Rcpp_runSegmentAnalysis <- function(shapeGraph, radii, radiusStepType, analysisStepType, weightedMeasureColNameNV = NULL, includeChoiceNV = NULL, tulipBinsNV = NULL, selOnlyNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runSegmentAnalysis', PACKAGE = 'alcyon', shapeGraph, radii, radiusStepType, analysisStepType, weightedMeasureColNameNV, includeChoiceNV, tulipBinsNV, selOnlyNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_segmentStepDepth <- function(shapeGraph, stepType, stepDepthPointsX, stepDepthPointsY, tulipBinsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_segmentStepDepth', PACKAGE = 'alcyon', shapeGraph, stepType, stepDepthPointsX, stepDepthPointsY, tulipBinsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_segmentShortestPath <- function(shapeGraph, stepType, origPoints, destPoints, tulipBinsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_segmentShortestPath', PACKAGE = 'alcyon', shapeGraph, stepType, origPoints, destPoints, tulipBinsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_throughVision <- function(pointMapPtr, copyMapNV = NULL) {
    .Call('_alcyon_vgaThroughVision', PACKAGE = 'alcyon', pointMapPtr, copyMapNV)
}

Rcpp_VGA_angular <- function(pointMapPtr, radius, gatesOnly, copyMapNV = NULL) {
    .Call('_alcyon_vgaAngular', PACKAGE = 'alcyon', pointMapPtr, radius, gatesOnly, copyMapNV)
}

Rcpp_VGA_metric <- function(pointMapPtr, radius, gatesOnly, copyMapNV = NULL) {
    .Call('_alcyon_vgaMetric', PACKAGE = 'alcyon', pointMapPtr, radius, gatesOnly, copyMapNV)
}

Rcpp_VGA_visualGlobal <- function(pointMapPtr, radius, gatesOnly, copyMapNV = NULL) {
    .Call('_alcyon_vgaVisualGlobal', PACKAGE = 'alcyon', pointMapPtr, radius, gatesOnly, copyMapNV)
}

Rcpp_VGA_visualLocal <- function(pointMapPtr, gatesOnly, copyMapNV = NULL) {
    .Call('_alcyon_vgaVisualLocal', PACKAGE = 'alcyon', pointMapPtr, gatesOnly, copyMapNV)
}

Rcpp_VGA_isovist <- function(pointMapPtr, shapeMapPtr, copyMapNV = NULL) {
    .Call('_alcyon_vgaIsovist', PACKAGE = 'alcyon', pointMapPtr, shapeMapPtr, copyMapNV)
}

Rcpp_VGA_visualDepth <- function(pointMapPtr, stepDepthPoints, copyMapNV = NULL) {
    .Call('_alcyon_vgaVisualDepth', PACKAGE = 'alcyon', pointMapPtr, stepDepthPoints, copyMapNV)
}

Rcpp_VGA_metricDepth <- function(pointMapPtr, stepDepthPoints, copyMapNV = NULL) {
    .Call('_alcyon_vgaMetricDepth', PACKAGE = 'alcyon', pointMapPtr, stepDepthPoints, copyMapNV)
}

Rcpp_VGA_angularDepth <- function(pointMapPtr, stepDepthPoints, copyMapNV = NULL) {
    .Call('_alcyon_vgaAngularDepth', PACKAGE = 'alcyon', pointMapPtr, stepDepthPoints, copyMapNV)
}

Rcpp_VGA_visualShortestPath <- function(pointMapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaVisualShortestPath', PACKAGE = 'alcyon', pointMapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_metricShortestPath <- function(pointMapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaMetricShortestPath', PACKAGE = 'alcyon', pointMapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_angularShortestPath <- function(pointMapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaAngularShortestPath', PACKAGE = 'alcyon', pointMapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
}

