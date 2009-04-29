From: Chris Torek <chris.torek@windriver.com>
Date: Wed, 29 Apr 2009 21:41:48 +0000
Subject: interrupt problem with multiple vnet devices
Message-Id: <200904292141.n3TLfmn16267@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

One of our guys is working on a problem with Linux as guest
domain client and multiple vnets bound to the same vswitch:

   ldm add-vnet vnet0 primary-vsw1 ldom1
   ldm add-vnet vnet1 primary-vsw1 ldom1

When configured this way, Linux does not boot properly, as
it winds up perpetually servicing vnet interrupts.

The fix he sent me is below, but I am very suspicious about
this as it essentially removes the linked-list of buckets
that the irq code runs.

I think the real problem is that, when multiple vnet devices are
on the same vswitch, the interrupts get re-enabled "too soon" so
that the sun4v_ivec.S code ends up making the linked list become
circular (by queueing work for a vnet cookie that is already queued).

It seems a little odd to me, though, that the sun4v_ivec.S code
builds up a backwards list (by pushing things onto the head of the
chain after setting the "next" based on the current head).  I guess
this is just because it is too hard to add to the end of the list.
(I would probably do this with the assembly code equivalent of:

    new->next = NULL;
    *tail = new;
    tail = &new->next;

but this requires adding a "tail" pointer to the per-cpu block,
and of course updating it in the irq_64.c code.  Note that we are
still working with older code that has a sparc64 directory.)

(This patch also includes code to handle irq redistribution
on ldom guests that have a small number of CPUs, with a kernel
built to run on many more CPUs.  It is still not ideal yet as
it does not do chip-then-strand distribution, I'm just including
it here out of laziness :-) / desire-not-to-break-diffs.)

Chris


diff --git a/arch/sparc64/kernel/sun4v_ivec.S b/arch/sparc64/kernel/sun4v_ivec.S
index e2f8e1b..edcd71e 100644
--- a/arch/sparc64/kernel/sun4v_ivec.S
+++ b/arch/sparc64/kernel/sun4v_ivec.S
@@ -108,8 +108,7 @@ sun4v_dev_mondo:
 	sllx	%g3, 4, %g3
 	add	%g4, %g3, %g4
 
-1:	ldx	[%g1], %g2
-	stxa	%g2, [%g4] ASI_PHYS_USE_EC
+1:	stxa	%g0, [%g4] ASI_PHYS_USE_EC
 	stx	%g4, [%g1]
 
 	/* Signal the interrupt by setting (1 << pil) in %softint.  */
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 7872476..2584b9e 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -70,6 +70,7 @@ static unsigned long bucket_get_chain_pa(unsigned long bucket_pa)
 	return ret;
 }
 
+#if 0 /* This one is no longer needed. */
 static void bucket_clear_chain_pa(unsigned long bucket_pa)
 {
 	__asm__ __volatile__("stxa	%%g0, [%0] %1"
@@ -79,6 +80,7 @@ static void bucket_clear_chain_pa(unsigned long bucket_pa)
 					     __irq_chain_pa)),
 			       "i" (ASI_PHYS_USE_EC));
 }
+#endif
 
 static unsigned int bucket_get_virt_irq(unsigned long bucket_pa)
 {
@@ -251,7 +253,7 @@ static int irq_choose_cpu(unsigned int virt_irq)
 	cpumask_t mask = irq_desc[virt_irq].affinity;
 	int cpuid;
 
-	if (cpus_equal(mask, CPU_MASK_ALL)) {
+	if (cpus_subset(mask, CPU_MASK_ALL)) {
 		static int irq_rover;
 		static DEFINE_SPINLOCK(irq_rover_lock);
 		unsigned long flags;
@@ -735,10 +737,12 @@ void handler_irq(int irq, struct pt_regs *regs)
 
 		next_pa = bucket_get_chain_pa(bucket_pa);
 		virt_irq = bucket_get_virt_irq(bucket_pa);
-		bucket_clear_chain_pa(bucket_pa);
 
 		desc = irq_desc + virt_irq;
 
+		if (desc->chip->set_affinity)
+			desc->chip->set_affinity(virt_irq, cpu_online_map);
+
 		desc->handle_irq(virt_irq, desc);
 
 		bucket_pa = next_pa;
