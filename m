From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 02 Feb 2005 21:54:53 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <1107381293.3951.114.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-MpICvw5fH2gJwdWc2oFs"
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
To: sparclinux@vger.kernel.org


--=-MpICvw5fH2gJwdWc2oFs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-02 at 14:04 -0600, Art Haas wrote:
> Hi.
> 
> Here's my attempt at taking Bob Breuer's patch and adding in some of the
> BTFIXUP magic that sparc32 needs. I'm running the current BK kernel with
> this patch on my SS20, and things seem to work. The current kernel
> complains during bootup and shutdown about accessing the system clock,
> a problem I am guessing is related to changes elsewhere in the kernel.

This patch only covers sun4m. The attached patch covers all sparc32.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-MpICvw5fH2gJwdWc2oFs
Content-Disposition: attachment; filename=linux-2.6.10-sparc-pte_read.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-pte_read.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc/mm/srmmu.c.BAD	2005-01-30 13:41:29.238542766 -0500
+++ linux-2.6.10/arch/sparc/mm/srmmu.c	2005-01-30 13:45:57.034831542 -0500
@@ -2197,6 +2197,7 @@
 	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
 
+	BTFIXUPSET_HALF(pte_readi, SRMMU_NOREAD);
 	BTFIXUPSET_HALF(pte_writei, SRMMU_WRITE);
 	BTFIXUPSET_HALF(pte_dirtyi, SRMMU_DIRTY);
 	BTFIXUPSET_HALF(pte_youngi, SRMMU_REF);
--- linux-2.6.10/arch/sparc/mm/sun4c.c.BAD	2005-01-30 13:47:47.488040102 -0500
+++ linux-2.6.10/arch/sparc/mm/sun4c.c	2005-01-30 13:50:42.850380974 -0500
@@ -2225,6 +2225,7 @@
 	BTFIXUPSET_CALL(free_pgd_fast, sun4c_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, sun4c_get_pgd_fast, BTFIXUPCALL_NORM);
 
+	BTFIXUPSET_HALF(pte_readi, _SUN4C_PAGE_READ);
 	BTFIXUPSET_HALF(pte_writei, _SUN4C_PAGE_WRITE);
 	BTFIXUPSET_HALF(pte_dirtyi, _SUN4C_PAGE_MODIFIED);
 	BTFIXUPSET_HALF(pte_youngi, _SUN4C_PAGE_ACCESSED);
--- linux-2.6.10/include/asm-sparc/pgtsrmmu.h.BAD	2005-01-30 12:37:27.924511262 -0500
+++ linux-2.6.10/include/asm-sparc/pgtsrmmu.h	2005-01-30 12:37:35.554351350 -0500
@@ -73,6 +73,7 @@
 #define SRMMU_CACHE        0x80
 #define SRMMU_DIRTY        0x40
 #define SRMMU_REF          0x20
+#define SRMMU_NOREAD       0x10
 #define SRMMU_EXEC         0x08
 #define SRMMU_WRITE        0x04
 #define SRMMU_VALID        0x02 /* SRMMU_ET_PTE */
--- linux-2.6.10/include/asm-sparc/pgtable.h.BAD	2005-01-30 14:19:42.633893678 -0500
+++ linux-2.6.10/include/asm-sparc/pgtable.h	2005-01-30 14:22:17.764310270 -0500
@@ -186,10 +186,31 @@
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
+BTFIXUPDEF_HALF(pte_readi)
 BTFIXUPDEF_HALF(pte_writei)
 BTFIXUPDEF_HALF(pte_dirtyi)
 BTFIXUPDEF_HALF(pte_youngi)
 
+extern int pte_read(pte_t pte) __attribute_const__;
+extern __inline__ int pte_read(pte_t pte)
+{
+	switch (sparc_cpu_model){
+	case sun4:
+	case sun4c:
+		return pte_val(pte) & BTFIXUP_HALF(pte_readi);
+	case sun4d:
+	case sun4e:
+	case sun4m:
+		return !(pte_val(pte) & BTFIXUP_HALF(pte_readi));
+	/* pacify gcc warnings */
+	case sun4u:
+	case sun_unknown:
+	case ap1000:
+	default:
+		return 0;
+	}
+}
+
 extern int pte_write(pte_t pte) __attribute_const__;
 extern __inline__ int pte_write(pte_t pte)
 {

--=-MpICvw5fH2gJwdWc2oFs--

