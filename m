From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 06 May 2004 22:37:52 +0000
Subject: [PATCH] Major warning fixes for sparc64 [3/4]
Message-Id: <20040506223752.GC29131@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3yNHWXBV/QO9xKNm"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--3yNHWXBV/QO9xKNm
Content-Type: multipart/mixed; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

patch 3: Fixes a pile of lvalue casts in asm-sparc64/pgalloc.h.

This is a backport of DaveM's fix for 2.6's pgalloc.h, which is slightly
different due to the different interfaces used. I think I got it right
though, and I've compiled a kernel with this patch that seems to work
alright.

I probably got something wrong anyway, though. :)

--=20
Joshua Kwan

--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="03_sparc64_lvalue_casts.diff"
Content-Transfer-Encoding: quoted-printable

--- kernel-source-2.4.26/include/asm-sparc64/pgalloc.h~	2004-04-25 17:01:53=
=2E000000000 -0700
+++ kernel-source-2.4.26/include/asm-sparc64/pgalloc.h	2004-04-25 17:08:16.=
000000000 -0700
@@ -147,11 +147,11 @@
 	struct page *page =3D virt_to_page(pgd);
=20
 	if (!page->pprev_hash) {
-		(unsigned long *)page->next_hash =3D pgd_quicklist;
+		page->next_hash =3D (struct page *)pgd_quicklist;
 		pgd_quicklist =3D (unsigned long *)page;
 	}
-	(unsigned long)page->pprev_hash |=3D
-		(((unsigned long)pgd & (PAGE_SIZE / 2)) ? 2 : 1);
+	page->pprev_hash =3D (struct page **)(((unsigned long)page->pprev_hash) |
+	    (((unsigned long)pgd & (PAGE_SIZE / 2)) ? 2 : 1));
 	pgd_cache_size++;
 }
=20
@@ -169,7 +169,7 @@
 			off =3D PAGE_SIZE / 2;
 			mask &=3D ~2;
 		}
-		(unsigned long)ret->pprev_hash =3D mask;
+		ret->pprev_hash =3D (struct page **)mask;
 		if (!mask)
 			pgd_quicklist =3D (unsigned long *)ret->next_hash;
                 ret =3D (struct page *)(__page_address(ret) + off);
@@ -180,8 +180,8 @@
 		if (page) {
 			ret =3D (struct page *)page_address(page);
 			clear_page(ret);
-			(unsigned long)page->pprev_hash =3D 2;
-			(unsigned long *)page->next_hash =3D pgd_quicklist;
+			page->pprev_hash =3D (struct page **) 2UL;
+			page->next_hash =3D (struct page *) pgd_quicklist;
 			pgd_quicklist =3D (unsigned long *)page;
 			pgd_cache_size++;
 		}

--T6xhMxlHU34Bk0ad--

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJq+PqOILr94RG8mAQLqkA/9HkR1j5JS3ylrhyM3+6q/5sg02/LPQqzT
XH8tKFaQNfMTz2JEe2il4iQy3U40SpdUtDjzOr9GSlx0helZ2i6GIoZbgdaEVLqs
xoCUkM18Pfpom4uMWFTsZi7nhthFqICnvHAbenV5sg1MtVtOlMtIiAXcRW5IGDF9
vxlWu+Ab/TuJQH4Ih5A31+KDiWPU9H7SbM7wr8kMpGM8E83UqM5TAeCoWB37Na3A
oxyRdthMgkFuWdxqUZfautixAnHI3UuA1H2IqLt76LZAbhFUX3OIuTorChXpzYzH
LzGzTvGriVUVnZT6QvGXsXpK6AbSnuiB7e+33xTlKTvbhjQa8y+w1HOBJXSS0umi
HPqebefPdNf/CcYnbBlcXJ7fncmsy3frpvZiHpTnIOJeGwZoO+p3GeQu+IY1DSaM
UEAdapZaQOcVFbl/KzHjndBQAaeHrOSrKMAu0UcDFSOCm+7GM95BpieQcc/LgHG/
AxdeFPz6gf+iDBW1LwdTWG9RzZ36Yl1ZnhHjrjr7oBZNVPdh08BoWjtL1UfIoMvi
Kda19QNPe5zzrGqTeC/VOkunRXn4dpkAes2tgsaBAvwsuW1vHyegGOKGqJj6FIAN
HvlW6a/B7MOiTTXE7OP/xhXs2kW3CDR2VelFxl69eHNruKYUvJLp6SRXLBliVGsn
gfwPnhDk0Iw=
=oNhp
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--
