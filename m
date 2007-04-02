From: Rene Rebe <rene@exactcode.de>
Date: Mon, 02 Apr 2007 10:11:14 +0000
Subject: Re: [t2] [ANNOUNCE] T2 SDE 6.0.3 - "Spring Fever"
Message-Id: <200704021211.14141.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

just wanted to drop a note that the UltraSPARC ISOs of the T2 minimal-X.org
LiveCD did finish, finally (takes some time to buid on a 360MHz CPU ...)

  http://osiris.tfh-berlin.de/mirror/t2/stable/6.0.3/minimal-desktop-live-s=
parc64/
  http://www.t2-project.org/

The 300 MB sized ISO is a LiveCD with quite recent modular X11R7 with barely
more than the system and X basics (Firefox is included, though :-).

Tested on my U5 and U10, thus known to even properly bring up a Sun
Creator 3D.

On Wednesday 28 March 2007 15:37:55 I wrote:
> Hi all,
>=20
> we are pleased to announce the maintenance release T2 SDE 6.0.3 named
> "Spring Fever".
>=20
> It also comes with some updated packages, but mostly security updates, bu=
g=20
> fixes and some improvements!
>=20
> The release primarily focus to iron out all known LiveCD issues for smoot=
h=20
> building of custom T2-based LiveCD/DVD and USB sticks.
>=20
> Prebuilt Live ISO images of the generic-minimal-X.org-desktop are availab=
le
> for x86, x86-64, ppc, ppc64 and sparc64 will follow, soon:
> =20
>   http://osiris.tfh-berlin.de/mirror/t2/stable/6.0.3/
>   http://nexus.tfh-berlin.de/t2/binary/stable/6.0.3/
> =20
> Please note our roadmap and known issue lists at:
>   http://www.t2-project.org/releases/
> =20
> For more information please check out the full anounncement below.
> =20
> =3D About T2 > =20
> T2 is not a common Linux distribution - it is a flexible Open Source Syst=
em=20
> Development Environment, allowing the creation of custom distributions wi=
th=20
> bleeding edge technology.
> =20
> With T2 you can define targets for various purposes, ranging from embedded
> Linux systems with a few MB of size over server configurations to a full =

> desktop system featuring X.Org foundation, KDE, Gnome, OpenOffice.Org and=
=20
> many more. Those targets can be compiled for use on the most common=20
> architectures: Alpha, ARM, AVR32, Blackfin, IA64, HPPA/HPPA64, IA64,
> MIPS/MIPS64, PowerPC/PowerPC64,  SPARC/SPARC64, SuperH, x86/x86-64 -
> theoretically any GCC/Linux supported one.
> =20
> You can find more info about T2 at http://www.t2-project.org/.
> =20
> =3D T2 6.0 Tree (Branch) Overview > =20
> This release includes bug fixes, security fixes, updates and even some
> improvements to the SDE. Most notable are:
> =20
>         * updated GCC 4.1.2
> 	* improved LiveCD support
> 	* enhanced X.org pre-configuration
>=20
> You can find more info about the 6.0 series at
> http://www.t2-project.org/releases/6.0.html
> =20
> =3D Getting T2 6.0.3 > =20
> The source tarball of 6.0.2 release can be found at:
> =20
>   http://dl.exactcode.de/t2/t2-6.0.3.tar.bz2
> =20
> or via svn:
> =20
>   svn co http://svn.exactcode.de/t2/tags/6.0.3 t2-6.0.3
> =20
> ISO images of minimal T2 for sparc64 where created with this release and =
can=20
> be found, as usual at:
> =20
>   http://osiris.tfh-berlin.de/mirror/t2/stable/6.0.3/
>   http://nexus.tfh-berlin.de/t2/binary/stable/6.0.3/
>=20
> Important note: we recommend to use 6.0 branch to stay up-to-date with
> the latest bug-fix and security updates, you can grab it:
> =20
>   svn co http://svn.exactcode.de/t2/branches/6.0 6.0-branch
>=20
> Previous 6.0 installation can be updated from this source via the build
> system running:
>=20
> ./scripts/Emerge-Pkg -system
>=20
> =3D T2 6.0.3 Changes > =20
> Generated statistics (6.0.1-> 6.0.2):
>=20
> There where 129 changesets with 271 lines of commit messages.
> Approximately 84 packages got updates, 39 issues fixed, 84 packages or
> features added and 8 removed. Arround 9 improvements have been
> committed.
>=20
> Toolchain updates:
>         * merged r22602 from trunk: updated gcc (4.1.1 -> 4.1.2)
>         * updated linux24 (2.4.32 -> 2.4.33.2 -> 2.4.33.3 -> 2.4.33.4 -> =
2.4.34)

--=20
  Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
  +49 (0)30 / 255 897 45
