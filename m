From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 16 Mar 2011 15:54:24 +0000
Subject: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ Controller
Message-Id: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The AMBA Plug&Play information supports only 1 IRQ per AMBA device,
a device node in linux is an AMBA core which consists of 3 devices
(AHB Master, AHB Slave and APB Slave in any combination). The IRQ
information is really the first IRQ of a device, the Plug&Play does
not tell how many IRQs are actually present on a device so the
interrupt property of a device can impossibly tell how many IRQs
each device has, it must be up to the driver to probe the hardware
in a device-specific way simply know how many IRQs are present.

Using Virtual IRQs does not work for such devices, because VIRQ+1
is not REAL_IRQ+1. Thus, the LEON architecture needs real IRQs or
map virtual IRQs 1:1 to real IRQs.

This patch changes the VIRQ allocation to try the real IRQ if not
already taken.

LEON IRQ Controller is edge triggered, not masking or acking is
needed in the normal case, handle_simple_irq handler can be used
for that.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/irq_32.c      |   11 ++++++++---
 arch/sparc/kernel/leon_kernel.c |    2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 9ce6b97..46a573a 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -135,9 +135,14 @@ unsigned int irq_alloc(unsigned int real_irq, unsigned int pil)
 			return i;
 	}
 
-	for (i = 1; i < NR_IRQS; i++) {
-		if (!irq_table[i].irq)
-			break;
+	/* Try 1:1 map between Virtual IRQ and real IRQ */
+	if (real_irq < NR_IRQS && irq_table[real_irq].irq = 0) {
+		i = real_irq;
+	} else {
+		for (i = 1; i < NR_IRQS; i++) {
+			if (!irq_table[i].irq)
+				break;
+		}
 	}
 
 	if (i >= NR_IRQS) {
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index feaba14..0c1ae2b 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -136,7 +136,7 @@ static unsigned int leon_build_device_irq(struct platform_device *op,
 		goto out;
 
 	set_irq_chip_and_handler_name(irq, &leon_irq,
-	                              handle_level_irq, "LEON");
+				      handle_simple_irq, "LEON");
 	set_irq_chip_data(irq, (void *)mask);
 
 out:
-- 
1.5.4

