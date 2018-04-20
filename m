From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 20 Apr 2018 18:46:46 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <32894e88-d4ee-901f-78e7-8aa629735d8f@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 04/20/2018 03:44 PM, Ren=E9 Rebe wrote:
> Well, remember, I only went down with binutils / gcc versions because lat=
est
> binutils/ld segfaults linking newer glibcs:
> https://twitter.com/renebln/status/984741114757439488
>=20
> #2 =A0in bfd_malloc at ../../bfd/libbfd.c:193
> #3 =A0in _bfd_elf_strtab_finalize at ../../bfd/elf-strtab.c:368
> #4 =A0in _bfd_elf_assign_file_positions_for_non_load at ../../bfd/elf.c:6=
318
> #5 =A0_bfd_elf_write_object_contents at ../../bfd/elf.c:6354
> #6 =A0in bfd_close at ../../bfd/=85
>=20
> This is how I ended up downgrading binutils, glibc and gcc until I had a =
user-land
> that built, =85 (yes, I neglected t2/sparc* support the last years, sorry=
 for that)

I remember there was recently an issue with glibc and 32-bit sparc userland
that the Gentoo folks saw. I don't remember what it was though. We don't
have any binutils problems on a 64-bit userland in Debian that I know of.

Usually, James Clarke and Eric Botcazou are very fast fixing those issues
in binutils or gcc. binutils had several regressions with the first
2.30 versions but all that stuff was fixed in the latest 2.30 branch
and glibc builds fine. So, if you have something reproducible for
binutils, please file it in the upstream bug report tracker and
CC them and me.

Also, we have a fast SPARC-T5 porterbox running Debian sparc64 unstable
which is used by many upstream developers (qemu, gcc, binutils, FPC
and so on) and those people constantly test their stuff on this machine.
Thus, lots of stuff was already fixed for sparc64. Though there can
always be surprises, especially in binutils. Oracle themselves is focusing
on the 64-bit SPARC userland, although I don't know how busy they are
at the moment.

In general, I would recommend you joining #debian-ports on OFTC and
#gentoo-sparc on Freenode and #sparc on Freenode. There are lots of
knowledgeable people around who also usually know about the latest
regressions or previous issues.

>> So, in case you are unable to track down the issue in the kernel, try a =
newer
>> toolchain and the latest version of binutils (2.30 + branch updates).
>=20
> Speaking of =93updates=94, if you have a patch for that segfault, =85
> But today is your lucky, as my latest financing opensource work by YouTube
> videos (http://youtube.com/renerebe) shows some results, I now rebuild
> latest t2/svn:HEAD toolchain and re-build the Linux kernel for you (as
> the binutils/ld crash happened with glibc, I only need to toolchain for
> the kernel build):
>=20
> # scripts/Build-Target=A0=A0-cfg sparc64 -job 0-binutils
> =3D 13:34:33 =3D[0]=3D> Building develop/binutils [2.30 9.0-svn].
> # scripts/Build-Target=A0=A0-cfg sparc64 -job 0-gcc=A0
> =3D 13:36:00 =3D[0]=3D> Building develop/gcc [7.3.0 9.0-svn].
> # scripts/Build-Target=A0=A0-cfg sparc64 -job 1-linux
> =3D 13:42:19 =3D[1]=3D> Building base/linux [4.16.3 9.0-svn].
>=20
> Waiting for the kernel to finish on my more Epyc CPU and then
> rsync and reboot. So maybe less than an hour or so ;-)

I just checked the latest build logs. The glibc testsuite recently
failed for 2.27 but did not fail for a previous 2.27 build:

FAIL: https://buildd.debian.org/status/fetch.php?pkg=3Dglibc&arch=3Dsparc64=
&ver=3D2.27-3%2Bb1&stamp=1523840708&raw=3D0
PASS: https://buildd.debian.org/status/fetch.php?pkg=3Dglibc&arch=3Dsparc64=
&ver=3D2.27-3&stamp=1522364505&raw=3D0

There was also a userland memory corruption with kernel 4.14+ which got fix=
ed with
4.16-rc6. After upgrading the kernel, many packages built fine again but su=
rprisingly
not glibc. I should probably poke glibc upstream after triggering another r=
ebuild
of glibc.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
