From: Jason Wever <weeve@gentoo.org>
Date: Sun, 24 Oct 2004 21:09:05 +0000
Subject: [PATCH] atyfb driver fix for 2.6.10-rc1-bk2
Message-Id: <20041024150905.10299d17@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sun__24_Oct_2004_15_09_05_-0600_oBlVvVcGvZd=lcZS"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Sun__24_Oct_2004_15_09_05_-0600_oBlVvVcGvZd=lcZS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The following patch for the atyfb driver fixes a compile issue in
2.6.10-rc1-bk2.  I've tested it here locally on a Blade 100 and all seems
well from what I can tell.

--- linux-2.6.10-rc1-bk2/drivers/video/aty/atyfb_base.c.orig	2004-10-24 09:51:36.000000000 -0600
+++ linux-2.6.10-rc1-bk2/drivers/video/aty/atyfb_base.c	2004-10-24 12:51:05.000000000 -0600
@@ -2288,7 +2288,7 @@
 			default_par->mmap_map[1].voff =
 			    default_par->mmap_map[0].voff +
 			    info->fix.smem_len;
-			default_par->mmap_map[1].poff =
+			default_par->mmap_map[1].poff = (unsigned long)
 			    default_par->ati_regbase & PAGE_MASK;
 			default_par->mmap_map[1].size = PAGE_SIZE;
 			default_par->mmap_map[1].prot_mask = _PAGE_CACHE;


-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Sun__24_Oct_2004_15_09_05_-0600_oBlVvVcGvZd=lcZS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBfBnzdKvgdVioq28RAtLwAJ9FQW2l8wJ9QR1huiM5HW0DgC54CgCfWZDL
uComf6B3vaYGNaNYFRm+6rM=
=GogR
-----END PGP SIGNATURE-----

--Signature=_Sun__24_Oct_2004_15_09_05_-0600_oBlVvVcGvZd=lcZS--
