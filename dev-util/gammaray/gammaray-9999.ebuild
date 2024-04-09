# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature virtualx xdg

DESCRIPTION="GammaRay is a tool to poke around in a Qt-application and also to manipulate the application to some extent."
HOMEPAGE="https://github.com/KDAB/GammaRay"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KDAB/GammaRay.git"
else
	SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="BSD-2 GPL-2+ MIT"
SLOT=0
QT_MIN=6.0

IUSE="3d bluetooth designer doc geolocation scxml svg test qml wayland webengine qt5"
RESTRICT="!test? ( test )"

# TODO: fix automagic sci-libs/vtk (and many other) dependencies
RDEPEND="
	>=dev-qt/qtbase-${QT_MIN}:6=[gui,widgets,xml,network,concurrent]
	3d? ( >=dev-qt/qt3d-${QT_MIN}:6 )
	bluetooth? ( >=dev-qt/qtconnectivity-${QT_MIN}:6[bluetooth] )
	designer? ( >=dev-qt/designer-${QT_MIN}:5 )
	geolocation? ( >=dev-qt/qtpositioning-${QT_MIN}:6 )
	qml? ( >=dev-qt/qtdeclarative-${QT_MIN}:6=[widgets] )
	scxml? ( >=dev-qt/qtscxml-${QT_MIN}:6 )
	svg? ( >=dev-qt/qtsvg-${QT_MIN}:6 )
	webengine? ( >=dev-qt/qtwebengine-${QT_MIN}:6[widgets] )
	wayland? ( >=dev-qt/qtwayland-${QT_MIN}:6[compositor] )
	qt5? ( =dev-util/gammaray-probe-qt5-${PV}:= )
"

DEPEND="${RDEPEND}
	test? ( dev-qt/qtbase-${QTMIN}:6[test] )
"

DOCS=(CHANGES CONTRIBUTORS.txt README.md)

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package 3d Qt63DAnimation)
		$(cmake_use_find_package 3d Qt63DExtras)
		$(cmake_use_find_package 3d Qt63DInput)
		$(cmake_use_find_package 3d Qt63DLogic)
		$(cmake_use_find_package 3d Qt63DRender)
		$(cmake_use_find_package 3d Qt63DQuick)
		$(cmake_use_find_package bluetooth Qt6Bluetooth)
		$(cmake_use_find_package designer Qt6Designer)
		$(cmake_use_find_package geolocation Qt6Positioning)
		$(cmake_use_find_package qml Qt6Qml)
		$(cmake_use_find_package qml Qt6Quick)
		$(cmake_use_find_package qml Qt6QuickWidgets)
		$(cmake_use_find_package svg Qt6Svg)
		$(cmake_use_find_package scxml Qt6Scxml)
		$(cmake_use_find_package test Qt6Test)
		$(cmake_use_find_package wayland Qt6WaylandCompositor)
		$(cmake_use_find_package webengine Qt6WebEngineWidgets)
		-DQT_VERSION_MAJOR=6
		-DGAMMARAY_BUILD_DOCS=$(usex doc)
		-DGAMMARAY_BUILD_UI=ON
		-DGAMMARAY_DISABLE_FEEDBACK=ON
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}

src_install() {
	cmake_src_install
	rm -r "${ED}"/usr/share/doc/${PN} || die
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "graphical state machine debugging support" dev-util/kdstatemachineeditor
}
