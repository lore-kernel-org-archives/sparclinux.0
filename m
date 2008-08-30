From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 10:19:10 +0000
Subject: [PATCH 1/6]: sparc64: Don't invoke power_init() from
Message-Id: <20080830.031910.216653021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Don't invoke power_init() from pcibios_init().

That's just silly, use device_initcall() instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c   |    4 ----
 arch/sparc64/kernel/power.c |   16 +++++-----------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 2187786..83c50a6 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -799,8 +799,6 @@ static void __init pci_scan_each_controller_bus(void)
 		pbm->scan_bus(pbm);
 }
 
-extern void power_init(void);
-
 static int __init pcibios_init(void)
 {
 	pci_controller_probe();
@@ -809,8 +807,6 @@ static int __init pcibios_init(void)
 
 	pci_scan_each_controller_bus();
 
-	power_init();
-
 	return 0;
 }
 
diff --git a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
index 3bb987a..7536255 100644
--- a/arch/sparc64/kernel/power.c
+++ b/arch/sparc64/kernel/power.c
@@ -1,29 +1,22 @@
 /* power.c: Power management driver.
  *
- * Copyright (C) 1999, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1999, 2007, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/pm.h>
-#include <linux/syscalls.h>
 #include <linux/reboot.h>
 #include <linux/of_device.h>
 
-#include <asm/system.h>
 #include <asm/auxio.h>
 #include <asm/prom.h>
 #include <asm/io.h>
 #include <asm/sstate.h>
 #include <asm/reboot.h>
 
-#include <linux/unistd.h>
-
 /*
  * sysctl - toggle power-off restriction for serial console 
  * systems in machine_power_off()
@@ -111,8 +104,9 @@ static struct of_platform_driver power_driver = {
 	},
 };
 
-void __init power_init(void)
+static int __init power_init(void)
 {
-	of_register_driver(&power_driver, &of_platform_bus_type);
-	return;
+	return of_register_driver(&power_driver, &of_platform_bus_type);
 }
+
+device_initcall(power_init);
-- 
1.5.6.5.GIT

