From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:11 +0000
Subject: [PATCH 08/14] sparc32: drop sun4c window overflow stack checking routine
Message-Id: <1336772117-1539-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Also drop run-time patching for srmmu

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/wof.S |   72 +---------------------------------------------
 arch/sparc/mm/srmmu.c   |    1 -
 2 files changed, 2 insertions(+), 71 deletions(-)

diff --git a/arch/sparc/kernel/wof.S b/arch/sparc/kernel/wof.S
index 3bbcd8d..4c2de3c 100644
--- a/arch/sparc/kernel/wof.S
+++ b/arch/sparc/kernel/wof.S
@@ -163,9 +163,8 @@ spwin_fromuser:
 	 * the label 'spwin_user_stack_is_bolixed' which will take
 	 * care of things at that point.
 	 */
-	.globl	spwin_mmu_patchme
-spwin_mmu_patchme:	b	spwin_sun4c_stackchk
-				 andcc	%sp, 0x7, %g0
+	b	spwin_srmmu_stackchk
+	 andcc	%sp, 0x7, %g0
 
 spwin_good_ustack:
 	/* LOCATION: Window to be saved */
@@ -306,73 +305,6 @@ spwin_bad_ustack_from_kernel:
  * As noted above %curptr cannot be touched by this routine at all.
  */
 
-spwin_sun4c_stackchk:
-	/* LOCATION: Window to be saved on the stack */
-
-	/* See if the stack is in the address space hole but first,
-	 * check results of callers andcc %sp, 0x7, %g0
-	 */
-	be	1f
-	 sra	%sp, 29, %glob_tmp
-
-	rd	%psr, %glob_tmp
-	b	spwin_user_stack_is_bolixed + 0x4
-	 nop
-
-1:
-	add	%glob_tmp, 0x1, %glob_tmp
-	andncc	%glob_tmp, 0x1, %g0
-	be	1f
-	 and	%sp, 0xfff, %glob_tmp		! delay slot
-
-	rd	%psr, %glob_tmp
-	b	spwin_user_stack_is_bolixed + 0x4
-	 nop
-
-	/* See if our dump area will be on more than one
-	 * page.
-	 */
-1:
-	add	%glob_tmp, 0x38, %glob_tmp
-	andncc	%glob_tmp, 0xff8, %g0
-	be	spwin_sun4c_onepage		! only one page to check
-	 lda	[%sp] ASI_PTE, %glob_tmp	! have to check first page anyways
-
-spwin_sun4c_twopages:
-	/* Is first page ok permission wise? */
-	srl	%glob_tmp, 29, %glob_tmp
-	cmp	%glob_tmp, 0x6
-	be	1f
-	 add	%sp, 0x38, %glob_tmp	/* Is second page in vma hole? */
-
-	rd	%psr, %glob_tmp
-	b	spwin_user_stack_is_bolixed + 0x4
-	 nop
-
-1:
-	sra	%glob_tmp, 29, %glob_tmp
-	add	%glob_tmp, 0x1, %glob_tmp
-	andncc	%glob_tmp, 0x1, %g0
-	be	1f
-	 add	%sp, 0x38, %glob_tmp
-
-	rd	%psr, %glob_tmp
-	b	spwin_user_stack_is_bolixed + 0x4
-	 nop
-
-1:
-	lda	[%glob_tmp] ASI_PTE, %glob_tmp
-
-spwin_sun4c_onepage:
-	srl	%glob_tmp, 29, %glob_tmp
-	cmp	%glob_tmp, 0x6				! can user write to it?
-	be	spwin_good_ustack			! success
-	 nop
-
-	rd	%psr, %glob_tmp
-	b	spwin_user_stack_is_bolixed + 0x4
-	 nop
-
 	/* This is a generic SRMMU routine.  As far as I know this
 	 * works for all current v8/srmmu implementations, we'll
 	 * see...
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index d76af19..43dcb36 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2144,7 +2144,6 @@ static void __init patch_window_trap_handlers(void)
 {
 	unsigned long *iaddr, *daddr;
 	
-	PATCH_BRANCH(spwin_mmu_patchme, spwin_srmmu_stackchk);
 	PATCH_BRANCH(tsetup_mmu_patchme, tsetup_srmmu_stackchk);
 	PATCH_BRANCH(rtrap_mmu_patchme, srmmu_rett_stackchk);
 }
-- 
1.6.0.6

