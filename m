From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 06:08:40 +0000
Subject: [PATCH 2.6] pte_read confusion resolved (was Re: [PATCH] A
Message-Id: <1109916520.17038.81.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-+7X7kQEhjVtXpqy/G31i"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-+7X7kQEhjVtXpqy/G31i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-02-03 at 01:13 -0800, William Lee Irwin III wrote:
>On Wed, 2005-02-02 at 15:32 -0800, David S. Miller wrote:
>>> I disagree with Tom's patch in that it puts this huge switch()
>>> statement inline.  The whole point of BTFIXUP_HIGH() is that it
>>> resolves the call to a single instruction which can be easily
>>> patched at runtime.
>>> If it's going to expand to multiple BTFIXUP_HIGH() calls and a
>>> switch statement, just make it a normal BTFIXUP() to a function
>>> and place the implementation in sun4c.c and sun4m.c
>
>On Wed, Feb 02, 2005 at 10:22:24PM -0600, Tom 'spot' Callaway wrote:
>> How about this instead?
>> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>
>
>I'll make sure this gets into 2.6.11-final.

The second pte_read patch did not really make it into 2.6.11 final (but
my original patch, which DaveM pointed out as faulty, did). I've made a
new patch which reverts the huge switch inline statement logic, and uses
the normal BTFIXUP instead.

With this patch applied, we should have the preferred pte_read mechanism
in place for sparc32.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-+7X7kQEhjVtXpqy/G31i
Content-Disposition: attachment; filename=linux-2.6.11-sparc-pte_read-cleanup.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-pte_read-cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/arch/sparc/mm/srmmu.c.BAD	2005-03-04 00:56:18.470358835 -0500
+++ linux-2.6.11/arch/sparc/mm/srmmu.c	2005-03-04 01:07:14.347650331 -0500
@@ -161,6 +161,9 @@ static inline int srmmu_pte_none(pte_t p
 static inline int srmmu_pte_present(pte_t pte)
 { return ((pte_val(pte) & SRMMU_ET_MASK) == SRMMU_ET_PTE); }
 
+static inline int srmmu_pte_read(pte_t pte)
+{ return !(pte_val(pte) & SRMMU_NOREAD); }
+
 static inline void srmmu_pte_clear(pte_t *ptep)
 { srmmu_set_pte(ptep, __pte(0)); }
 
@@ -2168,6 +2171,7 @@ void __init ld_mmu_srmmu(void)
 
 	BTFIXUPSET_CALL(pte_present, srmmu_pte_present, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pte_clear, srmmu_pte_clear, BTFIXUPCALL_SWAPO0G0);
+	BTFIXUPSET_CALL(pte_read, srmmu_pte_read, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pmd_bad, srmmu_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, srmmu_pmd_present, BTFIXUPCALL_NORM);
@@ -2198,7 +2202,6 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(free_pgd_fast, srmmu_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, srmmu_get_pgd_fast, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_HALF(pte_readi, SRMMU_NOREAD);
 	BTFIXUPSET_HALF(pte_writei, SRMMU_WRITE);
 	BTFIXUPSET_HALF(pte_dirtyi, SRMMU_DIRTY);
 	BTFIXUPSET_HALF(pte_youngi, SRMMU_REF);
--- linux-2.6.11/arch/sparc/mm/sun4c.c.BAD	2005-03-04 00:57:46.825926747 -0500
+++ linux-2.6.11/arch/sparc/mm/sun4c.c	2005-03-04 01:09:10.874935491 -0500
@@ -1746,6 +1746,11 @@ static int sun4c_pte_present(pte_t pte)
 }
 static void sun4c_pte_clear(pte_t *ptep)	{ *ptep = __pte(0); }
 
+static int sun4c_pte_read(pte_t pte)
+{
+	return (pte_val(pte) & _SUN4C_PAGE_READ);
+}
+
 static int sun4c_pmd_bad(pmd_t pmd)
 {
 	return (((pmd_val(pmd) & ~PAGE_MASK) != PGD_TABLE) ||
@@ -2200,6 +2205,7 @@ void __init ld_mmu_sun4c(void)
 
 	BTFIXUPSET_CALL(pte_present, sun4c_pte_present, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pte_clear, sun4c_pte_clear, BTFIXUPCALL_STG0O0);
+	BTFIXUPSET_CALL(pte_read, sun4c_pte_read, BTFIXUPCALL_NORM);
 
 	BTFIXUPSET_CALL(pmd_bad, sun4c_pmd_bad, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(pmd_present, sun4c_pmd_present, BTFIXUPCALL_NORM);
@@ -2226,7 +2232,6 @@ void __init ld_mmu_sun4c(void)
 	BTFIXUPSET_CALL(free_pgd_fast, sun4c_free_pgd_fast, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(get_pgd_fast, sun4c_get_pgd_fast, BTFIXUPCALL_NORM);
 
-	BTFIXUPSET_HALF(pte_readi, _SUN4C_PAGE_READ);
 	BTFIXUPSET_HALF(pte_writei, _SUN4C_PAGE_WRITE);
 	BTFIXUPSET_HALF(pte_dirtyi, _SUN4C_PAGE_MODIFIED);
 	BTFIXUPSET_HALF(pte_youngi, _SUN4C_PAGE_ACCESSED);
--- linux-2.6.11/include/asm-sparc/pgtable.h.BAD	2005-03-04 01:00:15.687296379 -0500
+++ linux-2.6.11/include/asm-sparc/pgtable.h	2005-03-04 01:08:17.796004715 -0500
@@ -150,6 +150,7 @@ BTFIXUPDEF_CALL_CONST(unsigned long, pgd
 BTFIXUPDEF_SETHI(none_mask)
 BTFIXUPDEF_CALL_CONST(int, pte_present, pte_t)
 BTFIXUPDEF_CALL(void, pte_clear, pte_t *)
+BTFIXUPDEF_CALL(int, pte_read, pte_t)
 
 extern __inline__ int pte_none(pte_t pte)
 {
@@ -158,6 +159,7 @@ extern __inline__ int pte_none(pte_t pte
 
 #define pte_present(pte) BTFIXUP_CALL(pte_present)(pte)
 #define pte_clear(pte) BTFIXUP_CALL(pte_clear)(pte)
+#define pte_read(pte) BTFIXUP_CALL(pte_read)(pte)
 
 BTFIXUPDEF_CALL_CONST(int, pmd_bad, pmd_t)
 BTFIXUPDEF_CALL_CONST(int, pmd_present, pmd_t)
@@ -186,31 +188,10 @@ BTFIXUPDEF_CALL(void, pgd_clear, pgd_t *
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
-BTFIXUPDEF_HALF(pte_readi)
 BTFIXUPDEF_HALF(pte_writei)
 BTFIXUPDEF_HALF(pte_dirtyi)
 BTFIXUPDEF_HALF(pte_youngi)
 
-extern int pte_read(pte_t pte) __attribute_const__;
-extern __inline__ int pte_read(pte_t pte)
-{
-	switch (sparc_cpu_model){
-	case sun4:
-	case sun4c:
-		return pte_val(pte) & BTFIXUP_HALF(pte_readi);
-	case sun4d:
-	case sun4e:
-	case sun4m:
-		return !(pte_val(pte) & BTFIXUP_HALF(pte_readi));
-	/* pacify gcc warnings */
-	case sun4u:
-	case sun_unknown:
-	case ap1000:
-	default:
-		return 0;
-	}
-}
-
 extern int pte_write(pte_t pte) __attribute_const__;
 extern __inline__ int pte_write(pte_t pte)
 {

--=-+7X7kQEhjVtXpqy/G31i--

