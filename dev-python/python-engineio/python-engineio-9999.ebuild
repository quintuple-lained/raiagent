# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} pypy3 )

inherit distutils-r1

DESCRIPTION="Python Engine.IO server and client"
HOMEPAGE="
	https://python-engineio.readthedocs.org
	https://github.com/miguelgrinberg/python-engineio
	https://pypi.org/project/python-engineio"
LICENSE="MIT"
SLOT="0"
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/six-1.9.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/eventlet[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/miguelgrinberg/python-engineio.git"
	EGIT_BRANCH="master"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	# pypi tarball does not contain tests
	RESTRICT="test"
fi

python_test() {
	esetup.py test || die
}
