# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

RESTRICT="mirror"

DESCRIPTION="Hotspot - the Linux perf GUI for performance analysis"
HOMEPAGE="https://github.com/KDAB/hotspot"
SRC_URI="https://github.com/KDAB/hotspot/releases/download/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
REQUIRE_USE=""

RDEPEND="
	>=dev-qt/qtcore-5.6.0
	>=dev-qt/qtwidgets-5.6.0
	>=dev-qt/qtnetwork-5.6.0
	>=dev-qt/qttest-5.6.0
	virtual/libelf
	sys-devel/gettext
	kde-frameworks/extra-cmake-modules
	kde-frameworks/threadweaver
	kde-frameworks/ki18n
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/kitemviews
	kde-frameworks/kitemmodels
	kde-frameworks/kio
	kde-frameworks/solid
	kde-frameworks/kwindowsystem
	dev-util/perf
	"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
