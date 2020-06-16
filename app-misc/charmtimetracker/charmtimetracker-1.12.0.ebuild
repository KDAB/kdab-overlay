# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

RESTRICT="mirror"

DESCRIPTION="Charm - the Cross-Platform Time Tracker"
HOMEPAGE="https://github.com/KDAB/Charm"
SRC_URI="https://github.com/KDAB/Charm/archive/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+qt5 dbus printsupport cisupport timesheettools +idledetection"
REQUIRE_USE="qt5 idledetection? ( xcb )"

RDEPEND="
	>=dev-util/qtkeychain-0.10.0
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qttest:5
	dev-qt/qtscript:5
	dbus? ( dev-qt/qtdbus:5 )
	printsupport? ( dev-qt/qtprintsupport:5 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/Charm-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCharm_VERSION=${PV}
		-DCHARM_CI_SUPPORT="$(usex cisupport)"
		-DCHARM_TIMESHEET_TOOLS="$(usex timesheettools)"
		-DCHARM_IDLE_DETECTION="$(usex idledetection)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
