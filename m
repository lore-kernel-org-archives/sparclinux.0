From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:13 +0000
Subject: [PATCH 45/49]: sparc: Kill sbus_bus_type.
Message-Id: <20080827.212513.175785898.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill sbus_bus_type.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/of_platform.h |    1 -
 arch/sparc/kernel/of_device.c        |    9 ---------
 arch/sparc64/kernel/of_device.c      |    9 ---------
 3 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/sparc/include/asm/of_platform.h b/arch/sparc/include/asm/of_platform.h
index 2348ab9..71ada52 100644
--- a/arch/sparc/include/asm/of_platform.h
+++ b/arch/sparc/include/asm/of_platform.h
@@ -14,7 +14,6 @@
  */
 
 extern struct bus_type ebus_bus_type;
-extern struct bus_type sbus_bus_type;
 
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 8fdc1b3..576fa2f 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -67,11 +67,6 @@ struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
 
-#ifdef CONFIG_SBUS
-struct bus_type sbus_bus_type;
-EXPORT_SYMBOL(sbus_bus_type);
-#endif
-
 struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
@@ -593,10 +588,6 @@ static int __init of_bus_driver_init(void)
 	if (!err)
 		err = of_bus_type_init(&ebus_bus_type, "ebus");
 #endif
-#ifdef CONFIG_SBUS
-	if (!err)
-		err = of_bus_type_init(&sbus_bus_type, "sbus");
-#endif
 
 	if (!err)
 		scan_of_devices();
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index b22475f..6ae9253 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -93,11 +93,6 @@ struct bus_type ebus_bus_type;
 EXPORT_SYMBOL(ebus_bus_type);
 #endif
 
-#ifdef CONFIG_SBUS
-struct bus_type sbus_bus_type;
-EXPORT_SYMBOL(sbus_bus_type);
-#endif
-
 struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
@@ -874,10 +869,6 @@ static int __init of_bus_driver_init(void)
 	if (!err)
 		err = of_bus_type_init(&ebus_bus_type, "ebus");
 #endif
-#ifdef CONFIG_SBUS
-	if (!err)
-		err = of_bus_type_init(&sbus_bus_type, "sbus");
-#endif
 
 	if (!err)
 		scan_of_devices();
-- 
1.5.6.5.GIT

