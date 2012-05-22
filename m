From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 20:10:40 +0000
Subject: [PATCH 2/5] sparc32: implement proper LEON support in head_32 (before highmem)
Message-Id: <1337717443-11904-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use PSR to check if the PCU is LEON and jump to
LEON specific code in this case.

Added a few constants to psr.h to increase readability.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/psr.h |    5 ++++
 arch/sparc/kernel/head_32.S  |   54 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/psr.h b/arch/sparc/include/asm/psr.h
index b8c0e5f..eae4a9f 100644
--- a/arch/sparc/include/asm/psr.h
+++ b/arch/sparc/include/asm/psr.h
@@ -35,6 +35,11 @@
 #define PSR_VERS    0x0f000000         /* cpu-version field          */
 #define PSR_IMPL    0xf0000000         /* cpu-implementation field   */
 
+#define PSR_IMPL_SHIFT	28
+
+#define PSR_IMPL_TEXAS	0x4
+#define PSR_IMPL_LEON	0xf
+
 #ifdef __KERNEL__
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 4710aaf..1be5b62 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -202,18 +202,31 @@ halt_sun4_or_sun4c:
 		 nop
 
 not_a_sun4:
+		/* It looks like this is a machine we support.
+		 * Now find out what MMU we are dealing with
+		 * LEON - identified by the psr.impl field
+		 * Viking - identified by the psr.impl field
+		 * In all other cases a sun4m srmmu
+		 */
+
+		/* Check if this is a LEON CPU */
+		rd	%psr, %g3
+		set	PSR_IMPL, %g2
+		and	%g2, %g3, %g3
+		srl	%g3, PSR_IMPL_SHIFT, %g3
+		cmp	%g3, PSR_IMPL_LEON
+		be	leon_remap		/* It is a LEON - jump */
+		 nop
+
+		/* Sanity-check, is MMU enabled */
 		lda	[%g0] ASI_M_MMUREGS, %g1
 		andcc	%g1, 1, %g0
 		be	halt_sun4_or_sun4c
 		 nop
 
-srmmu_remap:
-		/* First, check for a viking (TI) module. */
-		set	0x40000000, %g2
-		rd	%psr, %g3
-		and	%g2, %g3, %g3
-		subcc	%g3, 0x0, %g0
-		bz	srmmu_nviking
+		/* Check for a viking (TI) module. */
+		cmp	%g3, PSR_IMPL_TEXAS
+		bne	srmmu_not_viking
 		 nop
 
 		/* Figure out what kind of viking we are on.
@@ -228,7 +241,7 @@ srmmu_remap:
 		lda	[%g0] ASI_M_MMUREGS, %g3	! peek in the control reg
 		and	%g2, %g3, %g3
 		subcc	%g3, 0x0, %g0
-		bnz	srmmu_nviking			! is in mbus mode
+		bnz	srmmu_not_viking			! is in mbus mode
 		 nop
 
 		rd	%psr, %g3			! DO NOT TOUCH %g3
@@ -293,12 +306,12 @@ srmmu_remap:
 		b	go_to_highmem
 		 nop
 
+srmmu_not_viking:
 		/* This works on viking's in Mbus mode and all
 		 * other MBUS modules.  It is virtually the same as
 		 * the above madness sans turning traps off and flipping
 		 * the AC bit.
 		 */
-srmmu_nviking:
 		set	AC_M_CTPR, %g1
 		lda	[%g1] ASI_M_MMUREGS, %g1	! get ctx table ptr
 		sll	%g1, 0x4, %g1			! make physical addr
@@ -313,6 +326,29 @@ srmmu_nviking:
 		 nop					! wheee....
 
 
+leon_remap:
+		/* Sanity-check, is MMU enabled */
+		lda	[%g0] ASI_LEON_MMUREGS, %g1
+		andcc	%g1, 1, %g0
+		be	halt_sun4_or_sun4c
+		 nop
+
+		/* Same code as in the srmmu_not_viking case,
+		 * with the LEON ASI for mmuregs
+		 */
+		set	AC_M_CTPR, %g1
+		lda	[%g1] ASI_LEON_MMUREGS, %g1	! get ctx table ptr
+		sll	%g1, 0x4, %g1			! make physical addr
+		lda	[%g1] ASI_M_BYPASS, %g1		! ptr to level 1 pg_table
+		srl	%g1, 0x4, %g1
+		sll	%g1, 0x8, %g1			! make phys addr for l1 tbl
+
+		lda	[%g1] ASI_M_BYPASS, %g2		! get level1 entry for 0x0
+		add	%g1, KERNBASE >> (SRMMU_PGDIR_SHIFT - 2), %g3
+		sta	%g2, [%g3] ASI_M_BYPASS		! place at KERNBASE entry
+		b	go_to_highmem
+		 nop					! wheee....
+
 /* Now do a non-relative jump so that PC is in high-memory */
 go_to_highmem:
 		set	execute_in_high_mem, %g1
-- 
1.6.0.6

