From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 11 Nov 2005 05:02:34 +0000
Subject: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051110.210234.59468958.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Anyone feeling dangerous? :-)

Today I put together a patch for IRQ stack support.
This allows using single pages for the thread_struct
plus kernel stack allocation.

I've run it for half of today on my workstation with
no ill results so far.  But more testing would be really
nice, so if you can give this patch a spin that would
be great.

The patch should apply to all recent 2.6.x trees.

Thanks.

diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 233526b..7308a58 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -601,11 +601,42 @@ out:
 	bp->flags &= ~IBF_INPROGRESS;
 }
 
+struct irq_stack {
+	unsigned long stack[IRQSTACK_SIZE / sizeof(unsigned long)];
+};
+
+static DEFINE_PER_CPU(struct irq_stack, irq_stack);
+static DEFINE_PER_CPU(struct irq_stack, softirq_stack);
+
+static inline void switch_to_irqstack(struct irq_stack *_irq_stack)
+{
+	unsigned long irq_stack = (unsigned long) _irq_stack;
+	unsigned long irq_stack_end = irq_stack + IRQSTACK_SIZE;
+	unsigned long cur_stack;
+
+	if (unlikely(!irq_stack))
+		return;
+
+	__asm__ __volatile__("mov %%sp, %0\n"
+			     : "=r" (cur_stack));
+
+	cur_stack += STACK_BIAS;
+	if (cur_stack >= irq_stack && cur_stack < irq_stack_end)
+		return;
+
+	__asm__ __volatile("mov %0, %%sp"
+			   : /* no outputs */
+			   : "r" ((irq_stack + IRQSTACK_SIZE) -
+				  (STACKFRAME_SZ + STACK_BIAS)));
+}
+
 void handler_irq(int irq, struct pt_regs *regs)
 {
 	struct ino_bucket *bp;
 	int cpu = smp_processor_id();
 
+	switch_to_irqstack(&__get_cpu_var(irq_stack));
+
 #ifndef CONFIG_SMP
 	/*
 	 * Check for TICK_INT on level 14 softint.
@@ -645,6 +676,27 @@ void handler_irq(int irq, struct pt_regs
 	irq_exit();
 }
 
+extern asmlinkage void __do_softirq(void);
+
+asmlinkage void do_softirq(void)
+{
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	if (local_softirq_pending()) {
+		switch_to_irqstack(&__get_cpu_var(softirq_stack));
+		__do_softirq();
+	}
+
+	local_irq_restore(flags);
+}
+
+EXPORT_SYMBOL(do_softirq);
+
 #ifdef CONFIG_BLK_DEV_FD
 extern irqreturn_t floppy_interrupt(int, void *, struct pt_regs *);;
 
diff --git a/include/asm-sparc64/irq.h b/include/asm-sparc64/irq.h
index 8b70edc..b7dbfb3 100644
--- a/include/asm-sparc64/irq.h
+++ b/include/asm-sparc64/irq.h
@@ -16,6 +16,9 @@
 #include <asm/pil.h>
 #include <asm/ptrace.h>
 
+#define __ARCH_HAS_DO_SOFTIRQ
+#define IRQSTACK_SIZE		8192
+
 struct ino_bucket;
 
 #define MAX_IRQ_DESC_ACTION	4
diff --git a/include/asm-sparc64/thread_info.h b/include/asm-sparc64/thread_info.h
index c94d8b3..f92611d 100644
--- a/include/asm-sparc64/thread_info.h
+++ b/include/asm-sparc64/thread_info.h
@@ -117,13 +117,8 @@ struct thread_info {
 #define FAULT_CODE_WINFIXUP	0x08	/* Miss happened during spill/fill */
 #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
 
-#if PAGE_SHIFT = 13
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define THREAD_SHIFT (PAGE_SHIFT + 1)
-#else /* PAGE_SHIFT = 13 */
 #define THREAD_SIZE PAGE_SIZE
 #define THREAD_SHIFT PAGE_SHIFT
-#endif /* PAGE_SHIFT = 13 */
 
 #define PREEMPT_ACTIVE		0x4000000
 
@@ -153,30 +148,16 @@ register struct thread_info *current_thr
 #define current_thread_info()	(current_thread_info_reg)
 
 /* thread information allocation */
-#if PAGE_SHIFT = 13
-#define __THREAD_INFO_ORDER	1
-#else /* PAGE_SHIFT = 13 */
-#define __THREAD_INFO_ORDER	0
-#endif /* PAGE_SHIFT = 13 */
-
 #ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)					\
-({								\
-	struct thread_info *ret;				\
-								\
-	ret = (struct thread_info *)				\
-	  __get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER);	\
-	if (ret)						\
-		memset(ret, 0, PAGE_SIZE<<__THREAD_INFO_ORDER);	\
-	ret;							\
-})
+#define alloc_thread_info(tsk)	\
+	((struct thread_info *) get_zeroed_page(GFP_KERNEL))
 #else
 #define alloc_thread_info(tsk) \
-	((struct thread_info *)__get_free_pages(GFP_KERNEL, __THREAD_INFO_ORDER))
+	((struct thread_info *) __get_free_page(GFP_KERNEL))
 #endif
 
 #define free_thread_info(ti) \
-	free_pages((unsigned long)(ti),__THREAD_INFO_ORDER)
+	free_pages((unsigned long)(ti),0)
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
