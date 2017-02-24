#!/bin/bash
#
# Configuration variables for building libreoffice online.
#
# Copyright 2017 Rainer Emrich, <rainer@emrich-ebersheim.de>
#
# This file is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file LICENSE.  If not see
# <http://www.gnu.org/licenses/>.
#
# Define poco version to use.

POCO_VERSION="1.7.7"

#
# Define libreoffice core version to use.

LOC_VERSION="cp-5.1-17"

#
# Define libreoffice online version to use.

LOOL_VERSION="2.0.2-3"

#
# Define libreoffice prefix, should be /opt/lool.

LOOL_PREFIX="/opt/lool"

#
# Define poco prefix, defaults to LOOL_PREFIX if empty.

POCO_PREFIX=""

#
# Don't edit below this line.

export POCO_VERSION LOC_VERSION LOOL_VERSION POCO_PREFIX LOOL_PREFIX
