From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 06 May 2004 22:40:26 +0000
Subject: [PATCH] Use $(LD) -V for NEW_GAS check [4/4]
Message-Id: <20040506224026.GD29131@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="54u2kuW9sGWg/X+X"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: multipart/mixed; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

patch 4: use $(LD) -V for NEW_GAS check.

This bug crept up because I have a bi-architecture (32/64) binutils, and
unreasonable defaults sent my build to hell.

--=20
Joshua Kwan

--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="04_sparc32_use_ld_-V.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/arch/sparc/Makefile~	2004-04-26 09:33:48.000000000=
 -0700
+++ kernel-source-2.4.26/arch/sparc/Makefile	2004-04-26 09:34:23.000000000 =
-0700
@@ -16,7 +16,7 @@
 # debugging of the kernel to get the proper debugging information.
=20
 IS_EGCS :=3D $(shell if $(CC) -m32 -S -o /dev/null -xc /dev/null >/dev/nul=
l 2>&1; then echo y; else echo n; fi; )
-NEW_GAS :=3D $(shell if $(LD) --version 2>&1 | grep 'elf64_sparc' > /dev/n=
ull; then echo y; else echo n; fi)
+NEW_GAS :=3D $(shell if $(LD) -V 2>&1 | grep 'elf64_sparc' > /dev/null; th=
en echo y; else echo n; fi)
=20
 ifeq ($(NEW_GAS),y)
 AS              :=3D $(AS) -32

--XaUbO9McV5wPQijU--

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJq+2aOILr94RG8mAQK0aw//W21//LNSFt6fy2/dhLJtCF0pk+Ot5q0G
/tYk4K6pWvuS5yO07TQ44EeIF0rwgHpev2Vpd3Jy4Eb23xiNFNj6bnkRSvBb4++B
65Vnu/N7uOFOynM4m0je8TpEMu6eEThWVa3n8/2PnReAGDM821VLsEPIqPEaGFQm
0E9Tvmg7Ko1epawiUxKNXKUgIaI81L5cWjxn4uusPSLaEeOSzRQ3h5DUYPKbS4pD
mTyejjJT2xSRbbq4CbsWmd7fN7wqQTHQAgzJiAYfXzxehgIyKIYV3NSRxa+QgFvZ
C4NnMDa3Q8GPvCKPVDaZgZHQfGUL9DnV51Mp9jwHsa8VVCH7w0nt0Rr7oqsVSvkP
c/xNhULbqP6vXvnCToagQPCicU/z1gMwcog9Zg7XEN4RFLtjwQDRDcy9nCRQSFT0
MCFV0gb6gHy+wXR8xkdN+iA41i22/g+GR1nopiqlhKqH3VwxhWY5mPIxorD79c29
+hngxdYhmFke05FrW6cuqMETs+jjGF55KHZAFN0XGBfH4/U2VxIeLkB5ppwyhWSK
8TifUOzhQfPGhGr+pF9kCAYz1booSc+KcBef9I5IPhtefIGWPIArBKEYESoTm134
jTCZr//f37wZDUN3qWxQxrD5frTjhkNz4GOYOy72vL2bwknWj4xU4P6tNd0F+U9u
t7n3J8DQnsw=
=x8Rp
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
