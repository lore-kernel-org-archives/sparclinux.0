From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:40 +0000
Subject: [PATCH v1 06/13] sparc32: Drop patching of interrupt vector
Message-Id: <20201218184347.2180772-7-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

Drop the sun4m specific handling and the patching that
takes place in sun4d and LEON.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/entry.S       | 98 ---------------------------------
 arch/sparc/kernel/kernel.h      |  1 -
 arch/sparc/kernel/leon_kernel.c | 16 ------
 arch/sparc/kernel/sun4d_irq.c   | 25 ---------
 4 files changed, 140 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 1a2e20a7e584..e7cf5013aa40 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -79,15 +79,6 @@ bad_trap_handler:
 real_irq_entry:
 	SAVE_ALL
 
-#ifdef CONFIG_SMP
-	.globl	patchme_maybe_smp_msg
-
-	cmp	%l7, 11
-patchme_maybe_smp_msg:
-	bgu	maybe_smp4m_msg
-	 nop
-#endif
-
 real_irq_continue:
 	or	%l0, PSR_PIL, %g2
 	wr	%g2, 0x0, %psr
@@ -105,95 +96,6 @@ patch_handler_irq:
 	RESTORE_ALL
 
 #ifdef CONFIG_SMP
-	/* SMP per-cpu ticker interrupts are handled specially. */
-smp4m_ticker:
-	bne	real_irq_continue+4
-	 or	%l0, PSR_PIL, %g2
-	wr	%g2, 0x0, %psr
-	WRITE_PAUSE
-	wr	%g2, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4m_percpu_timer_interrupt
-	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
-	WRITE_PAUSE
-	RESTORE_ALL
-
-#define GET_PROCESSOR4M_ID(reg)	\
-	rd	%tbr, %reg;	\
-	srl	%reg, 12, %reg;	\
-	and	%reg, 3, %reg;
-
-	/* Here is where we check for possible SMP IPI passed to us
-	 * on some level other than 15 which is the NMI and only used
-	 * for cross calls.  That has a separate entry point below.
-	 *
-	 * IPIs are sent on Level 12, 13 and 14. See IRQ_IPI_*.
-	 */
-maybe_smp4m_msg:
-	GET_PROCESSOR4M_ID(o3)
-	sethi	%hi(sun4m_irq_percpu), %l5
-	sll	%o3, 2, %o3
-	or	%l5, %lo(sun4m_irq_percpu), %o5
-	sethi	%hi(0x70000000), %o2	! Check all soft-IRQs
-	ld	[%o5 + %o3], %o1
-	ld	[%o1 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
-	andcc	%o3, %o2, %g0
-	be,a	smp4m_ticker
-	 cmp	%l7, 14
-	/* Soft-IRQ IPI */
-	st	%o2, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x70000000
-	WRITE_PAUSE
-	ld	[%o1 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
-	WRITE_PAUSE
-	or	%l0, PSR_PIL, %l4
-	wr	%l4, 0x0, %psr
-	WRITE_PAUSE
-	wr	%l4, PSR_ET, %psr
-	WRITE_PAUSE
-	srl	%o3, 28, %o2		! shift for simpler checks below
-maybe_smp4m_msg_check_single:
-	andcc	%o2, 0x1, %g0
-	beq,a	maybe_smp4m_msg_check_mask
-	 andcc	%o2, 0x2, %g0
-	call	smp_call_function_single_interrupt
-	 nop
-	andcc	%o2, 0x2, %g0
-maybe_smp4m_msg_check_mask:
-	beq,a	maybe_smp4m_msg_check_resched
-	 andcc	%o2, 0x4, %g0
-	call	smp_call_function_interrupt
-	 nop
-	andcc	%o2, 0x4, %g0
-maybe_smp4m_msg_check_resched:
-	/* rescheduling is done in RESTORE_ALL regardless, but incr stats */
-	beq,a	maybe_smp4m_msg_out
-	 nop
-	call	smp_resched_interrupt
-	 nop
-maybe_smp4m_msg_out:
-	RESTORE_ALL
-
-
-	.globl	smp4d_ticker
-	/* SMP per-cpu ticker interrupts are handled specially. */
-smp4d_ticker:
-	SAVE_ALL
-	or	%l0, PSR_PIL, %g2
-	sethi	%hi(CC_ICLR), %o0
-	sethi	%hi(1 << 14), %o1
-	or	%o0, %lo(CC_ICLR), %o0
-	stha	%o1, [%o0] ASI_M_MXCC	/* Clear PIL 14 in MXCC's ICLR */
-	wr	%g2, 0x0, %psr
-	WRITE_PAUSE
-	wr	%g2, PSR_ET, %psr
-	WRITE_PAUSE
-	call	smp4d_percpu_timer_interrupt
-	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
-	WRITE_PAUSE
-	RESTORE_ALL
-
 	.globl	smpleon_ipi
 	.extern leon_ipi_interrupt
 	/* SMP per-cpu IPI interrupts are handled specially. */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index c9e1b13d955f..e313d2e15ba9 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -146,7 +146,6 @@ extern char cputypval[];
 extern unsigned long lvl14_save[4];
 extern unsigned int real_irq_entry[];
 extern unsigned int smp4d_ticker[];
-extern unsigned int patchme_maybe_smp_msg[];
 
 /* trampoline_32.S */
 extern unsigned long sun4m_cpu_startup;
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 39229940d725..49b37a0dcc2b 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -423,22 +423,6 @@ void __init leon_init_timers(void)
 	if (eirq != 0)
 		leon_eirq_setup(eirq);
 
-#ifdef CONFIG_SMP
-	{
-		unsigned long flags;
-
-		/*
-		 * In SMP, sun4m adds a IPI handler to IRQ trap handler that
-		 * LEON never must take, sun4d and LEON overwrites the branch
-		 * with a NOP.
-		 */
-		local_irq_save(flags);
-		patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
-		local_ops->cache_all();
-		local_irq_restore(flags);
-	}
-#endif
-
 	config = LEON3_BYPASS_LOAD_PA(&leon3_gptimer_regs->config);
 	if (config & (1 << LEON3_GPTIMER_SEPIRQ))
 		leon3_gptimer_irq += leon3_gptimer_idx;
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 9a137c70e8d1..7140cff04b54 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -391,30 +391,6 @@ static unsigned int sun4d_build_timer_irq(unsigned int board,
 }
 
 
-static void __init sun4d_fixup_trap_table(void)
-{
-#ifdef CONFIG_SMP
-	unsigned long flags;
-	struct tt_entry *trap_table = &sparc_ttable[SP_TRAP_IRQ1 + (14 - 1)];
-
-	/* Adjust so that we jump directly to smp4d_ticker */
-	lvl14_save[2] += smp4d_ticker - real_irq_entry;
-
-	/* For SMP we use the level 14 ticker, however the bootup code
-	 * has copied the firmware's level 14 vector into the boot cpu's
-	 * trap table, we must fix this now or we get squashed.
-	 */
-	local_irq_save(flags);
-	patchme_maybe_smp_msg[0] = 0x01000000; /* NOP out the branch */
-	trap_table->inst_one = lvl14_save[0];
-	trap_table->inst_two = lvl14_save[1];
-	trap_table->inst_three = lvl14_save[2];
-	trap_table->inst_four = lvl14_save[3];
-	local_ops->cache_all();
-	local_irq_restore(flags);
-#endif
-}
-
 static void __init sun4d_init_timers(void)
 {
 	struct device_node *dp;
@@ -478,7 +454,6 @@ static void __init sun4d_init_timers(void)
 		prom_halt();
 	}
 	sun4d_load_profile_irqs();
-	sun4d_fixup_trap_table();
 }
 
 void __init sun4d_init_sbi_irq(void)
-- 
2.27.0
