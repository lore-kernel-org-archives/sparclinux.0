From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:51 +0000
Subject: [PATCH 5/7] sparc64: Use a seperate counter for timer interrupts
Message-Id: <20100412.234251.82117799.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This keeps us from having to use kstat_irqs_cpu() from the NMI handler,
the former of which is a profiled function.

Instead we use a currently empty slot in the cpu_data

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpudata_64.h |    2 +-
 arch/sparc/kernel/nmi.c             |    3 +--
 arch/sparc/kernel/time_64.c         |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 926397d..050ef35 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -17,7 +17,7 @@ typedef struct {
 	unsigned int	__nmi_count;
 	unsigned long	clock_tick;	/* %tick's per second */
 	unsigned long	__pad;
-	unsigned int	__pad1;
+	unsigned int	irq0_irqs;
 	unsigned int	__pad2;
 
 	/* Dcache line 2, rarely used */
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index b287b62..75a3d1a 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -92,7 +92,6 @@ static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
 notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 {
 	unsigned int sum, touched = 0;
-	int cpu = smp_processor_id();
 
 	clear_softint(1 << irq);
 
@@ -106,7 +105,7 @@ notrace __kprobes void perfctr_irq(int irq, struct pt_regs *regs)
 	else
 		pcr_ops->write(PCR_PIC_PRIV);
 
-	sum = kstat_irqs_cpu(0, cpu);
+	sum = local_cpu_data().irq0_irqs;
 	if (__get_cpu_var(nmi_touch)) {
 		__get_cpu_var(nmi_touch) = 0;
 		touched = 1;
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 67e1651..f25858e 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -728,6 +728,7 @@ void timer_interrupt(int irq, struct pt_regs *regs)
 
 	irq_enter();
 
+	local_cpu_data().irq0_irqs++;
 	kstat_incr_irqs_this_cpu(0, irq_to_desc(0));
 
 	if (unlikely(!evt->event_handler)) {
-- 
1.7.0.4

