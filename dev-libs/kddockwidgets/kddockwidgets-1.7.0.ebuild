# Copyright 1999-2020 Gentoo Authors
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
QT_MIN=5.15

RDEPEND=">=dev-qt/qtcore-${QT_MIN}:5
	>=dev-qt/qtgui-${QT_MIN}:5
	>=dev-qt/qtwidgets-${QT_MIN}:5
	kde-frameworks/extra-cmake-modules"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:5 )"
S="${WORKDIR}/KDDockWidgets-${PV}"
