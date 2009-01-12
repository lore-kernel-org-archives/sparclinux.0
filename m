From: Mike Travis <travis@sgi.com>
Date: Mon, 12 Jan 2009 22:05:27 +0000
Subject: [PATCH 8/8] sparc irq: update sparc for new irq_desc
Message-Id: <20090112220520.696603000@polaris-admin.engr.sgi.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090112220519.566749000@polaris-admin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Impact: cleanup, update to new cpumask API

Irq_desc.affinity and irq_desc.pending_mask are now cpumask_var_t's
so access to them should be using the new cpumask API.

Signed-off-by: Mike Travis <travis@sgi.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: <sparclinux@vger.kernel.org>
---
 arch/sparc/kernel/irq_64.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6-for-ingo.orig/arch/sparc/kernel/irq_64.c
+++ linux-2.6-for-ingo/arch/sparc/kernel/irq_64.c
@@ -247,9 +247,10 @@ struct irq_handler_data {
 #ifdef CONFIG_SMP
 static int irq_choose_cpu(unsigned int virt_irq)
 {
-	cpumask_t mask = irq_desc[virt_irq].affinity;
+	cpumask_t mask;
 	int cpuid;
 
+	cpumask_copy(&mask, irq_desc[virt_irq].affinity);
 	if (cpus_equal(mask, CPU_MASK_ALL)) {
 		static int irq_rover;
 		static DEFINE_SPINLOCK(irq_rover_lock);
@@ -854,7 +855,7 @@ void fixup_irqs(void)
 		    !(irq_desc[irq].status & IRQ_PER_CPU)) {
 			if (irq_desc[irq].chip->set_affinity)
 				irq_desc[irq].chip->set_affinity(irq,
-					&irq_desc[irq].affinity);
+					irq_desc[irq].affinity);
 		}
 		spin_unlock_irqrestore(&irq_desc[irq].lock, flags);
 	}

-- 
