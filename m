From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 06 May 2004 22:35:35 +0000
Subject: [PATCH] Use $(CC) in check for egcs/gcc3 [2/4]
Message-Id: <20040506223535.GB29131@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EP0wieDxd4TSJjHq"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: multipart/mixed; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

patch 2: use $(CC) in check for egcs/gcc3

The makefile currentsly hardcodes 'gcc' in its test. This is not good if
'gcc' points to an i386-linux-gcc :)

(The patch explains itself. However, note that it doesn't address)

--=20
Joshua Kwan

--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02_sparc64_use_CC.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/arch/sparc64/Makefile	2004-04-25 16:41:16.00000000=
0 -0700
+++ kernel-source-2.4.26/arch/sparc64/Makefile~	2004-04-25 16:40:52.0000000=
00 -0700
@@ -12,7 +12,7 @@
 # line...
 SHELL  =3D/bin/bash
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

--FsscpQKzF/jJk6ya--

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJq9taOILr94RG8mAQKdAw/8DzDYTRXlOUbN6hNGKBP9KCUYR6txsMfK
ZwlqTrEDMg/T85jxyEjyPqhf6kI2CIEXSGrmiL8DdlEYt55J+45p4tRFzdzPZHse
ZKzp6QCzts5OIc0J9/vlVHysyGZ8a6ojb0Pv7qQcyCWXxv5wH46Xe5GHtTfAvAIu
JgjLuStUTqHeaNlqS8LMSDgSwsJq1KdV7DBDlQMAs1PtgzvYbjYAK09sfnBg1KTO
Jln4HU0/hBRAiVisz51PcI8B48B1anXN/2JvNu/GASlUMCGEM7621metiwbkLKCD
8IJP+rgThZwSuVveUfwA8hNU6miswR0wNxFvWTqHiqLFR3I8lFgw/ecriqeMp294
WNwJfkXAfG53AE4M7oLFTtqXkh63L3+bzVuNJl1HTeIML5QzdvxeSXwLXBwB9ax6
bz10Bz/MCLQGwzj8/DAiRBhOWnBgizTWyc8Z/1YIBoNWdkJqJwcnFf4Gy5A1cudp
SO8mm/TUsOlSQ4F2CYTxmxWymx8z2rVVYjePL7r4e6hneLU3QqfzqRhw3TERapcy
HObAVGpNl3hA6md/qft9/JUkRMvRCrVQBUoObIYUoZSGnDmw3OX2hwZ2ClvzEC3C
l+YworHV2ui/dw8JLg4WzCGQaxHG7LEwcUE1nQTSUUTnWXVubuclBc4gZfcXSRUM
W3u3KoD+LmY=
=yP/U
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
