From: Ciaran McCreesh <ciaranm@gentoo.org>
Date: Tue, 30 Dec 2003 19:45:50 +0000
Subject: [2.6.0] Huge TLB != 4M Fix
Message-Id: <20031230194550.0b20a913@snowdrop.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__30_Dec_2003_19_45_50_+0000_n+Tlvk6q9boow+Uj"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Signature=_Tue__30_Dec_2003_19_45_50_+0000_n+Tlvk6q9boow+Uj
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__30_Dec_2003_19_45_50_+0000_jzVH+7X/fp1kiYwl"


--Multipart=_Tue__30_Dec_2003_19_45_50_+0000_jzVH+7X/fp1kiYwl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

With 2.6.0 (plus Keith's patches) on sparc64, I get compile errors if
CONFIG_HUGETLB_PAGE_SIZE is set to other than 4MB:

  CC      arch/sparc64/mm/generic.o
  CC      arch/sparc64/mm/hugetlbpage.o
arch/sparc64/mm/hugetlbpage.c: In function `set_huge_pte':
arch/sparc64/mm/hugetlbpage.c:130: error: `_PAGE_64K' undeclared (first
use in this function) arch/sparc64/mm/hugetlbpage.c:130: error: (Each
undeclared identifier is reported only once
arch/sparc64/mm/hugetlbpage.c:130: error: for each function it appears
in.) make[1]: *** [arch/sparc64/mm/hugetlbpage.o] Error 1
make: *** [arch/sparc64/mm] Error 2

The attached patch fixes this.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm

--Multipart=_Tue__30_Dec_2003_19_45_50_+0000_jzVH+7X/fp1kiYwl
Content-Type: text/x-diff;
 name="linux-2.6-sparc-tlb-fix.patch"
Content-Disposition: attachment;
 filename="linux-2.6-sparc-tlb-fix.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-sparc/include/asm-sparc64/pgtable.h.orig	2003-12-30 17:51:45.176375000 +0000
+++ linux-2.6.0-sparc/include/asm-sparc64/pgtable.h	2003-12-30 17:52:26.396375000 +0000
@@ -145,9 +145,9 @@
 #if defined(CONFIG_HUGETLB_PAGE_SIZE_4MB)
 #define _PAGE_SZHUGE	_PAGE_SZ4MB
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_512K)
-#define _PAGE_SZHUGE	_PAGE_512K
+#define _PAGE_SZHUGE	_PAGE_SZ512K
 #elif defined(CONFIG_HUGETLB_PAGE_SIZE_64K)
-#define _PAGE_SZHUGE	_PAGE_64K
+#define _PAGE_SZHUGE	_PAGE_SZ64K
 #endif
 
 #define _PAGE_CACHE	(_PAGE_CP | _PAGE_CV)

--Multipart=_Tue__30_Dec_2003_19_45_50_+0000_jzVH+7X/fp1kiYwl--

--Signature=_Tue__30_Dec_2003_19_45_50_+0000_n+Tlvk6q9boow+Uj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8dXz96zL6DUtXhERAlwzAKC2rt+MET2SStNfv2HxXvG8yrDTqgCfTL5J
AQ3/gusjQ1gMhjVBHKnWOA8=
=0ylC
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Dec_2003_19_45_50_+0000_n+Tlvk6q9boow+Uj--
