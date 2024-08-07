// SPDX-FileCopyrightText: 2024 Petros Koutsolampros
//
// SPDX-License-Identifier: GPL-3.0-only

#include "salalib/axialmodules/axialintegration.h"
#include "salalib/axialmodules/axiallocal.h"
#include "salalib/axialmodules/axialstepdepth.h"

#include "salalib/shapemap.h"
#include "salalib/shapegraph.h"
#include "genlib/p2dpoly.h"

#include "communicator.h"
#include "TraversalType.h"

#include <Rcpp.h>

// [[Rcpp::export("Rcpp_runAxialAnalysis")]]
Rcpp::List runAxialAnalysis(
        Rcpp::XPtr<ShapeGraph> shapeGraph,
        const Rcpp::NumericVector radii,
        const Rcpp::Nullable<std::string> weightedMeasureColNameNV = R_NilValue,
        const Rcpp::Nullable<bool> includeChoiceNV = R_NilValue,
        const Rcpp::Nullable<bool> includeIntermediateMetricsNV = R_NilValue,
        const Rcpp::Nullable<bool> copyMapNV = R_NilValue,
        const Rcpp::Nullable<bool> verboseNV = R_NilValue,
        const Rcpp::Nullable<bool> progressNV = R_NilValue) {
    std::string weightedMeasureColName = "";
    if (weightedMeasureColNameNV.isNotNull()) {
        weightedMeasureColName = Rcpp::as<std::string>(weightedMeasureColNameNV);
    }
    bool includeChoice = false;
    if (includeChoiceNV.isNotNull()) {
        includeChoice = Rcpp::as<bool>(includeChoiceNV);
    }
    bool includeIntermediateMetrics = false;
    if (includeIntermediateMetricsNV.isNotNull()) {
        includeIntermediateMetrics = Rcpp::as<bool>(includeIntermediateMetricsNV);
    }
    // The normal behaviour of R is to copy objects wholesale when applying a
    // function to them. In C++ this is to be avoided unless absolutely
    // necessary. However, since this function is to be used in R and for it to
    // have the same effects as any other R function, we will copy the given map
    // and provide a new pointer if instructed to do so.
    bool copyMap = true;
    if (copyMapNV.isNotNull()) {
        copyMap = Rcpp::as<bool>(copyMapNV);
    }
    bool verbose = false;
    if (verboseNV.isNotNull()) {
        verbose = Rcpp::as<bool>(verboseNV);
    }
    bool progress = false;
    if (progressNV.isNotNull()) {
        progress = Rcpp::as<bool>(progressNV);
    }

    if (verbose)
        Rcpp::Rcout << "Running axial analysis... " << '\n';

    if (copyMap) {
        auto prevShapeGraph = shapeGraph;
        shapeGraph = Rcpp::XPtr(new ShapeGraph());
        shapeGraph->copy(*prevShapeGraph, ShapeMap::COPY_ALL, true);
    }

    int weightedMeasureColIdx = -1;

    if (!weightedMeasureColName.empty()) {
        const AttributeTable &table = shapeGraph->getAttributeTable();
        for (int i = 0; i < table.getNumColumns(); i++) {
            if (weightedMeasureColName == table.getColumnName(i).c_str()) {
                weightedMeasureColIdx = i;
            }
        }
        if (weightedMeasureColIdx == -1) {
            throw depthmapX::RuntimeException("Given attribute (" +
                                              weightedMeasureColName +
                                              ") does not exist in " +
                                              "currently selected map");
        }
    }

    Rcpp::List result = Rcpp::List::create(
        Rcpp::Named("completed") = false
    );

    try {
        std::set<double> radius_set;
        radius_set.insert(radii.begin(), radii.end());
        auto analysis = AxialIntegration(radius_set,
                                         weightedMeasureColIdx,
                                         includeChoice,
                                         includeIntermediateMetrics);
        AnalysisResult analysisResult = analysis.run(
            getCommunicator(progress).get(),
            *shapeGraph,
            false /* simple version*/
        );
        result["completed"] = analysisResult.completed;
        result["newAttributes"] = analysisResult.getAttributes();
        result["mapPtr"] = shapeGraph;
    } catch (Communicator::CancelledException) {
        // result["completed"] = false;
    }
    return result;
}

// [[Rcpp::export("Rcpp_runAxialLocalAnalysis")]]
Rcpp::List runAxialLocalAnalysis(
        Rcpp::XPtr<ShapeGraph> shapeGraph,
        const Rcpp::Nullable<bool> copyMapNV = R_NilValue,
        const Rcpp::Nullable<bool> verboseNV = R_NilValue,
        const Rcpp::Nullable<bool> progressNV = R_NilValue) {
    bool copyMap = true;
    if (copyMapNV.isNotNull()) {
        copyMap = Rcpp::as<bool>(copyMapNV);
    }
    bool verbose = false;
    if (verboseNV.isNotNull()) {
        verbose = Rcpp::as<bool>(verboseNV);
    }
    bool progress = false;
    if (progressNV.isNotNull()) {
        progress = Rcpp::as<bool>(progressNV);
    }

    if (verbose)
        Rcpp::Rcout << "Running axial analysis... " << '\n';

    if (copyMap) {
        auto prevShapeGraph = shapeGraph;
        shapeGraph = Rcpp::XPtr(new ShapeGraph());
        shapeGraph->copy(*prevShapeGraph, ShapeMap::COPY_ALL, true);
    }

    Rcpp::List result = Rcpp::List::create(
        Rcpp::Named("completed") = false
    );

    try {

        auto analysis = AxialLocal();
        AnalysisResult analysisResult = analysis.run(
            getCommunicator(progress).get(),
            *shapeGraph,
            false /* simple version*/
        );
        result["completed"] = analysisResult.completed;
        result["newAttributes"] = analysisResult.getAttributes();
        result["mapPtr"] = shapeGraph;
    } catch (Communicator::CancelledException) {
        // result["completed"] = false;
    }
    return result;
}

// [[Rcpp::export("Rcpp_axialStepDepth")]]
Rcpp::List axialStepDepth(
        Rcpp::XPtr<ShapeGraph> shapeGraph,
        const int stepType,
        const std::vector<double> stepDepthPointsX,
        const std::vector<double> stepDepthPointsY,
        const Rcpp::Nullable<bool> copyMapNV = R_NilValue,
        const Rcpp::Nullable<bool> verboseNV = R_NilValue,
        const Rcpp::Nullable<bool> progressNV = R_NilValue) {
    bool copyMap = true;
    if (copyMapNV.isNotNull()) {
        copyMap = Rcpp::as<bool>(copyMapNV);
    }
    bool verbose = false;
    if (verboseNV.isNotNull()) {
        verbose = Rcpp::as<bool>(verboseNV);
    }
    bool progress = false;
    if (progressNV.isNotNull()) {
        progress = Rcpp::as<bool>(progressNV);
    }

    if (verbose)
        Rcpp::Rcout << "ok\nSelecting cells... " << '\n';

    if (copyMap) {
        auto prevShapeGraph = shapeGraph;
        shapeGraph = Rcpp::XPtr(new ShapeGraph());
        shapeGraph->copy(*prevShapeGraph, ShapeMap::COPY_ALL, true);
    }

    std::set<int> origins;
    for (int i = 0; i < stepDepthPointsX.size(); ++i) {
        Point2f p2f(stepDepthPointsX[i], stepDepthPointsY[i]);
        auto graphRegion = shapeGraph->getRegion();
        if (!graphRegion.contains(p2f)) {
            throw depthmapX::RuntimeException("Point outside of target region");
        }
        QtRegion r(p2f, p2f);
        origins.insert(shapeGraph->getShapesInRegion(r).begin()->first);
    }

    if (verbose)
        Rcpp::Rcout << "ok\nCalculating step-depth... " << '\n';

    Rcpp::List result = Rcpp::List::create(
        Rcpp::Named("completed") = false
    );

    try {
        AnalysisResult analysisResult;
        switch (static_cast<TraversalType>(stepType)) {
        // never really supported for axial maps
        // case AxialAnalysis::AxialStepType::ANGULAR:
        //     pointDepthType = 3;
        //     break;
        // case AxialAnalysis::AxialStepType::METRIC:
        //     pointDepthType = 2;
        //     break;
        case TraversalType::Topological:
            // currently axial only allows for topological analysis
            analysisResult = AxialStepDepth(origins).run(
                getCommunicator(progress).get(),
                *shapeGraph,
                false /* simple mode */
            );
            break;
        default: {
                throw depthmapX::RuntimeException("Error, unsupported step type");
            }
        }
        result["completed"] = analysisResult.completed;
        result["newAttributes"] = analysisResult.getAttributes();
        result["mapPtr"] = shapeGraph;

    } catch (Communicator::CancelledException) {
        //
    }

    return result;
}
