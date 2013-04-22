From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 22 Apr 2013 07:23:06 +0000
Subject: [PATCH] sparc32, leon: Do not overwrite previously set irq flow handlers
Message-Id: <1366615386-3490-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is needed because when scan_of_devices finds the GAISLER_GPTIMER
core that corresponds to the SMP "ticker" timer, the previously set
proper irq flow handler gets overwritten with an incorrect one. This
leads to very flaky timer interrupt handling on some hardware. Proper
updates to handlers can still be done using leon_update_virq_handling.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 87f60ee..7c0231d 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -213,6 +213,7 @@ unsigned int leon_build_device_irq(unsigned int real_irq,
 {
 	unsigned int irq;
 	unsigned long mask;
+	struct irq_desc *desc;
 
 	irq = 0;
 	mask = leon_get_irqmask(real_irq);
@@ -226,9 +227,12 @@ unsigned int leon_build_device_irq(unsigned int real_irq,
 	if (do_ack)
 		mask |= LEON_DO_ACK_HW;
 
-	irq_set_chip_and_handler_name(irq, &leon_irq,
-				      flow_handler, name);
-	irq_set_chip_data(irq, (void *)mask);
+	desc = irq_to_desc(irq);
+	if (!desc || !desc->handle_irq || desc->handle_irq = handle_bad_irq) {
+		irq_set_chip_and_handler_name(irq, &leon_irq,
+					      flow_handler, name);
+		irq_set_chip_data(irq, (void *)mask);
+	}
 
 out:
 	return irq;
-- 
1.7.10.4

