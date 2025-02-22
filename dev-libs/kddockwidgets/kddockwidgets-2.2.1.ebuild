# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KDAB's Dock Widget Framework for Qt"
HOMEPAGE="https://github.com/KDAB/KDDockWidgets"
SRC_URI="https://github.com/KDAB/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
RESTRICT="test" # fails
QTMIN=6.6.2
KFMIN=6.3.0
# not sure if above need increasing

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[gui,widgets]
	>=kde-frameworks/extra-cmake-modules-${KFMIN}"
S="${WORKDIR}/KDDockWidgets-${PV}"

src_configure() {
	local mycmakeargs=(
		-DKDDockWidgets_QT6=true
		-DKDDockWidgets_NO_SPDLOG=ON
	)
	cmake_src_configure
}
