From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:16 +0000
Subject: [PATCH 12/15] sparc32: introduce support for run-time patching for all shared assembler code
Message-Id: <1338016819-22245-12-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All users of MMUREGS ASI in kernel/ now uses run-time patching.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/entry.S    |    7 +++++--
 arch/sparc/kernel/etrap_32.S |   18 +++++++++++++-----
 arch/sparc/kernel/rtrap_32.S |   18 ++++++++++++------
 arch/sparc/kernel/wof.S      |   18 ++++++++++++------
 arch/sparc/kernel/wuf.S      |   27 +++++++++++++++++----------
 5 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 8550f10..dcaa1cf 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -767,8 +767,11 @@ srmmu_fault:
 	mov	0x400, %l5
 	mov	0x300, %l4
 
-	lda	[%l5] ASI_M_MMUREGS, %l6	! read sfar first
-	lda	[%l4] ASI_M_MMUREGS, %l5	! read sfsr last
+LEON_PI(lda	[%l5] ASI_LEON_MMUREGS, %l6)	! read sfar first
+SUN_PI_(lda	[%l5] ASI_M_MMUREGS, %l6)	! read sfar first
+
+LEON_PI(lda	[%l4] ASI_LEON_MMUREGS, %l5)	! read sfsr last
+SUN_PI_(lda	[%l4] ASI_M_MMUREGS, %l5)	! read sfsr last
 
 	andn	%l6, 0xfff, %l6
 	srl	%l5, 6, %l5			! and encode all info into l7
diff --git a/arch/sparc/kernel/etrap_32.S b/arch/sparc/kernel/etrap_32.S
index 84b5f0d..e3e80d6 100644
--- a/arch/sparc/kernel/etrap_32.S
+++ b/arch/sparc/kernel/etrap_32.S
@@ -234,7 +234,8 @@ tsetup_srmmu_stackchk:
 
 	cmp	%glob_tmp, %sp
 	bleu,a	1f
-	 lda	[%g0] ASI_M_MMUREGS, %glob_tmp		! read MMU control
+LEON_PI( lda	[%g0] ASI_LEON_MMUREGS, %glob_tmp)	! read MMU control
+SUN_PI_( lda	[%g0] ASI_M_MMUREGS, %glob_tmp)		! read MMU control
 
 trap_setup_user_stack_is_bolixed:
 	/* From user/kernel into invalid window w/bad user
@@ -249,18 +250,25 @@ trap_setup_user_stack_is_bolixed:
 1:
 	/* Clear the fault status and turn on the no_fault bit. */
 	or	%glob_tmp, 0x2, %glob_tmp		! or in no_fault bit
-	sta	%glob_tmp, [%g0] ASI_M_MMUREGS		! set it
+LEON_PI(sta	%glob_tmp, [%g0] ASI_LEON_MMUREGS)		! set it
+SUN_PI_(sta	%glob_tmp, [%g0] ASI_M_MMUREGS)		! set it
 
 	/* Dump the registers and cross fingers. */
 	STORE_WINDOW(sp)
 
 	/* Clear the no_fault bit and check the status. */
 	andn	%glob_tmp, 0x2, %glob_tmp
-	sta	%glob_tmp, [%g0] ASI_M_MMUREGS
+LEON_PI(sta	%glob_tmp, [%g0] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%glob_tmp, [%g0] ASI_M_MMUREGS)
+
 	mov	AC_M_SFAR, %glob_tmp
-	lda	[%glob_tmp] ASI_M_MMUREGS, %g0
+LEON_PI(lda	[%glob_tmp] ASI_LEON_MMUREGS, %g0)
+SUN_PI_(lda	[%glob_tmp] ASI_M_MMUREGS, %g0)
+
 	mov	AC_M_SFSR, %glob_tmp
-	lda	[%glob_tmp] ASI_M_MMUREGS, %glob_tmp	! save away status of winstore
+LEON_PI(lda	[%glob_tmp] ASI_LEON_MMUREGS, %glob_tmp)! save away status of winstore
+SUN_PI_(lda	[%glob_tmp] ASI_M_MMUREGS, %glob_tmp)	! save away status of winstore
+
 	andcc	%glob_tmp, 0x2, %g0			! did we fault?
 	bne	trap_setup_user_stack_is_bolixed	! failure
 	 nop
diff --git a/arch/sparc/kernel/rtrap_32.S b/arch/sparc/kernel/rtrap_32.S
index 7abc24e..6c34de0 100644
--- a/arch/sparc/kernel/rtrap_32.S
+++ b/arch/sparc/kernel/rtrap_32.S
@@ -231,11 +231,14 @@ srmmu_rett_stackchk:
 	cmp	%g1, %fp
 	bleu	ret_trap_user_stack_is_bolixed
 	 mov	AC_M_SFSR, %g1
-	lda	[%g1] ASI_M_MMUREGS, %g0
+LEON_PI(lda	[%g1] ASI_LEON_MMUREGS, %g0)
+SUN_PI_(lda	[%g1] ASI_M_MMUREGS, %g0)
 
-	lda	[%g0] ASI_M_MMUREGS, %g1
+LEON_PI(lda	[%g0] ASI_LEON_MMUREGS, %g1)
+SUN_PI_(lda	[%g0] ASI_M_MMUREGS, %g1)
 	or	%g1, 0x2, %g1
-	sta	%g1, [%g0] ASI_M_MMUREGS
+LEON_PI(sta	%g1, [%g0] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%g1, [%g0] ASI_M_MMUREGS)
 
 	restore	%g0, %g0, %g0
 
@@ -244,13 +247,16 @@ srmmu_rett_stackchk:
 	save	%g0, %g0, %g0
 
 	andn	%g1, 0x2, %g1
-	sta	%g1, [%g0] ASI_M_MMUREGS
+LEON_PI(sta	%g1, [%g0] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%g1, [%g0] ASI_M_MMUREGS)
 
 	mov	AC_M_SFAR, %g2
-	lda	[%g2] ASI_M_MMUREGS, %g2
+LEON_PI(lda	[%g2] ASI_LEON_MMUREGS, %g2)
+SUN_PI_(lda	[%g2] ASI_M_MMUREGS, %g2)
 
 	mov	AC_M_SFSR, %g1
-	lda	[%g1] ASI_M_MMUREGS, %g1
+LEON_PI(lda	[%g1] ASI_LEON_MMUREGS, %g1)
+SUN_PI_(lda	[%g1] ASI_M_MMUREGS, %g1)
 	andcc	%g1, 0x2, %g0
 	be	ret_trap_userwins_ok
 	 nop
diff --git a/arch/sparc/kernel/wof.S b/arch/sparc/kernel/wof.S
index 4c2de3c..28a7bc6 100644
--- a/arch/sparc/kernel/wof.S
+++ b/arch/sparc/kernel/wof.S
@@ -332,24 +332,30 @@ spwin_srmmu_stackchk:
 	 mov	AC_M_SFSR, %glob_tmp
 
 	/* Clear the fault status and turn on the no_fault bit. */
-	lda	[%glob_tmp] ASI_M_MMUREGS, %g0		! eat SFSR
+LEON_PI(lda	[%glob_tmp] ASI_LEON_MMUREGS, %g0)	! eat SFSR
+SUN_PI_(lda	[%glob_tmp] ASI_M_MMUREGS, %g0)		! eat SFSR
 
-	lda	[%g0] ASI_M_MMUREGS, %glob_tmp		! read MMU control
+LEON_PI(lda	[%g0] ASI_LEON_MMUREGS, %glob_tmp)	! read MMU control
+SUN_PI_(lda	[%g0] ASI_M_MMUREGS, %glob_tmp)		! read MMU control
 	or	%glob_tmp, 0x2, %glob_tmp		! or in no_fault bit
-	sta	%glob_tmp, [%g0] ASI_M_MMUREGS		! set it
+LEON_PI(sta	%glob_tmp, [%g0] ASI_LEON_MMUREGS)	! set it
+SUN_PI_(sta	%glob_tmp, [%g0] ASI_M_MMUREGS)		! set it
 
 	/* Dump the registers and cross fingers. */
 	STORE_WINDOW(sp)
 
 	/* Clear the no_fault bit and check the status. */
 	andn	%glob_tmp, 0x2, %glob_tmp
-	sta	%glob_tmp, [%g0] ASI_M_MMUREGS
+LEON_PI(sta	%glob_tmp, [%g0] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%glob_tmp, [%g0] ASI_M_MMUREGS)
 
 	mov	AC_M_SFAR, %glob_tmp
-	lda	[%glob_tmp] ASI_M_MMUREGS, %g0
+LEON_PI(lda	[%glob_tmp] ASI_LEON_MMUREGS, %g0)
+SUN_PI_(lda	[%glob_tmp] ASI_M_MMUREGS, %g0)
 
 	mov	AC_M_SFSR, %glob_tmp
-	lda	[%glob_tmp] ASI_M_MMUREGS, %glob_tmp
+LEON_PI(lda	[%glob_tmp] ASI_LEON_MMUREGS, %glob_tmp)
+SUN_PI_(lda	[%glob_tmp] ASI_M_MMUREGS, %glob_tmp)
 	andcc	%glob_tmp, 0x2, %g0			! did we fault?
 	be,a	spwin_finish_up + 0x4			! cool beans, success
 	 restore %g0, %g0, %g0
diff --git a/arch/sparc/kernel/wuf.S b/arch/sparc/kernel/wuf.S
index 9fde91a..2c21cc5 100644
--- a/arch/sparc/kernel/wuf.S
+++ b/arch/sparc/kernel/wuf.S
@@ -254,16 +254,19 @@ srmmu_fwin_stackchk:
 	mov	AC_M_SFSR, %l4
 	cmp	%l5, %sp
 	bleu	fwin_user_stack_is_bolixed
-	 lda	[%l4] ASI_M_MMUREGS, %g0	! clear fault status
+LEON_PI( lda	[%l4] ASI_LEON_MMUREGS, %g0)	! clear fault status
+SUN_PI_( lda	[%l4] ASI_M_MMUREGS, %g0)	! clear fault status
 
 	/* The technique is, turn off faults on this processor,
 	 * just let the load rip, then check the sfsr to see if
 	 * a fault did occur.  Then we turn on fault traps again
 	 * and branch conditionally based upon what happened.
 	 */
-	lda	[%g0] ASI_M_MMUREGS, %l5	! read mmu-ctrl reg
+LEON_PI(lda	[%g0] ASI_LEON_MMUREGS, %l5)	! read mmu-ctrl reg
+SUN_PI_(lda	[%g0] ASI_M_MMUREGS, %l5)	! read mmu-ctrl reg
 	or	%l5, 0x2, %l5			! turn on no-fault bit
-	sta	%l5, [%g0] ASI_M_MMUREGS	! store it
+LEON_PI(sta	%l5, [%g0] ASI_LEON_MMUREGS)	! store it
+SUN_PI_(sta	%l5, [%g0] ASI_M_MMUREGS)	! store it
 
 	/* Cross fingers and go for it. */
 	LOAD_WINDOW(sp)
@@ -275,18 +278,22 @@ srmmu_fwin_stackchk:
 
 	/* LOCATION: Window 'T' */
 
-	lda	[%g0] ASI_M_MMUREGS, %twin_tmp1	! load mmu-ctrl again
-	andn	%twin_tmp1, 0x2, %twin_tmp1	! clear no-fault bit
-	sta	%twin_tmp1, [%g0] ASI_M_MMUREGS	! store it
+LEON_PI(lda	[%g0] ASI_LEON_MMUREGS, %twin_tmp1)	! load mmu-ctrl again
+SUN_PI_(lda	[%g0] ASI_M_MMUREGS, %twin_tmp1)	! load mmu-ctrl again
+	andn	%twin_tmp1, 0x2, %twin_tmp1		! clear no-fault bit
+LEON_PI(sta	%twin_tmp1, [%g0] ASI_LEON_MMUREGS)	! store it
+SUN_PI_(sta	%twin_tmp1, [%g0] ASI_M_MMUREGS)	! store it
 
 	mov	AC_M_SFAR, %twin_tmp2
-	lda	[%twin_tmp2] ASI_M_MMUREGS, %g0	! read fault address
+LEON_PI(lda	[%twin_tmp2] ASI_LEON_MMUREGS, %g0)	! read fault address
+SUN_PI_(lda	[%twin_tmp2] ASI_M_MMUREGS, %g0)	! read fault address
 
 	mov	AC_M_SFSR, %twin_tmp2
-	lda	[%twin_tmp2] ASI_M_MMUREGS, %twin_tmp2	! read fault status
-	andcc	%twin_tmp2, 0x2, %g0			! did fault occur?
+LEON_PI(lda	[%twin_tmp2] ASI_LEON_MMUREGS, %twin_tmp2) ! read fault status
+SUN_PI_(lda	[%twin_tmp2] ASI_M_MMUREGS, %twin_tmp2)	   ! read fault status
+	andcc	%twin_tmp2, 0x2, %g0			   ! did fault occur?
 
-	bne	1f					! yep, cleanup
+	bne	1f					   ! yep, cleanup
 	 nop
 
 	wr	%t_psr, 0x0, %psr
-- 
1.6.0.6

