From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:28:17 +0000
Subject: [PATCH] sparc32: Restore SMP build and rectify sun4m NMI when non-SMP.
Message-Id: <20120512.002817.467682394309360735.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The non-SMP sun4m NMI handler was still accessing SUN4C registers.

Fix that and share the sun4m NMI trap code between SMP and non-SMP
cases.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S   |   78 ++++++++++++++++---------------------------
 arch/sparc/kernel/head_32.S |    2 +-
 2 files changed, 30 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 1b87ea0..4976d65 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -306,8 +306,8 @@ maybe_smp4m_msg_out:
 	RESTORE_ALL
 
 	.align	4
-	.globl	linux_trap_ipi15
-linux_trap_ipi15:
+	.globl	linux_trap_ipi15_sun4m
+linux_trap_ipi15_sun4m:
 	SAVE_ALL
 	sethi	%hi(0x80000000), %o2
 	GET_PROCESSOR4M_ID(o0)
@@ -317,7 +317,7 @@ linux_trap_ipi15:
 	ld	[%o5 + %o0], %o5
 	ld	[%o5 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
 	andcc	%o3, %o2, %g0
-	be	1f			! Must be an NMI async memory error
+	be	sun4m_nmi_error		! Must be an NMI async memory error
 	 st	%o2, [%o5 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x80000000
 	WRITE_PAUSE
 	ld	[%o5 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
@@ -331,27 +331,6 @@ linux_trap_ipi15:
 	 nop
 	b	ret_trap_lockless_ipi
 	 clr	%l6
-1:
-	/* NMI async memory error handling. */
-	sethi	%hi(0x80000000), %l4
-	sethi	%hi(sun4m_irq_global), %o5
-	ld	[%o5 + %lo(sun4m_irq_global)], %l5
-	st	%l4, [%l5 + 0x0c]	! sun4m_irq_global->mask_set=0x80000000
-	WRITE_PAUSE
-	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
-	WRITE_PAUSE
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	call	sun4m_nmi
-	 nop
-	st	%l4, [%l5 + 0x08]	! sun4m_irq_global->mask_clear=0x80000000
-	WRITE_PAUSE
-	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
-	WRITE_PAUSE
-	RESTORE_ALL
 
 	.globl	smp4d_ticker
 	/* SMP per-cpu ticker interrupts are handled specially. */
@@ -749,35 +728,36 @@ setcc_trap_handler:
 	jmp	%l2		! advance over trap instruction
 	rett	%l2 + 0x4	! like this...
 
+sun4m_nmi_error:
+	/* NMI async memory error handling. */
+	sethi	%hi(0x80000000), %l4
+	sethi	%hi(sun4m_irq_global), %o5
+	ld	[%o5 + %lo(sun4m_irq_global)], %l5
+	st	%l4, [%l5 + 0x0c]	! sun4m_irq_global->mask_set=0x80000000
+	WRITE_PAUSE
+	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
+	WRITE_PAUSE
+	or	%l0, PSR_PIL, %l4
+	wr	%l4, 0x0, %psr
+	WRITE_PAUSE
+	wr	%l4, PSR_ET, %psr
+	WRITE_PAUSE
+	call	sun4m_nmi
+	 nop
+	st	%l4, [%l5 + 0x08]	! sun4m_irq_global->mask_clear=0x80000000
+	WRITE_PAUSE
+	ld	[%l5 + 0x00], %g0	! sun4m_irq_global->pending
+	WRITE_PAUSE
+	RESTORE_ALL
+
 #ifndef CONFIG_SMP
 	.align	4
-	.globl	linux_trap_ipi15
-linux_trap_ipi15:
+	.globl	linux_trap_ipi15_sun4m
+linux_trap_ipi15_sun4m:
 	SAVE_ALL
 
-	/* Now it is safe to re-enable traps without recursion. */
-	or	%l0, PSR_PIL, %l0
-	wr	%l0, PSR_ET, %psr
-	WRITE_PAUSE
-
-	/* Now call the c-code with the pt_regs frame ptr and the
-	 * memory error registers as arguments.  The ordering chosen
-	 * here is due to unlatching semantics.
-	 */
-	sethi	%hi(AC_SYNC_ERR), %o0
-	add	%o0, 0x4, %o0
-	lda	[%o0] ASI_CONTROL, %o2	! sync vaddr
-	sub	%o0, 0x4, %o0
-	lda	[%o0] ASI_CONTROL, %o1	! sync error
-	add	%o0, 0xc, %o0
-	lda	[%o0] ASI_CONTROL, %o4	! async vaddr
-	sub	%o0, 0x4, %o0
-	lda	[%o0] ASI_CONTROL, %o3	! async error
-	call	sparc_lvl15_nmi
-	 add	%sp, STACKFRAME_SZ, %o0
-
-	RESTORE_ALL
-
+	ba	sun4m_nmi_error
+	 nop
 #endif /* CONFIG_SMP */
 
 	.align	4
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 85623f9..ea45894 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -111,7 +111,7 @@ t_irq12:TRAP_ENTRY_INTERRUPT(12)            /* IRQ Zilog serial chip         */
 t_irq13:TRAP_ENTRY_INTERRUPT(13)            /* IRQ Audio Intr.               */
 t_irq14:TRAP_ENTRY_INTERRUPT(14)            /* IRQ Timer #2                  */
 	.globl	t_nmi
-t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15)
+t_nmi:	TRAP_ENTRY(0x1f, linux_trap_ipi15_sun4m)
 
 t_racc:	TRAP_ENTRY(0x20, do_reg_access)     /* General Register Access Error */
 t_iacce:BAD_TRAP(0x21)                      /* Instr Access Error            */
-- 
1.7.10

