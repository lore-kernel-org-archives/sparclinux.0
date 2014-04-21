From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:40 +0000
Subject: [PATCH 25/29] sparc32: fix sparse warnings in leon_kernel.c
Message-Id: <1398109184-3283-25-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
leon_kernel.c:40:15: warning: symbol 'leon3_gptimer_idx' was not declared. Should it be static?
leon_kernel.c:68:6: warning: symbol 'leon_eirq_setup' was not declared. Should it be static?
leon_kernel.c:273:13: warning: symbol 'leon_percpu_timer_ce_interrupt' was not declared. Should it be static?

Define symbols as static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index b9a2599..d939708 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -36,8 +36,8 @@ static volatile unsigned int dummy_master_l10_counter;
 unsigned long amba_system_id;
 static DEFINE_SPINLOCK(leon_irq_lock);
 
+static unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 unsigned long leon3_gptimer_irq; /* interrupt controller irq number */
-unsigned long leon3_gptimer_idx; /* Timer Index (0..6) within Timer Core */
 unsigned int sparc_leon_eirq;
 #define LEON_IMASK(cpu) (&leon3_irqctrl_regs->mask[cpu])
 #define LEON_IACK (&leon3_irqctrl_regs->iclear)
@@ -65,7 +65,7 @@ static void leon_handle_ext_irq(unsigned int irq, struct irq_desc *desc)
 }
 
 /* The extended IRQ controller has been found, this function registers it */
-void leon_eirq_setup(unsigned int eirq)
+static void leon_eirq_setup(unsigned int eirq)
 {
 	unsigned long mask, oldmask;
 	unsigned int veirq;
@@ -270,7 +270,7 @@ static u32 leon_cycles_offset(void)
 #ifdef CONFIG_SMP
 
 /* smp clockevent irq */
-irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
+static irqreturn_t leon_percpu_timer_ce_interrupt(int irq, void *unused)
 {
 	struct clock_event_device *ce;
 	int cpu = smp_processor_id();
-- 
1.8.3.1

