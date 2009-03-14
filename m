From: David Miller <davem@davemloft.net>
Date: Sat, 14 Mar 2009 22:46:05 +0000
Subject: Re: question on sparc64 switch_to macro
Message-Id: <20090314.154605.208466216.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200903141853.n2EIrqn13598@elf.torek.net>
In-Reply-To: <200903141853.n2EIrqn13598@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Sat, 14 Mar 2009 16:24:41 -0600

> >"rd %pc, X" doesn't schedule very well at all, it flushes the pipeline
> >completely and cannot issue alongside other instructions.
> 
> Oh, in that case maybe the other code that does the "rd %pc" version
> should be switched to using sethi/or sequences.  (Or maybe it is
> already in places where there is no good scheduling.)

In many places where we use rd %pc, X we are doing so because we
are limited by the number of instructions.  For example, in trap
table entries.

> >It's so easy to reschedule this kgdb capture thing into a software
> >interrupt, please code that up and give it a whirl.
> >
> >Or, as usual, I'll do it :-/
> 
> Heh.  In my case, I will have to go work out how the software
> interrupts work, so as to make sure I don't step on some other
> interrupt.
> 
> I'll probably get a chance to try sometime Monday or Tuesday though --
> actually I'm working with other folks and they'd be doing the "try"
> part -- as I have a pile of other work I have to get done this
> weekend and Monday.

It's a 2 minute hack, just test this patch below.

BTW, there are things which we know won't work with KGDB on platforms
like sparc that do single-step in software.  SMP KGDB usage on such
platforms is basically hit-or-miss because it's very racy.  See:

	http://kerneltrap.org/mailarchive/linux-kernel/2008/4/29/1647204

Just FYI.

diff --git a/arch/sparc/include/asm/pil.h b/arch/sparc/include/asm/pil.h
index 32a7efe..2669370 100644
--- a/arch/sparc/include/asm/pil.h
+++ b/arch/sparc/include/asm/pil.h
@@ -24,6 +24,7 @@
 #define PIL_DEVICE_IRQ		5
 #define PIL_SMP_CALL_FUNC_SNGL	6
 #define PIL_DEFERRED_PCR_WORK	7
+#define PIL_KGDB_CAPTURE	8
 #define PIL_NORMAL_MAX		14
 #define PIL_NMI			15
 
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index fefbe6d..f5a0fd4 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -108,7 +108,7 @@ void gdb_regs_to_pt_regs(unsigned long *gdb_regs, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-void smp_kgdb_capture_client(struct pt_regs *regs)
+void smp_kgdb_capture_client(int irq, struct pt_regs *regs)
 {
 	unsigned long flags;
 
diff --git a/arch/sparc/kernel/ttable.S b/arch/sparc/kernel/ttable.S
index d9bdfb9..76d837f 100644
--- a/arch/sparc/kernel/ttable.S
+++ b/arch/sparc/kernel/ttable.S
@@ -64,7 +64,12 @@ tl0_irq6:	TRAP_IRQ(smp_call_function_single_client, 6)
 tl0_irq6:	BTRAP(0x46)
 #endif
 tl0_irq7:	TRAP_IRQ(deferred_pcr_work_irq, 7)
-tl0_irq8:	BTRAP(0x48) BTRAP(0x49)
+#ifdef CONFIG_KGDB
+tl0_irq8:	TRAP_IRQ(smp_kgdb_capture_client, 8)
+#else
+tl0_irq8:	BTRAP(0x48)
+#endif
+tl0_irq9:	BTRAP(0x49)
 tl0_irq10:	BTRAP(0x4a) BTRAP(0x4b) BTRAP(0x4c) BTRAP(0x4d)
 tl0_irq14:	TRAP_IRQ(timer_interrupt, 14)
 tl0_irq15:	TRAP_NMI_IRQ(perfctr_irq, 15)
diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
index 80c788e..b57a594 100644
--- a/arch/sparc/mm/ultra.S
+++ b/arch/sparc/mm/ultra.S
@@ -679,28 +679,8 @@ xcall_new_mmu_context_version:
 #ifdef CONFIG_KGDB
 	.globl		xcall_kgdb_capture
 xcall_kgdb_capture:
-661:	rdpr		%pstate, %g2
-	wrpr		%g2, PSTATE_IG | PSTATE_AG, %pstate
-	.section	.sun4v_2insn_patch, "ax"
-	.word		661b
-	nop
-	nop
-	.previous
-
-	rdpr		%pil, %g2
-	wrpr		%g0, PIL_NORMAL_MAX, %pil
-	sethi		%hi(109f), %g7
-	ba,pt		%xcc, etrap_irq
-109:	 or		%g7, %lo(109b), %g7
-#ifdef CONFIG_TRACE_IRQFLAGS
-	call		trace_hardirqs_off
-	 nop
-#endif
-	call		smp_kgdb_capture_client
-	 add		%sp, PTREGS_OFF, %o0
-	/* Has to be a non-v9 branch due to the large distance. */
-	ba		rtrap_xcall
-	 ldx		[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
+	wr		%g0, (1 << PIL_KGDB_CAPTURE), %set_softint
+	retry
 #endif
 
 #endif /* CONFIG_SMP */

