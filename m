From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:12 +0000
Subject: [PATCH 09/14] sparc32: drop sun4c stack checking routine
Message-Id: <1336772117-1539-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

And drop run-time patching too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/etrap_32.S |   50 +-----------------------------------------
 arch/sparc/mm/srmmu.c        |    1 -
 2 files changed, 1 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/kernel/etrap_32.S b/arch/sparc/kernel/etrap_32.S
index e806fcd..84b5f0d 100644
--- a/arch/sparc/kernel/etrap_32.S
+++ b/arch/sparc/kernel/etrap_32.S
@@ -216,9 +216,7 @@ tsetup_patch6:
 	/* Call MMU-architecture dependent stack checking
 	 * routine.
 	 */
-	.globl	tsetup_mmu_patchme
-tsetup_mmu_patchme:
-	b	tsetup_sun4c_stackchk
+	b	tsetup_srmmu_stackchk
 	 andcc	%sp, 0x7, %g0
 
 	/* Architecture specific stack checking routines.  When either
@@ -228,52 +226,6 @@ tsetup_mmu_patchme:
 	 */
 #define glob_tmp     g1
 
-tsetup_sun4c_stackchk:
-	/* Done by caller: andcc %sp, 0x7, %g0 */
-	bne	trap_setup_user_stack_is_bolixed
-	 sra	%sp, 29, %glob_tmp
-
-	add	%glob_tmp, 0x1, %glob_tmp
-	andncc	%glob_tmp, 0x1, %g0
-	bne	trap_setup_user_stack_is_bolixed
-	 and	%sp, 0xfff, %glob_tmp		! delay slot
-
-	/* See if our dump area will be on more than one
-	 * page.
-	 */
-	add	%glob_tmp, 0x38, %glob_tmp
-	andncc	%glob_tmp, 0xff8, %g0
-	be	tsetup_sun4c_onepage		! only one page to check
-	 lda	[%sp] ASI_PTE, %glob_tmp	! have to check first page anyways
-
-tsetup_sun4c_twopages:
-	/* Is first page ok permission wise? */
-	srl	%glob_tmp, 29, %glob_tmp
-	cmp	%glob_tmp, 0x6
-	bne	trap_setup_user_stack_is_bolixed
-	 add	%sp, 0x38, %glob_tmp		/* Is second page in vma hole? */
-
-	sra	%glob_tmp, 29, %glob_tmp
-	add	%glob_tmp, 0x1, %glob_tmp
-	andncc	%glob_tmp, 0x1, %g0
-	bne	trap_setup_user_stack_is_bolixed
-	 add	%sp, 0x38, %glob_tmp
-
-	lda	[%glob_tmp] ASI_PTE, %glob_tmp
-
-tsetup_sun4c_onepage:
-	srl	%glob_tmp, 29, %glob_tmp
-	cmp	%glob_tmp, 0x6				! can user write to it?
-	bne	trap_setup_user_stack_is_bolixed	! failure
-	 nop
-
-	STORE_WINDOW(sp)
-
-	restore %g0, %g0, %g0
-
-	jmpl	%t_retpc + 0x8, %g0
-	 mov	%t_kstack, %sp
-
 	.globl	tsetup_srmmu_stackchk
 tsetup_srmmu_stackchk:
 	/* Check results of callers andcc %sp, 0x7, %g0 */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 43dcb36..deb7dd8 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2144,7 +2144,6 @@ static void __init patch_window_trap_handlers(void)
 {
 	unsigned long *iaddr, *daddr;
 	
-	PATCH_BRANCH(tsetup_mmu_patchme, tsetup_srmmu_stackchk);
 	PATCH_BRANCH(rtrap_mmu_patchme, srmmu_rett_stackchk);
 }
 
-- 
1.6.0.6

