# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

RESTRICT="mirror"
QT_MIN=5.15
KF_MIN=5.42.0

DESCRIPTION="The Linux perf GUI for performance analysis."
HOMEPAGE="https://github.com/KDAB/hotspot"
SRC_URI="https://github.com/KDAB/hotspot/releases/download/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
REQUIRE_USE=""

RDEPEND="
	>=dev-qt/qtcore-${QT_MIN}
	>=dev-qt/qtwidgets-${QT_MIN}
	>=dev-qt/qtnetwork-${QT_MIN}
	>=dev-qt/qttest-${QT_MIN}
	virtual/libelf
	sys-devel/gettext
	sys-devel/binutils
	>=kde-frameworks/extra-cmake-modules-${KF_MIN}
	>=kde-frameworks/threadweaver-${KF_MIN}
	>=kde-frameworks/ki18n-${KF_MIN}
	>=kde-frameworks/kconfigwidgets-${KF_MIN}
	>=kde-frameworks/kcoreaddons-${KF_MIN}
	>=kde-frameworks/kitemviews-${KF_MIN}
	>=kde-frameworks/kitemmodels-${KF_MIN}
	>=kde-frameworks/kio-${KF_MIN}
	>=kde-frameworks/solid-${KF_MIN}
	>=kde-frameworks/kwindowsystem-${KF_MIN}
	dev-util/perf
	dev-libs/kddockwidgets
	"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	# Gentoo doesn't s upport debuginfod, Hotspot doesn't have an option to disable that yet.
	sed -i '/target_link_libraries(libhotspot-perfparser PRIVATE ${LIBDEBUGINFOD_LIBRARIES})/d' 3rdparty/perfparser.cmake \
			|| die "sed failed for perfparser"
	sed -i '/target_compile_definitions(libhotspot-perfparser PRIVATE HAVE_DWFL_GET_DEBUGINFOD_CLIENT=1)/d' 3rdparty/perfparser.cmake \
			|| die "sed failed for perfparser"

	cmake_src_prepare
}
