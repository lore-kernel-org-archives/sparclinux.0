From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:13 +0000
Subject: [PATCH 10/14] sparc32: drop sun4c user stack checking routine
Message-Id: <1336772117-1539-10-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With this we no longer do any run-time patchings of traps.
So drop the function + macro to support this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/traps.h |    7 ----
 arch/sparc/kernel/rtrap_32.S   |   76 +++------------------------------------
 arch/sparc/mm/srmmu.c          |   14 -------
 3 files changed, 6 insertions(+), 91 deletions(-)

diff --git a/arch/sparc/include/asm/traps.h b/arch/sparc/include/asm/traps.h
index 3aa62dd..5fac90f 100644
--- a/arch/sparc/include/asm/traps.h
+++ b/arch/sparc/include/asm/traps.h
@@ -31,13 +31,6 @@ extern struct tt_entry *sparc_ttable;
 
 #define SPARC_MOV_CONST_L3(const) (0xa6102000 | (const&0xfff))
 
-/* The following assumes that the branch lies before the place we
- * are branching to.  This is the case for a trap vector...
- * You have been warned.
- */
-#define SPARC_BRANCH(dest_addr, inst_addr) \
-          (0x10800000 | (((dest_addr-inst_addr)>>2)&0x3fffff))
-
 #define SPARC_RD_PSR_L0  (0xa1480000)
 #define SPARC_RD_WIM_L3  (0xa7500000)
 #define SPARC_NOP (0x01000000)
diff --git a/arch/sparc/kernel/rtrap_32.S b/arch/sparc/kernel/rtrap_32.S
index 5f5f74c..7abc24e 100644
--- a/arch/sparc/kernel/rtrap_32.S
+++ b/arch/sparc/kernel/rtrap_32.S
@@ -128,13 +128,12 @@ rtrap_patch2:	and	%glob_tmp, 0xff, %glob_tmp
 
 		wr	%glob_tmp, 0x0, %wim
 
-				/* Here comes the architecture specific 
-				 * branch to the user stack checking routine
-				 * for return from traps.
-				 */
-				.globl	rtrap_mmu_patchme
-rtrap_mmu_patchme:	b	sun4c_rett_stackchk
-				 andcc	%fp, 0x7, %g0	
+	/* Here comes the architecture specific
+	 * branch to the user stack checking routine
+	 * for return from traps.
+	 */
+	b	srmmu_rett_stackchk
+	 andcc	%fp, 0x7, %g0
 
 ret_trap_userwins_ok:
 	LOAD_PT_PRIV(sp, t_psr, t_pc, t_npc)
@@ -225,69 +224,6 @@ ret_trap_user_stack_is_bolixed:
 	b	signal_p
 	 ld	[%curptr + TI_FLAGS], %g2
 
-sun4c_rett_stackchk:
-	be	1f
-	 and	%fp, 0xfff, %g1		! delay slot
-
-	b	ret_trap_user_stack_is_bolixed + 0x4
-	 wr	%t_wim, 0x0, %wim
-
-	/* See if we have to check the sanity of one page or two */
-1:
-	add	%g1, 0x38, %g1
-	sra	%fp, 29, %g2
-	add	%g2, 0x1, %g2
-	andncc	%g2, 0x1, %g0
-	be	1f
-	 andncc	%g1, 0xff8, %g0
-
-	/* %sp is in vma hole, yuck */
-	b	ret_trap_user_stack_is_bolixed + 0x4
-	 wr	%t_wim, 0x0, %wim
-
-1:
-	be	sun4c_rett_onepage	/* Only one page to check */
-	 lda	[%fp] ASI_PTE, %g2
-
-sun4c_rett_twopages:
-	add	%fp, 0x38, %g1
-	sra	%g1, 29, %g2
-	add	%g2, 0x1, %g2
-	andncc	%g2, 0x1, %g0
-	be	1f
-	 lda	[%g1] ASI_PTE, %g2
-
-	/* Second page is in vma hole */
-	b	ret_trap_user_stack_is_bolixed + 0x4
-	 wr	%t_wim, 0x0, %wim
-
-1:
-	srl	%g2, 29, %g2
-	andcc	%g2, 0x4, %g0
-	bne	sun4c_rett_onepage
-	 lda	[%fp] ASI_PTE, %g2
-
-	/* Second page has bad perms */
-	b	ret_trap_user_stack_is_bolixed + 0x4
-	 wr	%t_wim, 0x0, %wim
-
-sun4c_rett_onepage:
-	srl	%g2, 29, %g2
-	andcc	%g2, 0x4, %g0
-	bne,a	1f
-	 restore %g0, %g0, %g0
-
-	/* A page had bad page permissions, losing... */
-	b	ret_trap_user_stack_is_bolixed + 0x4
-	 wr	%t_wim, 0x0, %wim
-
-	/* Whee, things are ok, load the window and continue. */
-1:
-	LOAD_WINDOW(sp)
-
-	b	ret_trap_userwins_ok
-	 save	%g0, %g0, %g0
-
 	.globl	srmmu_rett_stackchk
 srmmu_rett_stackchk:
 	bne	ret_trap_user_stack_is_bolixed
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index deb7dd8..a948ee5 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -2134,19 +2134,6 @@ extern unsigned long spwin_mmu_patchme, fwin_mmu_patchme,
 extern unsigned long spwin_srmmu_stackchk, srmmu_fwin_stackchk,
 	tsetup_srmmu_stackchk, srmmu_rett_stackchk;
 
-#define PATCH_BRANCH(insn, dest) do { \
-		iaddr = &(insn); \
-		daddr = &(dest); \
-		*iaddr = SPARC_BRANCH((unsigned long) daddr, (unsigned long) iaddr); \
-	} while(0)
-
-static void __init patch_window_trap_handlers(void)
-{
-	unsigned long *iaddr, *daddr;
-	
-	PATCH_BRANCH(rtrap_mmu_patchme, srmmu_rett_stackchk);
-}
-
 #ifdef CONFIG_SMP
 /* Local cross-calls. */
 static void smp_flush_page_for_dma(unsigned long page)
@@ -2270,7 +2257,6 @@ void __init ld_mmu_srmmu(void)
 	BTFIXUPSET_CALL(pgoff_to_pte, srmmu_pgoff_to_pte, BTFIXUPCALL_NORM);
 
 	get_srmmu_type();
-	patch_window_trap_handlers();
 
 #ifdef CONFIG_SMP
 	/* El switcheroo... */
-- 
1.6.0.6

