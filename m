From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:36 +0000
Subject: [PATCH 4/6]: sparc32: Convert PC RTC probing to pure OF driver.
Message-Id: <20080830.005836.126025524.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Convert PC RTC probing to pure OF driver.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/char/rtc.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/char/rtc.c b/drivers/char/rtc.c
index f53d4d0..b47710c 100644
--- a/drivers/char/rtc.c
+++ b/drivers/char/rtc.c
@@ -88,12 +88,12 @@
 #endif
 
 #ifdef CONFIG_SPARC32
-#include <linux/pci.h>
-#include <linux/jiffies.h>
-#include <asm/ebus.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <asm/io.h>
 
 static unsigned long rtc_port;
-static int rtc_irq = PCI_IRQ_NONE;
+static int rtc_irq;
 #endif
 
 #ifdef	CONFIG_HPET_RTC_IRQ
@@ -973,8 +973,8 @@ static int __init rtc_init(void)
 	char *guess = NULL;
 #endif
 #ifdef CONFIG_SPARC32
-	struct linux_ebus *ebus;
-	struct linux_ebus_device *edev;
+	struct device_node *ebus_dp;
+	struct of_device *op;
 #else
 	void *r;
 #ifdef RTC_IRQ
@@ -983,12 +983,16 @@ static int __init rtc_init(void)
 #endif
 
 #ifdef CONFIG_SPARC32
-	for_each_ebus(ebus) {
-		for_each_ebusdev(edev, ebus) {
-			if (strcmp(edev->prom_node->name, "rtc") = 0) {
-				rtc_port = edev->resource[0].start;
-				rtc_irq = edev->irqs[0];
-				goto found;
+	for_each_node_by_name(ebus_dp, "ebus") {
+		struct device_node *dp;
+		for (dp = ebus_dp; dp; dp = dp->sibling) {
+			if (!strcmp(dp->name, "rtc")) {
+				op = of_find_device_by_node(dp);
+				if (op) {
+					rtc_port = op->resource[0].start;
+					rtc_irq = op->irqs[0];
+					goto found;
+				}
 			}
 		}
 	}
@@ -997,7 +1001,7 @@ static int __init rtc_init(void)
 	return -EIO;
 
 found:
-	if (rtc_irq = PCI_IRQ_NONE) {
+	if (!rtc_irq) {
 		rtc_has_irq = 0;
 		goto no_irq;
 	}
-- 
1.5.6.5.GIT

