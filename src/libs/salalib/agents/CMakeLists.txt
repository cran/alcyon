# SPDX-FileCopyrightText: 2017-2018 Christian Sailer
# SPDX-FileCopyrightText: 2017-2024 Petros Koutsolampros
#
# SPDX-License-Identifier: GPL-3.0-or-later

target_sources(salalib
    PUBLIC
        agent.hpp
        agentprogram.hpp
        agentga.hpp
        agentanalysis.hpp
    PRIVATE
        agent.cpp
        agentprogram.cpp
        agentga.cpp
        agentanalysis.cpp
)

