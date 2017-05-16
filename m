From: Orlando Arias <oarias@knights.ucf.edu>
Date: Tue, 16 May 2017 18:44:47 +0000
Subject: Fix warning caused by stringop-overflow in GCC7
Message-Id: <45f68d36-b2e9-867d-1c53-b372f3601d3e@knights.ucf.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="b0knDwXouS7SUSfHufwhVf2usskrOuQOu"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b0knDwXouS7SUSfHufwhVf2usskrOuQOu
Content-Type: multipart/mixed; boundary="t462elLegc6THanNLwIeWLJNNUd8iMuMN";
 protected-headers="v1"
From: Orlando Arias <oarias@knights.ucf.edu>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Message-ID: <45f68d36-b2e9-867d-1c53-b372f3601d3e@knights.ucf.edu>
Subject: Fix warning caused by stringop-overflow in GCC7

--t462elLegc6THanNLwIeWLJNNUd8iMuMN
Content-Type: multipart/mixed;
 boundary="------------3CC7884366A0B62AB36CC787"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3CC7884366A0B62AB36CC787
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Greetings,

GCC 7 introduced the -Wstringop-overflow flag to detect buffer overflows
in calls to string handling functions [1][2]. Due to the way
``empty_zero_page'' is declared in arch/sparc/include/setup.h, this
causes a warning to trigger at compile time in the function mem_init(),
which is subsequently converted to an error. The attached patch fixes
this issue and aligns the declaration of empty_zero_page to that of
other architectures. Thank you.

Cheers,
Orlando.


[1] https://gcc.gnu.org/ml/gcc-patches/2016-10/msg02308.html
[2] https://gcc.gnu.org/gcc-7/changes.html

--------------3CC7884366A0B62AB36CC787
Content-Type: text/x-patch;
 name="fix-stringop-overflow-error.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="fix-stringop-overflow-error.patch"

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

--------------3CC7884366A0B62AB36CC787--

--t462elLegc6THanNLwIeWLJNNUd8iMuMN--

--b0knDwXouS7SUSfHufwhVf2usskrOuQOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEENr2vryDWdoCclfjWrBtTgQ2vA3UFAlkbSKIACgkQrBtTgQ2v
A3WVVhAAuG0t2cdPTBoTQ6UGbwsi7GljmGWusBlqCys0rYxIrFQ5Vm0z0itqxEyo
zcr97MdmmjCnQgmhWdXuq3tPzrGkF6NAEvUclssCvyeUlS89OoLrKet5Z0wRbB9N
Q/wbhTkEqyJuH3mmnH1WOnNbt0ixnqHXhAfCxZzFI3KiC4MVKDLqq8H5DFaNqMKd
mWKi274xgCwPbDh0YSLslXQbwyZQJ+n5rX0UaMyXybW7ntGH23I3v9k1+NsWFjuA
4MGQBSGFwp6F7BTL0gtj2DqUFgiu36aF5r3DFyOuualWvSm/YWQ9f+Sueak1RH8c
3SMCJ5r+nZ6jKwwJbSHCCYMqqt427mCRq/zQh1PJeA3JsE9OICOPU7/CRcNS6hyf
AHic6E7fIO+Fi79+no/heGce0UsM/tPmI+ALA/LQJQCPyd4rF5DyIxZ2aHzbATq+
EIavxB+QMOGRqJ81jD6lHxF19bV2kSxwG+SK3SwOD5pnDadH5aHlHos7iZhjSvUZ
s1wRcjudv0kL/xMdPKtXCT2sVnlcolr2LujcBECB0//kKJ/L6sA6TNs5kBrSAj/c
zXEwaNPe5YXIYZ3QOrMm/Sp9KO8ntGZjEY2dvvM7WqX8/Lq50a79SBjQIOYGzaR6
NqSQFovNJX8PbY/vKbkn+smoa9YjKA3od/uxVcP1l9+tUAsKjPQ=
=O7i6
-----END PGP SIGNATURE-----

--b0knDwXouS7SUSfHufwhVf2usskrOuQOu--
