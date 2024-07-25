// SPDX-FileCopyrightText: 2000-2010 University College London, Alasdair Turner
// SPDX-FileCopyrightText: 2011-2012 Tasos Varoudis
// SPDX-FileCopyrightText: 2017-2018 Petros Koutsolampros
//
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

#include "salalib/ianalysis.h"
#include "salalib/shapegraph.h"

class SegmentTulipShortestPath : public IAnalysis {
  private:
    ShapeGraph &m_map;
    int m_tulipBins;
    int m_refFrom, m_refTo;

  public:
    struct Column {
        inline static const std::string                                  //
            ANGULAR_SHORTEST_PATH_ANGLE = "Angular Shortest Path Angle", //
            ANGULAR_SHORTEST_PATH_ORDER = "Angular Shortest Path Order"; //
    };

  public:
    SegmentTulipShortestPath(ShapeGraph &map, int tulipBins, int refFrom, int refTo)
        : m_map(map), m_tulipBins(tulipBins), m_refFrom(refFrom), m_refTo(refTo) {}
    std::string getAnalysisName() const override { return "Tulip Shortest Path"; }
    AnalysisResult run(Communicator *) override;
};
