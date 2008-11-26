From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:40:41 +0000
Subject: [PATCH 1/6]: sparc64: Add interface for registering a performance
Message-Id: <20081126.004041.206416618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Add interface for registering a performance counter IRQ handler.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/irq_64.h |    3 ++
 arch/sparc64/kernel/irq.c       |   63 +++++++++++++++++++++++++++++++++++++++
 arch/sparc64/kernel/ttable.S    |    2 +-
 3 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 71673ec..d47d4a1 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -66,6 +66,9 @@ extern void virt_irq_free(unsigned int virt_irq);
 extern void __init init_IRQ(void);
 extern void fixup_irqs(void);
 
+extern int register_perfctr_intr(void (*handler)(struct pt_regs *));
+extern void release_perfctr_intr(void (*handler)(struct pt_regs *));
+
 static inline void set_softint(unsigned long bits)
 {
 	__asm__ __volatile__("wr	%0, 0x0, %%set_softint"
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index 52fc836..a3ea2bc 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -775,6 +775,69 @@ void do_softirq(void)
 	local_irq_restore(flags);
 }
 
+static void unhandled_perf_irq(struct pt_regs *regs)
+{
+	unsigned long pcr, pic;
+
+	read_pcr(pcr);
+	read_pic(pic);
+
+	write_pcr(0);
+
+	printk(KERN_EMERG "CPU %d: Got unexpected perf counter IRQ.\n",
+	       smp_processor_id());
+	printk(KERN_EMERG "CPU %d: PCR[%016lx] PIC[%016lx]\n",
+	       smp_processor_id(), pcr, pic);
+}
+
+/* Almost a direct copy of the powerpc PMC code.  */
+static DEFINE_SPINLOCK(perf_irq_lock);
+static void *perf_irq_owner_caller; /* mostly for debugging */
+static void (*perf_irq)(struct pt_regs *regs) = unhandled_perf_irq;
+
+/* Invoked from level 15 PIL handler in trap table.  */
+void perfctr_irq(int irq, struct pt_regs *regs)
+{
+	clear_softint(1 << irq);
+	perf_irq(regs);
+}
+
+int register_perfctr_intr(void (*handler)(struct pt_regs *))
+{
+	int ret;
+
+	if (!handler)
+		return -EINVAL;
+
+	spin_lock(&perf_irq_lock);
+	if (perf_irq != unhandled_perf_irq) {
+		printk(KERN_WARNING "register_perfctr_intr: "
+		       "perf IRQ busy (reserved by caller %p)\n",
+		       perf_irq_owner_caller);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	perf_irq_owner_caller = __builtin_return_address(0);
+	perf_irq = handler;
+
+	ret = 0;
+out:
+	spin_unlock(&perf_irq_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_perfctr_intr);
+
+void release_perfctr_intr(void (*handler)(struct pt_regs *))
+{
+	spin_lock(&perf_irq_lock);
+	perf_irq_owner_caller = NULL;
+	perf_irq = unhandled_perf_irq;
+	spin_unlock(&perf_irq_lock);
+}
+EXPORT_SYMBOL_GPL(release_perfctr_intr);
+
 #ifdef CONFIG_HOTPLUG_CPU
 void fixup_irqs(void)
 {
diff --git a/arch/sparc64/kernel/ttable.S b/arch/sparc64/kernel/ttable.S
index 1ade3d6..2a31ffa 100644
--- a/arch/sparc64/kernel/ttable.S
+++ b/arch/sparc64/kernel/ttable.S
@@ -66,7 +66,7 @@ tl0_irq6:	BTRAP(0x46)
 tl0_irq7:	BTRAP(0x47) BTRAP(0x48) BTRAP(0x49)
 tl0_irq10:	BTRAP(0x4a) BTRAP(0x4b) BTRAP(0x4c) BTRAP(0x4d)
 tl0_irq14:	TRAP_IRQ(timer_interrupt, 14)
-tl0_irq15:	TRAP_IRQ(handler_irq, 15)
+tl0_irq15:	TRAP_IRQ(perfctr_irq, 15)
 tl0_resv050:	BTRAP(0x50) BTRAP(0x51) BTRAP(0x52) BTRAP(0x53) BTRAP(0x54) BTRAP(0x55)
 tl0_resv056:	BTRAP(0x56) BTRAP(0x57) BTRAP(0x58) BTRAP(0x59) BTRAP(0x5a) BTRAP(0x5b)
 tl0_resv05c:	BTRAP(0x5c) BTRAP(0x5d) BTRAP(0x5e) BTRAP(0x5f)
-- 
1.5.6.5

