From: David Miller <davem@davemloft.net>
Date: Fri, 14 Jul 2017 21:01:01 +0000
Subject: Re: [PATCH v2] sparc64: Prevent perf from running during super critical sections
Message-Id: <20170714.140101.1858368602246100879.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500045627-451648-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1500045627-451648-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 14 Jul 2017 09:20:27 -0600

> This fixes another cause of random segfaults and bus errors that may
> occur while running perf with the callgraph option.
> 
> Critical sections beginning with spin_lock_irqsave() raise the interrupt
> level to PIL_NORMAL_MAX (14) and intentionally do not block performance
> counter interrupts, which arrive at PIL_NMI (15).
> 
> But some sections of code are "super critical" with respect to perf
> because the perf_callchain_user() path accesses user space and may cause
> TLB activity as well as faults as it unwinds the user stack.
> 
> One particular critical section occurs in switch_mm:
> 
>         spin_lock_irqsave(&mm->context.lock, flags);
>         ...
>         load_secondary_context(mm);
>         tsb_context_switch(mm);
>         ...
>         spin_unlock_irqrestore(&mm->context.lock, flags);
> 
> If a perf interrupt arrives in between load_secondary_context() and
> tsb_context_switch(), then perf_callchain_user() could execute with
> the context ID of one process, but with an active TSB for a different
> process. When the user stack is accessed, it is very likely to
> incur a TLB miss, since the h/w context ID has been changed. The TLB
> will then be reloaded with a translation from the TSB for one process,
> but using a context ID for another process. This exposes memory from
> one process to another, and since it is a mapping for stack memory,
> this usually causes the new process to crash quickly.
> 
> This super critical section needs more protection than is provided
> by spin_lock_irqsave() since perf interrupts must not be allowed in.
> 
> Fixed by masking non-maskable interrupts just before the the super
> critical section in switch_mm(), and in restore_processor_state()
> which has the identical logic. This change persists until the end of
> the original critical section.
> 
> Orabug: 25577560
> 
> Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>

Thanks for following up on this.

So I guess the interesting conclusion is that the problem isn't the
TLB state getting out of sync with the stack frame, it's the TLB state
getting out of sync with the TSB state.

That's what needs to be atomic, the TLB+TSB changes.

I'm concerned about the overhead of this new %pil write in every
context switch.  And if you look, __tsb_context_switch() turns off
PSTATE_IE in the %pstate register (!!!).

So why don't we slide the secondary context change into there?

Something like this:

diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 2cddcda..2e836cc 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -27,9 +27,10 @@ void destroy_context(struct mm_struct *mm);
 void __tsb_context_switch(unsigned long pgd_pa,
 			  struct tsb_config *tsb_base,
 			  struct tsb_config *tsb_huge,
-			  unsigned long tsb_descr_pa);
+			  unsigned long tsb_descr_pa,
+			  unsigned long secondary_ctx);
 
-static inline void tsb_context_switch(struct mm_struct *mm)
+static inline void tsb_context_switch_ctx(struct mm_struct *mm, unsigned long ctx)
 {
 	__tsb_context_switch(__pa(mm->pgd),
 			     &mm->context.tsb_block[MM_TSB_BASE],
@@ -40,9 +41,12 @@ static inline void tsb_context_switch(struct mm_struct *mm)
 #else
 			     NULL
 #endif
-			     , __pa(&mm->context.tsb_descr[MM_TSB_BASE]));
+			     , __pa(&mm->context.tsb_descr[MM_TSB_BASE]),
+			     ctx);
 }
 
+#define tsb_context_switch(X) tsb_context_switch_ctx(X, 0)
+
 void tsb_grow(struct mm_struct *mm,
 	      unsigned long tsb_index,
 	      unsigned long mm_rss);
@@ -112,8 +116,7 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	 * cpu0 to update it's TSB because at that point the cpu_vm_mask
 	 * only had cpu1 set in it.
 	 */
-	load_secondary_context(mm);
-	tsb_context_switch(mm);
+	tsb_context_switch_ctx(mm, CTX_HWBITS(mm->context));
 
 	/* Any time a processor runs a context on an address space
 	 * for the first time, we must flush that context out of the
diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index 07c0df9..0360fae 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -360,6 +360,7 @@ tsb_flush:
 	 * %o1:	TSB base config pointer
 	 * %o2:	TSB huge config pointer, or NULL if none
 	 * %o3:	Hypervisor TSB descriptor physical address
+	 * %o4: secondary context to load, if non-zero
 	 *
 	 * We have to run this whole thing with interrupts
 	 * disabled so that the current cpu doesn't change
@@ -372,6 +373,17 @@ __tsb_context_switch:
 	rdpr	%pstate, %g1
 	wrpr	%g1, PSTATE_IE, %pstate
 
+	brz,pn	%o4, 1f
+	 mov	SECONDARY_CONTEXT, %o5
+
+661:	stxa	%o4, [%o5] ASI_DMMU
+	.section .sun4v_1insn_patch, "ax"
+	.word	661b
+	stxa	%o4, [%o5] ASI_MMU
+	.previous
+	flush	%g6
+
+1:	
 	TRAP_LOAD_TRAP_BLOCK(%g2, %g3)
 
 	stx	%o0, [%g2 + TRAP_PER_CPU_PGD_PADDR]
