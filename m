From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 01 Jun 2011 21:04:20 +0000
Subject: [PATCH 2/3] Do not skip interrupt sources in sun4d interrupt handler
Message-Id: <Pine.LNX.4.64.1106012243560.16937@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During the introduction of genirq on sparc32 bugs were introduced in 
the interrupt handler for sun4d. The interrupts handler checks the status 
of the various sbus interfaces in the system and generates a virtual 
interrupt, based upon the location of the interrupt source. This lookup 
was broken by restructuring the code in such a way that index and shift 
operations were performed prior to comparing this against the values 
read from the interrupt controllers.

This could cause the handler to loop eternally as the interrupt source 
could be skipped before any check was performed. Additionally 
sun4d_encode_irq performs shifting internally, so it should not be performed 
twice.

In sun4d_unmask interrupts were not correctly acknowledged, as the 
corresponding bit it the interrupt mask was not actually cleared.

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>
---

 arch/sparc/kernel/sun4d_irq.c |   48 
+++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 487c1bb..eaec8a9 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -103,10 +103,9 @@ static void sun4d_sbus_handler_irq(int sbusl)
 
 	sbil = (sbusl << 2);
 	/* Loop for each pending SBI */
-	for (sbino = 0; bus_mask; sbino++) {
+	for (sbino = 0; bus_mask; sbino++, bus_mask >>= 1) {
 		unsigned int idx, mask;
 
-		bus_mask >>= 1;
 		if (!(bus_mask & 1))
 			continue;
 		/* XXX This seems to ACK the irq twice.  acquire_sbi()
@@ -118,19 +117,16 @@ static void sun4d_sbus_handler_irq(int sbusl)
 		mask &= (0xf << sbil);
 
 		/* Loop for each pending SBI slot */
-		idx = 0;
 		slot = (1 << sbil);
-		while (mask != 0) {
+		for (idx = 0; mask != 0; idx++, slot <<= 1) {
 			unsigned int pil;
 			struct irq_bucket *p;
 
-			idx++;
-			slot <<= 1;
 			if (!(mask & slot))
 				continue;
 
 			mask &= ~slot;
-			pil = sun4d_encode_irq(sbino, sbil, idx);
+			pil = sun4d_encode_irq(sbino, sbusl, idx);
 
 			p = irq_map[pil];
 			while (p) {
@@ -218,10 +214,10 @@ static void sun4d_unmask_irq(struct irq_data *data)
 
 #ifdef CONFIG_SMP
 	spin_lock_irqsave(&sun4d_imsk_lock, flags);
-	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) | ~(1 << real_irq));
+	cc_set_imsk_other(cpuid, cc_get_imsk_other(cpuid) & ~(1 << real_irq));
 	spin_unlock_irqrestore(&sun4d_imsk_lock, flags);
 #else
-	cc_set_imsk(cc_get_imsk() | ~(1 << real_irq));
+	cc_set_imsk(cc_get_imsk() & ~(1 << real_irq));
 #endif
 }
 
