From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 03 Feb 2005 04:22:24 +0000
Subject: Re: [PATCH] A BTFIXUP'd fix for pte_read()
Message-Id: <1107404544.3951.131.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SVJLpCHUWMsz5sOE0dFX"
List-Id: <sparclinux.vger.kernel.org>
References: <20050202200409.GA30839@artsapartment.org>
In-Reply-To: <20050202200409.GA30839@artsapartment.org>
To: sparclinux@vger.kernel.org


--=-SVJLpCHUWMsz5sOE0dFX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-02-02 at 15:32 -0800, David S. Miller wrote:

> I disagree with Tom's patch in that it puts this huge switch()
> statement inline.  The whole point of BTFIXUP_HIGH() is that it
> resolves the call to a single instruction which can be easily
> patched at runtime.
> 
> If it's going to expand to multiple BTFIXUP_HIGH() calls and a
> switch statement, just make it a normal BTFIXUP() to a function
> and place the implementation in sun4c.c and sun4m.c

How about this instead?

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-SVJLpCHUWMsz5sOE0dFX
Content-Disposition: attachment; filename=linux-2.6.10-sparc-pte_read2.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-pte_read2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc/mm/srmmu.c.BAD	2005-02-02 23:04:32.308346046 -0500
+++ linux-2.6.10/arch/sparc/mm/srmmu.c	2005-02-02 23:05:14.682904134 -0500
@@ -160,6 +160,9 @@
 static inline int srmmu_pte_present(pte_t pte)
 { return ((pte_val(pte) & SRMMU_ET_MASK) == SRMMU_ET_PTE); }
 
+static inline int srmmu_pte_read(pte_t pte)
+{ return !(pte_val(pte) & SRMMU_NOREAD); }
+
 static inline void srmmu_pte_clear(pte_t *ptep)
 { srmmu_set_pte(ptep, __pte(0)); }
 
@@ -2167,6 +2170,7 @@
 
 	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_SWAPO0G0);
+	BTFIXUPSET_CALL(pte_read, srmmu_pte_read, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pmd_bad, srmmu_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, srmmu_pmd_present, BTFIXUPCALL_NORM);
--- linux-2.6.10/arch/sparc/mm/sun4c.c.BAD	2005-02-02 23:04:19.581280854 -0500
+++ linux-2.6.10/arch/sparc/mm/sun4c.c	2005-02-02 23:04:08.354987510 -0500
@@ -1745,6 +1745,11 @@
 }
 static void sun4c_pte_clear(pte_t *ptep)	{ *ptep = __pte(0); }
 
+static int sun4c_pte_read(pte_t pte)
+{
+        return (pte_val(pte) & _SUN4C_PAGE_READ);
+}
+
 static int sun4c_pmd_bad(pmd_t pmd)
 {
 	return (((pmd_val(pmd) & ~PAGE_MASK) != PGD_TABLE) ||
@@ -2199,6 +2204,7 @@
 
 	BTFIXUPSET_CALL(pte_present, sun4c_pte_present, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pte_clear, sun4c_pte_clear, BTFIXUPCALL_STG0O0);
+	BTFIXUPSET_CALL(pte_read, sun4c_pte_read, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pmd_bad, sun4c_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, sun4c_pmd_present, BTFIXUPCALL_NORM);
--- linux-2.6.10/include/asm-sparc/pgtable.h.BAD	2005-02-02 23:07:05.633037150 -0500
+++ linux-2.6.10/include/asm-sparc/pgtable.h	2005-02-02 23:08:32.685803118 -0500
@@ -150,6 +150,7 @@
 BTFIXUPDEF_SETHI(none_mask)
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
 BTFIXUPDEF_CALL(void, pte_clear, pte_t *)
+BTFIXUPDEF_CALL(int, pte_read, pte_t)
 
 extern __inline__ int pte_none(pte_t pte)
 {
@@ -158,6 +159,7 @@
 
 #define pte_present(pte) BTFIXUP_CALL(pte_present)(pte)
 #define pte_clear(pte) BTFIXUP_CALL(pte_clear)(pte)
+#define pte_read(pte) BTFIXUP_CALL(pte_read)(pte)
 
 BTFIXUPDEF_CALL_CONST(int, pmd_bad, pmd_t)
 BTFIXUPDEF_CALL_CONST(int, pmd_present, pmd_t)
--- linux-2.6.10/include/asm-sparc/pgtsrmmu.h.BAD	2005-02-02 23:08:51.855888822 -0500
+++ linux-2.6.10/include/asm-sparc/pgtsrmmu.h	2005-02-02 22:46:44.398692990 -0500
@@ -73,6 +73,7 @@
 #define SRMMU_CACHE        0x80
 #define SRMMU_DIRTY        0x40
 #define SRMMU_REF          0x20
+#define SRMMU_NOREAD       0x10
 #define SRMMU_EXEC         0x08
 #define SRMMU_WRITE        0x04
 #define SRMMU_VALID        0x02 /* SRMMU_ET_PTE */

--=-SVJLpCHUWMsz5sOE0dFX--

