# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

Rcpp_agentAnalysis <- function(mapPtr, systemTimesteps, releaseRate, agentLifeTimesteps, agentFov, agentStepsToDecision, agentLookMode, agentReleaseLocations, randomReleaseLocationSeed, recordTrailForAgents, getGateCounts, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_agentAnalysis', PACKAGE = 'alcyon', mapPtr, systemTimesteps, releaseRate, agentLifeTimesteps, agentFov, agentStepsToDecision, agentLookMode, agentReleaseLocations, randomReleaseLocationSeed, recordTrailForAgents, getGateCounts, copyMapNV, verboseNV, progressNV)
}

Rcpp_makeAllLineMap <- function(boundsMap, seedX, seedY, progressNV = NULL) {
    .Call('_alcyon_makeAllLineMap', PACKAGE = 'alcyon', boundsMap, seedX, seedY, progressNV)
}

Rcpp_extractFewestLineMaps <- function(allLineMap, mapData, progressNV = NULL) {
    .Call('_alcyon_extractFewestLineMaps', PACKAGE = 'alcyon', allLineMap, mapData, progressNV)
}

Rcpp_runAxialAnalysis <- function(mapPtr, radii, weightedMeasureColNameNV = NULL, includeChoiceNV = NULL, includeIntermediateMetricsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runAxialAnalysis', PACKAGE = 'alcyon', mapPtr, radii, weightedMeasureColNameNV, includeChoiceNV, includeIntermediateMetricsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_runAxialLocalAnalysis <- function(mapPtr, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runAxialLocalAnalysis', PACKAGE = 'alcyon', mapPtr, copyMapNV, verboseNV, progressNV)
}

Rcpp_axialStepDepth <- function(mapPtr, stepType, stepDepthPointsX, stepDepthPointsY, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_axialStepDepth', PACKAGE = 'alcyon', mapPtr, stepType, stepDepthPointsX, stepDepthPointsY, copyMapNV, verboseNV, progressNV)
}

Rcpp_runSegmentAnalysis <- function(mapPtr, radii, radiusStepType, analysisStepType, weightedMeasureColNameNV = NULL, includeChoiceNV = NULL, tulipBinsNV = NULL, selOnlyNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_runSegmentAnalysis', PACKAGE = 'alcyon', mapPtr, radii, radiusStepType, analysisStepType, weightedMeasureColNameNV, includeChoiceNV, tulipBinsNV, selOnlyNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_segmentStepDepth <- function(mapPtr, stepType, stepDepthPointsX, stepDepthPointsY, tulipBinsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_segmentStepDepth', PACKAGE = 'alcyon', mapPtr, stepType, stepDepthPointsX, stepDepthPointsY, tulipBinsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_segmentShortestPath <- function(mapPtr, stepType, origPoints, destPoints, tulipBinsNV = NULL, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_segmentShortestPath', PACKAGE = 'alcyon', mapPtr, stepType, origPoints, destPoints, tulipBinsNV, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_visualDepth <- function(mapPtr, stepDepthPoints, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaVisualDepth', PACKAGE = 'alcyon', mapPtr, stepDepthPoints, copyMapNV, progressNV)
}

Rcpp_VGA_metricDepth <- function(mapPtr, stepDepthPoints, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaMetricDepth', PACKAGE = 'alcyon', mapPtr, stepDepthPoints, copyMapNV, progressNV)
}

Rcpp_VGA_angularDepth <- function(mapPtr, stepDepthPoints, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaAngularDepth', PACKAGE = 'alcyon', mapPtr, stepDepthPoints, copyMapNV, progressNV)
}

Rcpp_VGA_angular <- function(mapPtr, radius, gatesOnlyNV = NULL, nthreadsNV = NULL, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaAngular', PACKAGE = 'alcyon', mapPtr, radius, gatesOnlyNV, nthreadsNV, copyMapNV, progressNV)
}

Rcpp_VGA_metric <- function(mapPtr, radius, gatesOnlyNV = NULL, nthreadsNV = NULL, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaMetric', PACKAGE = 'alcyon', mapPtr, radius, gatesOnlyNV, nthreadsNV, copyMapNV, progressNV)
}

Rcpp_VGA_visualGlobal <- function(mapPtr, radius, gatesOnlyNV = NULL, nthreadsNV = NULL, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaVisualGlobal', PACKAGE = 'alcyon', mapPtr, radius, gatesOnlyNV, nthreadsNV, copyMapNV, progressNV)
}

Rcpp_VGA_isovist <- function(mapPtr, shapeMapPtr, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaIsovist', PACKAGE = 'alcyon', mapPtr, shapeMapPtr, copyMapNV, progressNV)
}

Rcpp_VGA_visualLocal <- function(mapPtr, gatesOnlyNV = NULL, nthreadsNV = NULL, algorithmNV = NULL, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaVisualLocal', PACKAGE = 'alcyon', mapPtr, gatesOnlyNV, nthreadsNV, algorithmNV, copyMapNV, progressNV)
}

Rcpp_VGA_throughVision <- function(mapPtr, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaThroughVision', PACKAGE = 'alcyon', mapPtr, copyMapNV, progressNV)
}

Rcpp_VGA_visualShortestPath <- function(mapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaVisualShortestPath', PACKAGE = 'alcyon', mapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_metricShortestPath <- function(mapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaMetricShortestPath', PACKAGE = 'alcyon', mapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
}

Rcpp_VGA_angularShortestPath <- function(mapPtr, origPoints, destPoints, copyMapNV = NULL, verboseNV = NULL, progressNV = NULL) {
    .Call('_alcyon_vgaAngularShortestPath', PACKAGE = 'alcyon', mapPtr, origPoints, destPoints, copyMapNV, verboseNV, progressNV)
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

Rcpp_toAxialShapeGraph <- function(shapeMap, nameNV = NULL, copydataNV = NULL, progressNV = NULL) {
    .Call('_alcyon_toAxialShapeGraph', PACKAGE = 'alcyon', shapeMap, nameNV, copydataNV, progressNV)
}

Rcpp_axialToSegment <- function(shapeGraph, nameNV = NULL, copydataNV = NULL, stubremovalNV = NULL, progressNV = NULL) {
    .Call('_alcyon_axialToSegment', PACKAGE = 'alcyon', shapeGraph, nameNV, copydataNV, stubremovalNV, progressNV)
}

Rcpp_shapeMapToSegment <- function(shapeMap, nameNV = NULL, copydataNV = NULL, progressNV = NULL) {
    .Call('_alcyon_shapeMapToSegment', PACKAGE = 'alcyon', shapeMap, nameNV, copydataNV, progressNV)
}

Rcpp_makeIsovists <- function(boundsMap, pointCoords, directionAngles, fieldOfViewAngles, progressNV = NULL) {
    .Call('_alcyon_makeIsovists', PACKAGE = 'alcyon', boundsMap, pointCoords, directionAngles, fieldOfViewAngles, progressNV)
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

Rcpp_PointMap_createFromGrid <- function(minX, minY, maxX, maxY, gridSize) {
    .Call('_alcyon_createFromGrid', PACKAGE = 'alcyon', minX, minY, maxX, maxY, gridSize)
}

Rcpp_PointMap_blockLines <- function(pointMapPtr, boundaryMapPtr, copyMapNV = NULL) {
    .Call('_alcyon_blockLines', PACKAGE = 'alcyon', pointMapPtr, boundaryMapPtr, copyMapNV)
}

Rcpp_PointMap_fill <- function(pointMapPtr, pointCoords, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_fill', PACKAGE = 'alcyon', pointMapPtr, pointCoords, copyMapNV, progressNV)
}

Rcpp_PointMap_makeGraph <- function(pointMapPtr, boundaryGraph, maxVisibility, copyMapNV = NULL, progressNV = NULL) {
    .Call('_alcyon_makeGraph', PACKAGE = 'alcyon', pointMapPtr, boundaryGraph, maxVisibility, copyMapNV, progressNV)
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

Rcpp_MetaGraph_read <- function(fileName, verboseNV = NULL) {
    .Call('_alcyon_readMetaGraph', PACKAGE = 'alcyon', fileName, verboseNV)
}

