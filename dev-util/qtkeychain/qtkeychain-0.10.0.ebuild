# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

RESTRICT="mirror"

DESCRIPTION="qtkeychain - Platform-independent Qt API for storing passwords securely"
HOMEPAGE="https://github.com/frankosterfeld/qtkeychain"
SRC_URI="https://github.com/frankosterfeld/qtkeychain/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+qt5"
REQUIRE_USE="qt5 ( xcb )"

RDEPEND="
	dev-qt/qtcore:5"

DEPEND="${RDEPEND}"

S="${WORKDIR}/qtkeychain-${PV}"

src_configure() {
	local mycmakeargs=()

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
