From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:35 +0000
Subject: [PATCH 7/7] Added support for ampopts in APBUART driver. Used in AMP systems.
Message-Id: <1294141295-26584-7-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/serial/apbuart.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/apbuart.c b/drivers/serial/apbuart.c
index 7160345..767ce9e 100644
--- a/drivers/serial/apbuart.c
+++ b/drivers/serial/apbuart.c
@@ -26,6 +26,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/serial_core.h>
@@ -573,7 +574,6 @@ static int __devinit apbuart_probe(struct platform_device *op,
 	printk(KERN_INFO "grlib-apbuart at 0x%llx, irq %d\n",
 	       (unsigned long long) port->mapbase, port->irq);
 	return 0;
-
 }
 
 static struct of_device_id __initdata apbuart_match[] = {
@@ -623,9 +623,12 @@ static void grlib_apbuart_configure(void)
 		int *vendor = (int *) of_get_property(np, "vendor", NULL);
 		int *device = (int *) of_get_property(np, "device", NULL);
 		int *irqs = (int *) of_get_property(np, "interrupts", NULL);
+		int *ampopts = (int *) of_get_property(np, "ampopts", NULL);
 		regs = (struct amba_prom_registers *)
 		    of_get_property(np, "reg", NULL);
 
+		if (ampopts && (*ampopts = 0))
+			continue; /* Ignore if used by another OS instance */
 		if (vendor)
 			v = *vendor;
 		if (device)
-- 
1.5.4

