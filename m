From: Joshua Kwan <joshk@triplehelix.org>
Date: Sat, 14 Aug 2004 06:51:13 +0000
Subject: IDE build fails for sparc32
Message-Id: <20040814065113.GA19997@darjeeling.triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Someone asked for IDE support for Debian's sparc32 kernel images so they
could use their special JavaStations with them. I figured it would not
get built into the kernel, so no harm building modules of it. However,
with 2.4.27:

sparc-linux-gcc -D__KERNEL__ -I/home/joshk/devel/kernel/kernel-2.4/sparc/ke=
rnel-
image-sparc-2.4/kernel-source-2.4.27/include -Wall -Wstrict-prototypes -Wno=
-trig
raphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe =
-mno-
fpu -fcall-used-g5 -fcall-used-g7 -DMODULE -DMODVERSIONS -include /home/jos=
hk/de
vel/kernel/kernel-2.4/sparc/kernel-image-sparc-2.4/kernel-source-2.4.27/inc=
lude/
linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=3Dide=
_iops -DEXPORT_SYMTAB -c ide-iops.c
ide-iops.c:119: error: conflicting types for `ide_insw'
/home/joshk/devel/kernel/kernel-2.4/sparc/kernel-image-sparc-2.4/kernel-sou=
rce-2.4.27/include/asm/ide.h:107: error: previous declaration of `ide_insw'
ide-iops.c:149: error: conflicting types for `ide_outsw'
/home/joshk/devel/kernel/kernel-2.4/sparc/kernel-image-sparc-2.4/kernel-sou=
rce-2
=2E4.27/include/asm/ide.h:138: error: previous declaration of `ide_outsw'
ide-iops.c: In function `ide_mm_insw':
ide-iops.c:196: warning: implicit declaration of function `__ide_mm_insw'
ide-iops.c: In function `ide_mm_insl':
ide-iops.c:206: warning: implicit declaration of function `__ide_mm_insl'
ide-iops.c: In function `ide_mm_outsw':
ide-iops.c:226: warning: implicit declaration of function `__ide_mm_outsw'
ide-iops.c: In function `ide_mm_outsl':
ide-iops.c:236: warning: implicit declaration of function `__ide_mm_outsl'
make[4]: *** [ide-iops.o] Error 1
make[4]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-image-sparc-2.4/kernel-source-2.4.27/drivers/ide'
make[3]: *** [_modsubdir_ide] Error 2
make[3]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-ima
ge-sparc-2.4/kernel-source-2.4.27/drivers'
make[2]: *** [_mod_drivers] Error 2
make[2]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-ima
ge-sparc-2.4/kernel-source-2.4.27'
make[1]: *** [stamp-build] Error 2
make[1]: Leaving directory `/home/joshk/devel/kernel/kernel-2.4/sparc/kerne=
l-ima
ge-sparc-2.4/kernel-source-2.4.27'
make: *** [stamps/build-sparc32-stamp] Error 2

I suspect this has been broken for a while, but just wanted to make sure
people knew. I've decided to not add IDE for this release of the kernel
images for the time being.

If it's really horked, perhaps we should disable it in Config.in?

Thanks!

--=20
Joshua Kwan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQR22YaOILr94RG8mAQLWVQ//XYzOErS4YH3mRpvwXjEergCKx8H8BUzY
2gk+AZd8VNz/VP85AyP2nVpZiNiYGSAxoXArBWJxA8MkzTNnBrGwiItfFgXKt7/w
L986d692meO0E9p9FhUapJPkxGsd+wfsjdTS/Fl+pyA6hqhTHCFHzf/XAamQc43n
ce+/roi9v/vh7/sDwu6gbnVQWlAK2farIJB8GiArhYm0u9UxxtiIXVxPKU3eB8Bd
GgidzZiLZfqEhL541wtAtfmPO3BhCcSpGdZwZuSt/ELo9fckXMT/Qkwpp3UNPGhp
ZuZNn7dClQ9Hb8Z/mIkBe+UiHeUqXeY21Az/+Ywv4FKOtvA38PrXKuZJDz7s/+sn
zVxSaIBmMr9zFvWFo5p3aD7eDH/SBKxvlTX4gJl0Buo0arCWHq4OvU+TzhoJ7ink
s4omOsjSbq+lmtDEK/FGXnTbN+dRxDKiOlnnM1u0+C9HCyvj7XZVKBo4kRhfKPiU
jLWItmN4RBPX5xnBy1ghD1GGbNHdxp1zGvctVVaEVLVGKdUR2M6F/1X7TsABVEPi
9F/7FIWb1b+vRxMp8yw03gpbdgMGeLldk7lLn+Yha/+xrBjVm7z6fatVTgwVeNEs
KgmFv3R67MvVW01a0sy5YjI4gWSUsg6hSqJNwYOwgMAPaU55Zl9MSpMOD+J7rNKX
pG5Xh7l0SQQ=
=Xx4W
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
