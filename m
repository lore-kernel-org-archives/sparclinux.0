From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 23 Feb 2014 21:40:15 +0000
Subject: [patch 13/26] sparc: Use the core irq stats function
Message-Id: <20140223212737.635609567@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20140223212703.511977310@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, sparc <sparclinux@vger.kernel.org>

Let the core do the irq_desc resolution.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparc <sparclinux@vger.kernel.org>
---
 arch/sparc/kernel/time_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/arch/sparc/kernel/time_64.c
=================================--- tip.orig/arch/sparc/kernel/time_64.c
+++ tip/arch/sparc/kernel/time_64.c
@@ -733,7 +733,7 @@ void __irq_entry timer_interrupt(int irq
 	irq_enter();
 
 	local_cpu_data().irq0_irqs++;
-	kstat_incr_irqs_this_cpu(0, irq_to_desc(0));
+	kstat_incr_irq_this_cpu(0);
 
 	if (unlikely(!evt->event_handler)) {
 		printk(KERN_WARNING


