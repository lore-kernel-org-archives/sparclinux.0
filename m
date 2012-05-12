From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:39:58 +0000
Subject: [PATCH] sparc32: Remove sun4c tlb/vac insn patching from entry.S
Message-Id: <20120512.003958.2253054747654405566.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 4976d65..5e75799 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -761,43 +761,6 @@ linux_trap_ipi15_sun4m:
 #endif /* CONFIG_SMP */
 
 	.align	4
-	.globl	invalid_segment_patch1_ff
-	.globl	invalid_segment_patch2_ff
-invalid_segment_patch1_ff:	cmp	%l4, 0xff
-invalid_segment_patch2_ff:	mov	0xff, %l3
-
-	.align	4
-	.globl	invalid_segment_patch1_1ff
-	.globl	invalid_segment_patch2_1ff
-invalid_segment_patch1_1ff:	cmp	%l4, 0x1ff
-invalid_segment_patch2_1ff:	mov	0x1ff, %l3
-
-	.align	4
-	.globl	num_context_patch1_16, num_context_patch2_16
-num_context_patch1_16:		mov	0x10, %l7
-num_context_patch2_16:		mov	0x10, %l7
-
-	.align	4
-	.globl	vac_linesize_patch_32
-vac_linesize_patch_32:		subcc	%l7, 32, %l7
-
-	.align	4
-	.globl	vac_hwflush_patch1_on, vac_hwflush_patch2_on
-
-/*
- * Ugly, but we can't use hardware flushing on the sun4 and we'd require
- * two instructions (Anton)
- */
-vac_hwflush_patch1_on:		addcc	%l7, -PAGE_SIZE, %l7
-
-vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
-
-	.globl	invalid_segment_patch1, invalid_segment_patch2
-	.globl	num_context_patch1
-	.globl	vac_linesize_patch, vac_hwflush_patch1
-	.globl	vac_hwflush_patch2
-
-	.align	4
 	.globl	srmmu_fault
 srmmu_fault:
 	mov	0x400, %l5
-- 
1.7.10

