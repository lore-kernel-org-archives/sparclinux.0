From: joshk@triplehelix.org (Joshua Kwan)
Date: Sat, 08 May 2004 01:18:16 +0000
Subject: Re: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040508011816.GA12408@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8X7/QrJGcKSMr1RN"
List-Id: <sparclinux.vger.kernel.org>
References: <20040506224026.GD29131@triplehelix.org>
In-Reply-To: <20040506224026.GD29131@triplehelix.org>
To: sparclinux@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 07, 2004 at 05:22:45PM -0700, David S. Miller wrote:
> I was about to ask you to make and test 2.6.x versions of
> your fixed.

These fixes already made it into 2.6, it seems:
- source "drivers/i2c/Kconfig" for arch/sparc64
- use $(LD) -V
- pgalloc.h (which you made, heh)

so the only other fix is for the arch/sparc64/Makefile CC definition;
diff attached. However, it does not seem to build, for unrelated
reasons:

  sparc-linux-gcc -Wp,-MD,init/.main.o.d -nostdinc -iwithprefix include -D_=
_KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-a=
liasing -fno-common -m64 -pipe -mno-fpu -mcpu=3Dultrasparc -mcmodel=3Dmedlo=
w -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclar=
ed-regs -finline-limit=3D100000 -O2 -fomit-frame-pointer     -DKBUILD_BASEN=
AME=3Dmain -DKBUILD_MODNAME=3Dmain -c -o init/.tmp_main.o init/main.c
In file included from include/linux/unistd.h:7,
                 from init/main.c:44:
include/asm/unistd.h: In function `setsid':
include/asm/unistd.h:433: error: parse error before '}' token
include/asm/unistd.h:434: error: redeclaration of `__g1'
include/asm/unistd.h:433: error: `__g1' previously declared here
include/asm/unistd.h:434: error: `fd' undeclared (first use in this functio=
n)
include/asm/unistd.h:434: error: (Each undeclared identifier is reported on=
ly once
(and so on)

include/asm is indeed symlinked to include/asm-sparc64, FWIW.

--=20
Joshua Kwan

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="NEW_GCC-use-CC.diff"
Content-Transfer-Encoding: quoted-printable

--- a/arch/sparc64/Makefile	2004-05-07 18:11:16.000000000 -0700
+++ b/arch/sparc64/Makefile	2004-05-07 18:11:45.000000000 -0700
@@ -10,7 +10,7 @@
=20
 AFLAGS_vmlinux.lds.o +=3D -Usparc
=20
-CC		:=3D $(shell if gcc -m64 -S -o /dev/null -xc /dev/null >/dev/null 2>&1=
; then echo gcc; else echo sparc64-linux-gcc; fi )
+CC		:=3D $(shell if $(CC) -m64 -S -o /dev/null -xc /dev/null >/dev/null 2>=
&1; then echo $(CC); else echo sparc64-linux-gcc; fi )
=20
 NEW_GCC :=3D $(shell if $(CC) -m64 -mcmodel=3Dmedlow -S -o /dev/null -xc /=
dev/null >/dev/null 2>&1; then echo y; else echo n; fi; )
 NEW_GAS :=3D $(shell if $(LD) -V 2>&1 | grep 'elf64_sparc' > /dev/null; th=
en echo y; else echo n; fi)

--kXdP64Ggrk/fb43R--

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJw1VqOILr94RG8mAQJHyw/+OQOqHyZsWfCrGN3lN8bxmXlyBW2ymx3Y
W2V5+KGlK09hdZ++RxdZEwyyYKhaq1MB2PJURfg2hmG7mZyTqRlA/4DPwgda/cfh
RAbKHa3ux8DFjP7n4pqIFuJVAfXRPRZOnkEvKMzcSSkwGFKlRYPz2Zf9gGoPGYy3
kCpuBXzOcq7jS4RFRRcq3IAeBWw5DKRjLZ7/ratXjgP6PYIwgKa16JRWVYw4OXyo
oxQ2cDIasvl488lvzfI+2fc6/V6Wr+RfXdUORMtP4x6nMdZf9KDv6fk1NQKyb0S0
4B1ZtbkXUNRkyElCCT8CizkzhM1CsOTiAN3qMfKoqWbb2/oLBvVF8pyyl7YN6U9w
c3F9bMU43nAI9LxgwgtfdnbYXvjyLG75+/FPxQQav2sOhWC1rmPoJJgKFuRWu9zB
kyi8hbfFSDi7wfGz26Ld3LthfWNd2GqYsx+24Wsa6I/A1+WG8Zu3F31kqL6NdQFB
xPLqrVTUpjcqHaPVAr98XhLIVQUZTOjmVizJUItt1PYbGJJsh62FfDaTYg/nQEJu
bvCqYWgYkXVJRTWrG79bwSocc5AkOPvYoQ3siwkIeL/fTKnfGUFsxmfT7Y5hlAEI
qRqSv0Wc/lg72yjGU0JrKRLm2Pcf8lPOypBzgbiQEefy88Vby1rRB3Rn7HV/KtZo
XfULEofv+zw=
=u/oz
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
