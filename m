From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Date: Fri, 20 Apr 2018 13:45:43 +0000
Subject: Re: BUG: Bad rss-counter state ...
Message-Id: <B93E0647-50E5-4F55-9E37-76E78882ABE7@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
References: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
In-Reply-To: <E08C1995-DD20-4613-9885-D9F2857D7737@exactcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hey John,

On 20 Apr 2018, at 15:30, John Paul Adrian Glaubitz <glaubitz@physik.fu-ber=
lin.de> wrote:

> On 04/20/2018 03:25 PM, Ren=E9 Rebe wrote:
>> [    0.000258] Linux version 4.16.2-dist (root@somewhere.exactco.de) (gc=
c version 5.3.0 (GCC)) #1 SMP Tue Apr 17 08:21:44 Local time zone must be s=
et--see zic
>=20
> It *might* also be related to the toolchain.
>=20
> Your version of gcc is pretty old (Debian builds the kernel with gcc-7.3.=
0) and
> we found many different bugs in gcc and binutils that were fixed over the=
 time
> for SPARC. Not sure which of those fixes were backported to gcc-5.

Well, remember, I only went down with binutils / gcc versions because latest
binutils/ld segfaults linking newer glibcs:
	https://twitter.com/renebln/status/984741114757439488

#2  in bfd_malloc at ../../bfd/libbfd.c:193
#3  in _bfd_elf_strtab_finalize at ../../bfd/elf-strtab.c:368
#4  in _bfd_elf_assign_file_positions_for_non_load at ../../bfd/elf.c:6318
#5  _bfd_elf_write_object_contents at ../../bfd/elf.c:6354
#6  in bfd_close at ../../bfd/=85

This is how I ended up downgrading binutils, glibc and gcc until I had a us=
er-land
that built, =85 (yes, I neglected t2/sparc* support the last years, sorry f=
or that)

> So, in case you are unable to track down the issue in the kernel, try a n=
ewer
> toolchain and the latest version of binutils (2.30 + branch updates).

Speaking of =93updates=94, if you have a patch for that segfault, =85
But today is your lucky, as my latest financing opensource work by YouTube
videos (http://youtube.com/renerebe) shows some results, I now rebuild
latest t2/svn:HEAD toolchain and re-build the Linux kernel for you (as
the binutils/ld crash happened with glibc, I only need to toolchain for
the kernel build):

# scripts/Build-Target  -cfg sparc64 -job 0-binutils
=3D=3D 13:34:33 =3D[0]=3D> Building develop/binutils [2.30 9.0-svn].
# scripts/Build-Target  -cfg sparc64 -job 0-gcc=20
=3D=3D 13:36:00 =3D[0]=3D> Building develop/gcc [7.3.0 9.0-svn].
# scripts/Build-Target  -cfg sparc64 -job 1-linux
=3D=3D 13:42:19 =3D[1]=3D> Building base/linux [4.16.3 9.0-svn].

Waiting for the kernel to finish on my more Epyc CPU and then
rsync and reboot. So maybe less than an hour or so ;-)

	Ren=E9

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de

