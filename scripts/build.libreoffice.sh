#!/bin/bash
#
# Build libreoffice core.
#
# Copyright (C) 2017-2019 Rainer Emrich, <rainer@emrich-ebersheim.de>
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

build_libreoffice () {

	if [ "${LIBREOFFICE_BUILD}" != "1" ] ; then
		echo
		echo "#######################################################################################"
		echo "#"
		echo "# Build libreoffice."
		echo "#"
		echo "#######################################################################################"
		echo

		if [ "${LOC_LAST}" != "" ] ; then
			sudo /bin/rm -rf ${LOOL_PREFIX}/lib/*office*
			sudo /bin/rm -rf ${BUILD_DIR}/core-*
		fi

		cd ${SRC_DIR}/core

		git worktree prune
		git worktree add --detach ${BUILD_DIR}/core-${LOC_VERSION} master

		cd ${BUILD_DIR}/core-${LOC_VERSION}

		git checkout tags/${LOC_VERSION}

		echo "lo_sources_ver=${LOC_VERSION}" >sources.ver

		case ${LOC_VERSION} in
		cd-5.1-* | \
		cd-5.3-1* | \
		cd-5.3-2* | \
		cd-5.3-3* | \
		cp-5.3-2? | \
		cp-5.3-30 | \
		cp-5.3-31)
			sed --in-place 's/^CollaboraOffice/LibreOffice/' instsetoo_native/util/openoffice.lst.in
			;;
		*)
			;;
		esac

		./autogen.sh --prefix=${LOOL_PREFIX} --enable-release-build --without-help --without-myspell-dicts --without-doxygen --with-parallelism 2>&1 | tee ${LOG_DIR}/core-${LOC_VERSION}.log

		make fetch
		if [ $? -eq 2 ] ; then
			echo
			echo "ERROR: see ${LOG_DIR}/core-${LOC_VERSION}.log!"
			echo "Exiting..."
			echo
			exit
		fi

		make 2>&1 | tee -a ${LOG_DIR}/core-${LOC_VERSION}.log
		if [ $? -eq 2 ] ; then
			echo
			echo "ERROR: see ${LOG_DIR}/core-${LOC_VERSION}.log!"
			echo "Exiting..."
			echo
			exit
		fi

		make -k check 2>&1 | tee -a ${LOG_DIR}/core-${LOC_VERSION}.log
		if [ $? -eq 2 ] ; then
			echo
			echo "ERROR: see ${LOG_DIR}/core-${LOC_VERSION}.log!"
			echo "Exiting..."
			echo
			exit
		fi

		sudo make install 2>&1 | tee -a ${LOG_DIR}/core-${LOC_VERSION}.log
		sudo make install DESTDIR="${BUILD_DIR}/install" 2>&1 | tee -a ${LOG_DIR}/core-${LOC_VERSION}.log

		sudo tar -C ${BUILD_DIR}/install${LOOL_PREFIX}/ -cvJf ${PKG_DIR}/core-${LOC_VERSION}.tar.xz .

		sudo /bin/rm -rf ${BUILD_DIR}/install

		cd ${START_DIR}

		echo "${LOC_VERSION}" >${STAMP_DIR}/libreoffice_build

		echo
		echo "#######################################################################################"
		echo "#"
		echo "# Building libreoffice finished."
		echo "#"
		echo "#######################################################################################"
		echo
	fi

}
