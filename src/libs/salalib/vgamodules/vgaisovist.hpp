// SPDX-FileCopyrightText: 2000-2010 University College London, Alasdair Turner
// SPDX-FileCopyrightText: 2011-2012 Tasos Varoudis
// SPDX-FileCopyrightText: 2017-2024 Petros Koutsolampros
//
// SPDX-License-Identifier: GPL-3.0-or-later

#pragma once

#include "ivga.hpp"

#include "../isovist.hpp"
#include "../pointmap.hpp"

#include "../genlib/bsptree.hpp"

class VGAIsovist : public IVGA {
    const std::vector<SalaShape> &m_boundaryShapes;
    bool m_simpleVersion = false;

    [[maybe_unused]] unsigned _padding0 : 3 * 8;
    [[maybe_unused]] unsigned _padding1 : 4 * 8;

  public:
    struct Column {
        inline static const std::string                          //
            ISOVIST_AREA = "Isovist Area",                       //
            ISOVIST_COMPACTNESS = "Isovist Compactness",         //
            ISOVIST_DRIFT_ANGLE = "Isovist Drift Angle",         //
            ISOVIST_DRIFT_MAGNITUDE = "Isovist Drift Magnitude", //
            ISOVIST_MIN_RADIAL = "Isovist Min Radial",           //
            ISOVIST_MAX_RADIAL = "Isovist Max Radial",           //
            ISOVIST_OCCLUSIVITY = "Isovist Occlusivity",         //
            ISOVIST_PERIMETER = "Isovist Perimeter";             //
    };

  public:
    VGAIsovist(const PointMap &map, const std::vector<SalaShape> &boundaryShapes)
        : IVGA(map), m_boundaryShapes(boundaryShapes), _padding0(0), _padding1(0) {}
    std::string getAnalysisName() const override { return "Isovist Analysis"; }
    AnalysisResult run(Communicator *comm) override;

  private:
    std::vector<std::string> createAttributes(bool simpleVersion) const;
    std::set<std::string> setData(Isovist &isovist, size_t &index, AnalysisResult &result,
                                  bool simpleVersion) const;
    BSPNode makeBSPtree(Communicator *communicator,
                        const std::vector<SalaShape> &boundaryShapes) const;

  public:
    void setSimpleVersion(bool simpleVersion) { m_simpleVersion = simpleVersion; }
};
