From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:15 +0000
Subject: [PATCH 12/14] sparc32: drop sun4c bits from head_32.S
Message-Id: <1336772117-1539-12-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

As we no longer support sun4c we can remove all the code to
support remapping the kernel in head_32.S.
We also try to tell the user that the machine is not support,
in case someone try to boot the kernel on a sun4c one day

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |  149 ++++++-------------------------------------
 1 files changed, 19 insertions(+), 130 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 0e23ff3..cb5c3ec 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -63,8 +63,8 @@ cputypvar_sun4m:
 
 	.align 4
 
-sun4_notsup:
-	.asciz	"Sparc-Linux sun4 support does no longer exist.\n\n"
+sun4c_notsup:
+	.asciz	"Sparc-Linux sun4/sun4c support does no longer exist.\n\n"
 	.align 4
 
 sun4e_notsup:
@@ -520,10 +520,9 @@ copy_prom_lvl14:
 		ldd	[%g2 + 0x8], %g4
 		std	%g4, [%g3 + 0x8]	! Copy proms handler
 
-/* Must determine whether we are on a sun4c MMU, SRMMU, or SUN4/400 MUTANT
- * MMU so we can remap ourselves properly.  DON'T TOUCH %l0 thru %l5 in these
- * remapping routines, we need their values afterwards!
- */
+/* DON'T TOUCH %l0 thru %l5 in these remapping routines,
+ * we need their values afterwards! */
+
 		/* Now check whether we are already mapped, if we
 		 * are we can skip all this garbage coming up.
 		 */
@@ -532,26 +531,6 @@ copy_prom_done:
 		be	go_to_highmem		! this will be a nop then
 		 nop
 
-		set	LOAD_ADDR, %g6
-		cmp	%g7, %g6
-		bne	remap_not_a_sun4	! This is not a Sun4
-		 nop
-
-		or	%g0, 0x1, %g1
-		lduba	[%g1] ASI_CONTROL, %g1	! Only safe to try on Sun4.
-		subcc	%g1, 0x24, %g0		! Is this a mutant Sun4/400???
-		be	sun4_mutant_remap	! Ugh, it is...
-		 nop
-
-		b	sun4_normal_remap	! regular sun4, 2 level mmu
-		 nop
-
-remap_not_a_sun4:
-		lda	[%g0] ASI_M_MMUREGS, %g1 ! same as ASI_PTE on sun4c
-		and	%g1, 0x1, %g1		! Test SRMMU Enable bit ;-)
-		cmp	%g1, 0x0
-		be	sun4c_remap		! A sun4c MMU or normal Sun4
-		 nop
 srmmu_remap:
 		/* First, check for a viking (TI) module. */
 		set	0x40000000, %g2
@@ -657,72 +636,6 @@ srmmu_nviking:
 		b	go_to_highmem
 		 nop					! wheee....
 
-		/* This remaps the kernel on Sun4/4xx machines
-		 * that have the Sun Mutant Three Level MMU.
-		 * It's like a platypus, Sun didn't have the
-		 * SRMMU in conception so they kludged the three
-		 * level logic in the regular Sun4 MMU probably.
-		 *
-		 * Basically, you take each entry in the top level
-		 * directory that maps the low 3MB starting at
-		 * address zero and put the mapping in the KERNBASE
-		 * slots.  These top level pgd's are called regmaps.
-		 */
-sun4_mutant_remap:
-		or	%g0, %g0, %g3		! source base
-		sethi	%hi(KERNBASE), %g4	! destination base
-		or	%g4, %lo(KERNBASE), %g4
-		sethi	%hi(0x300000), %g5
-		or	%g5, %lo(0x300000), %g5	! upper bound 3MB
-		or	%g0, 0x1, %l6
-		sll	%l6, 24, %l6		! Regmap mapping size
-		add	%g3, 0x2, %g3		! Base magic
-		add	%g4, 0x2, %g4		! Base magic
-
-		/* Main remapping loop on Sun4-Mutant-MMU.
-		 * "I am not an animal..." -Famous Mutant Person
-		 */
-sun4_mutant_loop:
-		lduha	[%g3] ASI_REGMAP, %g2	! Get lower entry
-		stha	%g2, [%g4] ASI_REGMAP	! Store in high entry
-		add	%g4, %l6, %g4		! Move up high memory ptr
-		subcc	%g3, %g5, %g0		! Reached our limit?
-		blu	sun4_mutant_loop	! Nope, loop again
-		 add	%g3, %l6, %g3		! delay, Move up low ptr
-		b	go_to_highmem		! Jump to high memory.
-		 nop
-
-		/* The following is for non-4/4xx sun4 MMU's. */
-sun4_normal_remap:
-		mov	0, %g3			! source base
-		set	KERNBASE, %g4		! destination base
-		set	0x300000, %g5		! upper bound 3MB
-		mov	1, %l6
-		sll	%l6, 18, %l6		! sun4 mmu segmap size
-sun4_normal_loop:
-		lduha	[%g3] ASI_SEGMAP, %g6	! load phys_seg
-		stha	%g6, [%g4] ASI_SEGMAP	! stort new virt mapping
-		add	%g3, %l6, %g3		! increment source pointer
-		subcc	%g3, %g5, %g0		! reached limit?
-		blu	sun4_normal_loop	! nope, loop again
-		 add	%g4, %l6, %g4		! delay, increment dest ptr
-		b	go_to_highmem
-		 nop
-
-		/* The following works for Sun4c MMU's */
-sun4c_remap:
-		mov	0, %g3			! source base
-		set	KERNBASE, %g4		! destination base
-		set	0x300000, %g5		! upper bound 3MB
-		mov	1, %l6
-		sll	%l6, 18, %l6		! sun4c mmu segmap size
-sun4c_remap_loop:
-		lda	[%g3] ASI_SEGMAP, %g6	! load phys_seg
-		sta	%g6, [%g4] ASI_SEGMAP   ! store new virt mapping
-		add	%g3, %l6, %g3		! Increment source ptr
-		subcc	%g3, %g5, %g0		! Reached limit?
-		bl	sun4c_remap_loop	! Nope, loop again
-		 add	%g4, %l6, %g4		! delay, Increment dest ptr
 
 /* Now do a non-relative jump so that PC is in high-memory */
 go_to_highmem:
@@ -759,16 +672,6 @@ execute_in_high_mem:
 		be	found_version
 		 nop
 
-/* Old sun4's pass our load address into %o0 instead of the prom
- * pointer. On sun4's you have to hard code the romvec pointer into
- * your code. Sun probably still does that because they don't even
- * trust their own "OpenBoot" specifications.
- */
-		set	LOAD_ADDR, %g6
-		cmp	%o0, %g6		! an old sun4?
-		be	sun4_init
-		 nop
-
 found_version:
 /* Get the machine type via the mysterious romvec node operations. */
 
@@ -823,16 +726,16 @@ got_prop:
 		/* Update boot_cpu_id only on boot cpu */
 		stub	%g1, [%g2 + %lo(boot_cpu_id)]
 
-		ba sun4c_continue_boot
+		ba continue_boot
 		 nop
 #endif
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
 		cmp	%l1, ' '
-		be	1f
+		be	no_sun4c_here
 		 cmp	%l1, 'c'
-		be	1f
+		be	no_sun4c_here
 		 cmp	%l1, 'm'
 		be	1f
 		 cmp	%l1, 's'
@@ -847,19 +750,12 @@ got_prop:
 
 1:		set	cputypval, %l1
 		ldub	[%l1 + 0x4], %l1
-		cmp	%l1, 'm'		! Test for sun4d, sun4e ?
-		be	sun4m_init
-		 cmp	%l1, 's'		! Treat sun4s as sun4m
-		be	sun4m_init
-		 cmp	%l1, 'd'		! Let us see how the beast will die
+		cmp	%l1, 'd'		! Let us see how the beast will die
 		be	sun4d_init
 		 nop
 
-		/* Jump into mmu context zero. */
-		set	AC_CONTEXT, %g1
-		stba	%g0, [%g1] ASI_CONTROL
-
-		b	sun4c_continue_boot
+		/* If not sun4d assume sun4m */
+		b	sun4m_init
 		 nop
 
 /* CPUID in bootbus can be found at PA 0xff0140000 */
@@ -959,7 +855,7 @@ sun4m_init:
 		srl	%o1, 28, %o1		! Get a type of the CPU
 
 		subcc	%o1, 4, %g0		! TI: Viking or MicroSPARC
-		be	sun4c_continue_boot
+		be	continue_boot
 		 nop
 
 		set	AC_M_SFSR, %o0
@@ -969,7 +865,7 @@ sun4m_init:
 
 		/* Fujitsu MicroSPARC-II has no asynchronous flavors of FARs */
 		subcc	%o1, 0, %g0
-		be	sun4c_continue_boot
+		be	continue_boot
 		 nop
 
 		set	AC_M_AFSR, %o0
@@ -979,8 +875,7 @@ sun4m_init:
 		 nop
 
 
-sun4c_continue_boot:
-
+continue_boot:
 
 /* Aieee, now set PC and nPC, enable traps, give ourselves a stack and it's
  * show-time!
@@ -1161,18 +1056,12 @@ sun4c_continue_boot:
 		/* We should not get here. */
 		call	halt_me
 		 nop
-
-sun4_init:
-		sethi   %hi(SUN4_PROM_VECTOR+0x84), %o1
-		ld      [%o1 + %lo(SUN4_PROM_VECTOR+0x84)], %o1
-		set     sun4_notsup, %o0
-		call    %o1	/* printf */
-		 nop
-		sethi   %hi(SUN4_PROM_VECTOR+0xc4), %o1
-		ld      [%o1 + %lo(SUN4_PROM_VECTOR+0xc4)], %o1
-		call    %o1	/* exittomon */
+no_sun4c_here:
+		ld	[%g7 + 0x68], %o1
+		set	sun4c_notsup, %o0
+		call	%o1
 		 nop
-1:		ba      1b                      ! Cannot exit into KMON
+		b	halt_me
 		 nop
 
 no_sun4e_here:
-- 
1.6.0.6

