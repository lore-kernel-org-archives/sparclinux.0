From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 27 Apr 2011 13:19:39 +0000
Subject: [PATCH 3/3] sparc32,sun4m: Implemented SMP IPIs support for SUN4M machines
Message-Id: <1303910379-32209-3-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Implement the three IPIs (resched, single and cpu-mask) generation
and interrupt handler catch. The sun4m has 15 soft-IRQs and three
of them is used with this patch, the three IPIs was previously
implmented with the cross-call IRQ15 which does not work locking
routines such as spinlocks because IRQ15 is NMI, it causes deadlock.

The IRQ trap handler code assumes (in the same spritit as the old
it seems) that hard interrupts will be generated until handled
(level), when a IRQ happens the IRQ pending register is checked
for pending soft-IRQs. When both hard and soft IRQ happens at the
same time only soft-IRQs are handled.

The old code implemented a soft-IRQ traphandler at IRQ14 which
called smp_reschedule_irq which in turn called set_need_resched.
It seems to be an old relic and is replaced with the interrupt
traphander exit code RESTORE_ALL, it calls schedule() when
appropriate.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/entry.S     |   29 +++++++++++++++++++++++++----
 arch/sparc/kernel/smp_32.c    |    5 -----
 arch/sparc/kernel/sun4m_smp.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index c5962d0..64353f8 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -269,19 +269,22 @@ smp4m_ticker:
 	/* Here is where we check for possible SMP IPI passed to us
 	 * on some level other than 15 which is the NMI and only used
 	 * for cross calls.  That has a separate entry point below.
+	 *
+	 * IPIs are sent on Level 12, 13 and 14. See IRQ_IPI_*.
 	 */
 maybe_smp4m_msg:
 	GET_PROCESSOR4M_ID(o3)
 	sethi	%hi(sun4m_irq_percpu), %l5
 	sll	%o3, 2, %o3
 	or	%l5, %lo(sun4m_irq_percpu), %o5
-	sethi	%hi(0x40000000), %o2
+	sethi	%hi(0x70000000), %o2	! Check all soft-IRQs
 	ld	[%o5 + %o3], %o1
 	ld	[%o1 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
 	andcc	%o3, %o2, %g0
 	be,a	smp4m_ticker
 	 cmp	%l7, 14
-	st	%o2, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x40000000
+	/* Soft-IRQ IPI */
+	st	%o2, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x70000000
 	WRITE_PAUSE
 	ld	[%o1 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
 	WRITE_PAUSE
@@ -290,9 +293,27 @@ maybe_smp4m_msg:
 	WRITE_PAUSE
 	wr	%l4, PSR_ET, %psr
 	WRITE_PAUSE
-	call	smp_reschedule_irq
+	sll	%o2, 28, %o2		! shift for simpler checks below
+maybe_smp4m_msg_check_single:
+	andcc	%o2, 0x1, %g0
+	beq,a	maybe_smp4m_msg_check_mask
+	 andcc	%o2, 0x2, %g0
+	call	smp_call_function_single_interrupt
 	 nop
-
+	andcc	%o2, 0x2, %g0
+maybe_smp4m_msg_check_mask:
+	beq,a	maybe_smp4m_msg_check_resched
+	 andcc	%o2, 0x4, %g0
+	call	smp_call_function_interrupt
+	 nop
+	andcc	%o2, 0x4, %g0
+maybe_smp4m_msg_check_resched:
+	/* rescheduling is done in RESTORE_ALL regardless, but incr stats */
+	beq,a	maybe_smp4m_msg_out
+	 nop
+	call	smp_resched_interrupt
+	 nop
+maybe_smp4m_msg_out:
 	RESTORE_ALL
 
 	.align	4
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 2710602..705a94e 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -267,11 +267,6 @@ void smp_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 	}
 }
 
-void smp_reschedule_irq(void)
-{
-	set_need_resched();
-}
-
 void smp_flush_page_to_ram(unsigned long page)
 {
 	/* Current theory is that those who call this are the one's
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 58b8d84..32289e7 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -15,6 +15,9 @@
 #include "irq.h"
 #include "kernel.h"
 
+#define IRQ_IPI_SINGLE		12
+#define IRQ_IPI_MASK		13
+#define IRQ_IPI_RESCHED		14
 #define IRQ_CROSS_CALL		15
 
 static inline unsigned long
@@ -26,6 +29,7 @@ swap_ulong(volatile unsigned long *ptr, unsigned long val)
 	return val;
 }
 
+static void smp4m_ipi_init(void);
 static void smp_setup_percpu_timer(void);
 
 void __cpuinit smp4m_callin(void)
@@ -83,6 +87,7 @@ void __cpuinit smp4m_callin(void)
  */
 void __init smp4m_boot_cpus(void)
 {
+	smp4m_ipi_init();
 	smp_setup_percpu_timer();
 	local_flush_cache_all();
 }
@@ -150,6 +155,27 @@ void __init smp4m_smp_done(void)
 	/* Ok, they are spinning and ready to go. */
 }
 
+
+/* Initialize IPIs on the SUN4M SMP machine */
+static void __init smp4m_ipi_init(void)
+{
+}
+
+static void smp4m_ipi_resched(int cpu)
+{
+	set_cpu_int(cpu, IRQ_IPI_RESCHED);
+}
+
+static void smp4m_ipi_single(int cpu)
+{
+	set_cpu_int(cpu, IRQ_IPI_SINGLE);
+}
+
+static void smp4m_ipi_mask_one(int cpu)
+{
+	set_cpu_int(cpu, IRQ_IPI_MASK);
+}
+
 static struct smp_funcall {
 	smpfunc_t func;
 	unsigned long arg1;
@@ -292,4 +318,7 @@ void __init sun4m_init_smp(void)
 	BTFIXUPSET_BLACKBOX(load_current, smp4m_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_resched, smp4m_ipi_resched, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_single, smp4m_ipi_single, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4m_ipi_mask_one, BTFIXUPCALL_NORM);
 }
-- 
1.5.4

