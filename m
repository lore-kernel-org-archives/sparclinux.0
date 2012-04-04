From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 04 Apr 2012 07:07:12 +0000
Subject: Sparc-32 debian wheezy package repository at http://developer.gaisler.net/debian/
Message-Id: <4F7BF320.1040506@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Debian wheezy sparc-32 package repository:
http://developer.gaisler.net/debian/
You can use http://wiki.debian.org/Multistrap (on debian)
together with:
--------- m-sparc.conf ------------------
[General]
arch=3Dsparc
directory=3D/tmp/dist-multistrap-w
cleanup=3Dtrue
noauth=3Dtrue
unpack=3Dtrue
aptsources=3DGrip Updates
debootstrap=DEbian

[Debian]
packagessource=3Dhttp://developer.gaisler.net/debian
suite=3Dwheezy
-----------------------------------------
and
$fakeroot multistrap -f m-sparc.conf
to install a base installation.

For cross compilation of debian packages there is a
sparc-linux-gnu crosscompiler with many libraries preinstalled:
http://developer.gaisler.net/debian/cross-compiler/sparc-linux-gnu-cross_1.=
0.0-1_amd64.deb
This package is for a 64-bit machine.
-- Konrad
