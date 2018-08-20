# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

RESTRICT="mirror"

DESCRIPTION="GammaRay"
HOMEPAGE="https://github.com/KDAB/GammaRay"
SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+qt5 qt3d bluetooth concurrent designer location positioning printsupport qml svg script test webengine widgets wayland qtlayout disablefeedback staticprobe"
REQUIRE_USE="qt5"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	qt3d? ( dev-qt/qt3d:5 )
	bluetooth? ( dev-qt/qtbluetooth:5 )
	concurrent? ( dev-qt/qtconcurrent:5 )
	designer? ( dev-qt/designer:5 )
	location? ( dev-qt/qtlocation:5 )
	positioning? ( dev-qt/qtpositioning:5 )
	printsupport? ( dev-qt/qtprintsupport:5 )
	qml? ( dev-qt/qtdeclarative:5 dev-qt/qtquickcontrols:5 dev-qt/qtquickcontrols2:5 )
	svg? ( dev-qt/qtsvg:5 )
	script? ( dev-qt/qtscript:5 )
	test? ( dev-qt/qttest:5 )
	webengine? ( dev-qt/qtwebengine:5 )
	widgets? ( dev-qt/qtwidgets:5 )
	wayland? ( dev-qt/qtwayland:5 )
	"

DEPEND="${RDEPEND}"

#S="${WORKDIR}/GammaRay-${PV}"

src_configure() {
    local mycmakeargs=(
	-DBUILD_TESTING="$(usex test)"
		-DGAMMARAY_DISABLE_FEEDBACK_DEFAULT="$(usex disablefeedback)"
		-DGAMMARAY_STATIC_PROBE="$(usex staticprobe)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
