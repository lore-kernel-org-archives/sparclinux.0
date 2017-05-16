From: Orlando Arias <oarias@knights.ucf.edu>
Date: Tue, 16 May 2017 19:34:00 +0000
Subject: [PATCH sparc] sparc: Fix -Wstringop-overflow warning
Message-Id: <98e7b774-29c5-b669-1bf6-24c1c3f1409e@knights.ucf.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="O4RN0qtDDLXwetkTVJnMOXS2Prvo9D7tD"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O4RN0qtDDLXwetkTVJnMOXS2Prvo9D7tD
Content-Type: multipart/mixed; boundary="mbIaeQ5b58svr3QURL2EngwUaBe8OXQvF";
 protected-headers="v1"
From: Orlando Arias <oarias@knights.ucf.edu>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Message-ID: <98e7b774-29c5-b669-1bf6-24c1c3f1409e@knights.ucf.edu>
Subject: [PATCH sparc] sparc: Fix -Wstringop-overflow warning

--mbIaeQ5b58svr3QURL2EngwUaBe8OXQvF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Greetings,

GCC 7 introduced the -Wstringop-overflow flag to detect buffer overflows
in calls to string handling functions [1][2]. Due to the way
``empty_zero_page'' is declared in arch/sparc/include/setup.h, this
causes a warning to trigger at compile time in the function mem_init(),
which is subsequently converted to an error. The ensuing patch fixes
this issue and aligns the declaration of empty_zero_page to that of
other architectures. Thank you.

Cheers,
Orlando.


[1] https://gcc.gnu.org/ml/gcc-patches/2016-10/msg02308.html
[2] https://gcc.gnu.org/gcc-7/changes.html


Signed-off-by: Orlando Arias <oarias@knights.ucf.edu>

-------------------------------------------------------------------------=
-------
diff -rupN linux-4.11.1-pristine/arch/sparc/include/asm/pgtable_32.h linu=
x-4.11.1-modified/arch/sparc/include/asm/pgtable_32.h
--- linux-4.11.1-pristine/arch/sparc/include/asm/pgtable_32.h	2017-05-14 =
08:06:16.000000000 -0400
+++ linux-4.11.1-modified/arch/sparc/include/asm/pgtable_32.h	2017-05-16 =
14:08:21.220784497 -0400
@@ -91,9 +91,9 @@ extern unsigned long pfn_base;
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page;
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];=

=20
-#define ZERO_PAGE(vaddr) (virt_to_page(&empty_zero_page))
+#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
=20
 /*
  * In general all page table modifications should use the V8 atomic
diff -rupN linux-4.11.1-pristine/arch/sparc/include/asm/setup.h linux-4.1=
1.1-modified/arch/sparc/include/asm/setup.h
--- linux-4.11.1-pristine/arch/sparc/include/asm/setup.h	2017-05-14 08:06=
:16.000000000 -0400
+++ linux-4.11.1-modified/arch/sparc/include/asm/setup.h	2017-05-16 14:05=
:31.887441581 -0400
@@ -16,7 +16,7 @@ extern char reboot_command[];
  */
 extern unsigned char boot_cpu_id;
=20
-extern unsigned long empty_zero_page;
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];=

=20
 extern int serial_console;
 static inline int con_is_present(void)
diff -rupN linux-4.11.1-pristine/arch/sparc/mm/init_32.c linux-4.11.1-mod=
ified/arch/sparc/mm/init_32.c
--- linux-4.11.1-pristine/arch/sparc/mm/init_32.c	2017-05-14 08:06:16.000=
000000 -0400
+++ linux-4.11.1-modified/arch/sparc/mm/init_32.c	2017-05-16 14:06:02.497=
443313 -0400
@@ -290,7 +290,7 @@ void __init mem_init(void)
=20
=20
 	/* Saves us work later. */
-	memset((void *)&empty_zero_page, 0, PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
=20
 	i =3D last_valid_pfn >> ((20 - PAGE_SHIFT) + 5);
 	i +=3D 1;


--mbIaeQ5b58svr3QURL2EngwUaBe8OXQvF--

--O4RN0qtDDLXwetkTVJnMOXS2Prvo9D7tD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEENr2vryDWdoCclfjWrBtTgQ2vA3UFAlkbVC4ACgkQrBtTgQ2v
A3Vvug/9EJrFOgPxEY/IP1Wry497Wp6k/a8Ju4f0geRHIIKk04587Zdm9cb7qqlK
0rLKMbcpLJHWbXZiDXGAoMEep9SBdjkhOjetZXc/jMMtl5v/m1vVLiJS/D5+sTpx
dDcC2LNrh4MDWUBMss77hO9R2CT+iCY/cTTRbbT7wv3PjtAU0Raw751P9baCxyoB
/IQmaa3q4ae4LyOlvdHb606XZ044nvrMTY1TFLjdI08KiH6A6wetVzoxShsmYCzQ
PmlB8VW2pwefQpaY4AwsOw+3r38XYpIpRUFyk3elD5ILPGnLNis2Dx5EOZhZgrUf
UnKPkpe3fIW4hSpkSQGE+zQG1OmXlB+5gBBeI/7F/jEeKtPRz47OmIpjFVnHSZqL
ulFYY8DSuokTQSUFmVJk4xYtbuF5dlj6SuhyLhwwS+kMDua+OLJSSaIZjXCZ5W8T
d4uBAVfXJlf9RWTazvZizBCBL1Ukcl+IWEyKdUm7JQdoCmNidKiOvxoCIJEPtxxP
H5IIIFErlly6f/yjnyPAJNDkQLUfEqU6hJmpaf61oeqC5G9OFpLYhYEe6iuvlGgK
3O4jhydDQXUp0c66ZAmNZK7NRY1bU0sZQiTFcOLJiczc6+EvF9yGTQ3VbTmuOTIy
2iVy5oGIo5wgbFjaZfGFHNizmYhioqnhkAewCjkL0BLYHlG4jn4=
=XLNz
-----END PGP SIGNATURE-----

--O4RN0qtDDLXwetkTVJnMOXS2Prvo9D7tD--
