// SPDX-FileCopyrightText: 2000-2010 University College London, Alasdair Turner
// SPDX-FileCopyrightText: 2011-2012 Tasos Varoudis
// SPDX-FileCopyrightText: 2017-2024 Petros Koutsolampros
//
// SPDX-License-Identifier: GPL-3.0-or-later

#include "axialstepdepth.hpp"

#include "../genlib/pflipper.hpp"

AnalysisResult AxialStepDepth::run(Communicator *, ShapeGraph &map, bool) {

    AttributeTable &attributes = map.getAttributeTable();

    AnalysisResult result;

    auto stepdepthCol = attributes.insertOrResetColumn(Column::STEP_DEPTH);
    result.addAttribute(Column::STEP_DEPTH);

    bool *covered = new bool[map.getConnections().size()];
    for (size_t i = 0; i < map.getConnections().size(); i++) {
        covered[i] = false;
    }
    pflipper<std::vector<size_t>> foundlist;
    for (auto &lineindex : m_originRefs) {
        foundlist.a().push_back(static_cast<size_t>(lineindex));
        covered[lineindex] = true;
        map.getAttributeRowFromShapeIndex(static_cast<size_t>(lineindex))
            .setValue(stepdepthCol, 0.0f);
    }
    int depth = 1;
    while (foundlist.a().size()) {
        Connector &line = map.getConnections()[foundlist.a().back()];
        for (size_t k = 0; k < line.connections.size(); k++) {
            if (!covered[line.connections[k]]) {
                covered[line.connections[k]] = true;
                foundlist.b().push_back(line.connections[k]);
                map.getAttributeRowFromShapeIndex(line.connections[k])
                    .setValue(stepdepthCol, static_cast<float>(depth));
            }
        }
        foundlist.a().pop_back();
        if (!foundlist.a().size()) {
            foundlist.flip();
            depth++;
        }
    }
    delete[] covered;

    result.completed = true;

    return result;
}
