From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 11:43:48 +0000
Subject: [PATCH 3/4] sparc32: drop extra getprop call during boot
Message-Id: <1336823029-8206-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It was present only to support the sun4, sun4c boxes which
do not have the "compatible" property in the root-node
of the device tree.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |   50 +++++++-----------------------------------
 1 files changed, 9 insertions(+), 41 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 56e32a2..17e00c1 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -26,11 +26,9 @@
 #include <asm/pgtsrmmu.h>	/* SRMMU_PGDIR_SHIFT */
 
 	.data
-/* 
- * The following are used with the prom_vector node-ops to figure out
- * the cpu-type 
+/* The following are used with the prom_vector node-ops to figure out
+ * the cpu-type
  */
-
 	.align 4
 cputyp:
         .word   1
@@ -38,27 +36,12 @@ cputyp:
 	.align 4
 	.globl cputypval
 cputypval:
-	.asciz "sun4c"
+	.asciz "sun4m"
 	.ascii "     "
 
-cputypvalend:
-cputypvallen = cputypvar - cputypval
-
+/* Tested on SS-5, SS-10 */
 	.align 4
-/*
- * Sun people can't spell worth damn. "compatability" indeed.
- * At least we *know* we can't spell, and use a spell-checker.
- */
-
-/* Uh, actually Linus it is I who cannot spell. Too much murky
- * Sparc assembly will do this to ya.
- */
 cputypvar:
-	.asciz "compatability"
-
-/* Tested on SS-5, SS-10. Probably someone at Sun applied a spell-checker. */
-	.align 4
-cputypvar_sun4m:
 	.asciz "compatible"
 
 	.align 4
@@ -677,10 +660,10 @@ execute_in_high_mem:
 
 /* Get the machine type via the mysterious romvec node operations. */
 
-		add	%g7, 0x1c, %l1		
+		add	%g7, 0x1c, %l1
 		ld	[%l1], %l0
 		ld	[%l0], %l0
-		call 	%l0
+		call	%l0
 		 or	%g0, %g0, %o0		! next_node(0) = first_node
 		or	%o0, %g0, %g6
 
@@ -688,28 +671,13 @@ execute_in_high_mem:
 		or	%o1, %lo(cputypvar), %o1
 		sethi	%hi(cputypval), %o2	! information, the string
 		or	%o2, %lo(cputypval), %o2
-		ld	[%l1], %l0		! 'compatibility' tells
+		ld	[%l1], %l0		! 'compatible' tells
 		ld	[%l0 + 0xc], %l0	! that we want 'sun4x' where
-		call	%l0			! x is one of '', 'c', 'm',
-		 nop				! 'd' or 'e'. %o2 holds pointer
+		call	%l0			! x is one of 'm', 'd' or 'e'.
+		 nop				! %o2 holds pointer
 						! to a buf where above string
 						! will get stored by the prom.
 
-		subcc	%o0, %g0, %g0
-		bpos	got_prop		! Got the property
-		 nop
-
-		or	%g6, %g0, %o0
-		sethi	%hi(cputypvar_sun4m), %o1
-		or	%o1, %lo(cputypvar_sun4m), %o1
-		sethi	%hi(cputypval), %o2
-		or	%o2, %lo(cputypval), %o2
-		ld	[%l1], %l0
-		ld	[%l0 + 0xc], %l0
-		call	%l0
-		 nop
-
-got_prop:
 #ifdef CONFIG_SPARC_LEON
 	        /* no cpu-type check is needed, it is a SPARC-LEON */
 
-- 
1.6.0.6

