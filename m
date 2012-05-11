From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:10 +0000
Subject: [PATCH 07/14] sparc32: drop sun4c specific stack validation
Message-Id: <1336772117-1539-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This allwos us to kill run-time patching for this function too

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/wuf.S |   60 ++--------------------------------------------
 arch/sparc/mm/srmmu.c   |    1 -
 2 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/arch/sparc/kernel/wuf.S b/arch/sparc/kernel/wuf.S
index 779ff75..9fde91a 100644
--- a/arch/sparc/kernel/wuf.S
+++ b/arch/sparc/kernel/wuf.S
@@ -131,12 +131,9 @@ fwin_from_user:
 
 	/* LOCATION: Window 'W' */
 
-	/* Branch to the architecture specific stack validation
-	 * routine.  They can be found below...
-	 */
-	.globl	fwin_mmu_patchme
-fwin_mmu_patchme:	b	sun4c_fwin_stackchk
-				 andcc	%sp, 0x7, %g0
+	/* Branch to the stack validation routine */
+	b	srmmu_fwin_stackchk
+	 andcc	%sp, 0x7, %g0
 
 #define STACK_OFFSET (THREAD_SIZE - TRACEREG_SZ - STACKFRAME_SZ)
 
@@ -242,57 +239,6 @@ fwin_user_finish_up:
 	 * 'someone elses' window possibly.
 	 */
 
-	.align	4
-sun4c_fwin_stackchk:
-	/* LOCATION: Window 'W' */
-
-	/* Caller did 'andcc %sp, 0x7, %g0' */
-	be	1f
-	 and	%sp, 0xfff, %l0		! delay slot
-
-	b,a	fwin_user_stack_is_bolixed
-
-	/* See if we have to check the sanity of one page or two */
-1:
-	add	%l0, 0x38, %l0
-	sra	%sp, 29, %l5
-	add	%l5, 0x1, %l5
-	andncc	%l5, 0x1, %g0
-	be	1f
-	 andncc	%l0, 0xff8, %g0
-
-	b,a	fwin_user_stack_is_bolixed	/* %sp is in vma hole, yuck */
-
-1:
-	be	sun4c_fwin_onepage	/* Only one page to check */
-	 lda	[%sp] ASI_PTE, %l1
-sun4c_fwin_twopages:
-	add	%sp, 0x38, %l0
-	sra	%l0, 29, %l5
-	add	%l5, 0x1, %l5
-	andncc	%l5, 0x1, %g0
-	be	1f
-	 lda	[%l0] ASI_PTE, %l1
-
-	b,a	fwin_user_stack_is_bolixed	/* Second page in vma hole */
-
-1:
-	srl	%l1, 29, %l1
-	andcc	%l1, 0x4, %g0
-	bne	sun4c_fwin_onepage
-	 lda	[%sp] ASI_PTE, %l1	
-
-	b,a	fwin_user_stack_is_bolixed	/* Second page has bad perms */
-
-sun4c_fwin_onepage:
-	srl	%l1, 29, %l1
-	andcc	%l1, 0x4, %g0
-	bne	fwin_user_stack_is_ok
-	 nop
-
-	/* A page had bad page permissions, losing... */
-	b,a	fwin_user_stack_is_bolixed
-
 	.globl	srmmu_fwin_stackchk
 srmmu_fwin_stackchk:
 	/* LOCATION: Window 'W' */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 7fd4cc3..d76af19 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2145,7 +2145,6 @@ static void __init patch_window_trap_handlers(void)
 	unsigned long *iaddr, *daddr;
 	
 	PATCH_BRANCH(spwin_mmu_patchme, spwin_srmmu_stackchk);
-	PATCH_BRANCH(fwin_mmu_patchme, srmmu_fwin_stackchk);
 	PATCH_BRANCH(tsetup_mmu_patchme, tsetup_srmmu_stackchk);
 	PATCH_BRANCH(rtrap_mmu_patchme, srmmu_rett_stackchk);
 }
-- 
1.6.0.6

