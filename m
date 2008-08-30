From: David Miller <davem@davemloft.net>
Date: Sat, 30 Aug 2008 07:58:43 +0000
Subject: [PATCH 6/6]: sparc: Kill ebus_bus_type.
Message-Id: <20080830.005843.117192442.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill ebus_bus_type.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/of_platform.h |    2 --
 arch/sparc/kernel/of_device.c        |   10 ----------
 arch/sparc64/kernel/of_device.c      |   10 ----------
 3 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/include/asm/of_platform.h b/arch/sparc/include/asm/of_platform.h
index 71ada52..90da990 100644
--- a/arch/sparc/include/asm/of_platform.h
+++ b/arch/sparc/include/asm/of_platform.h
@@ -13,8 +13,6 @@
  *
  */
 
-extern struct bus_type ebus_bus_type;
-
 #define of_bus_type	of_platform_bus_type	/* for compatibility */
 
 #endif
diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index 576fa2f..c590148 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -62,11 +62,6 @@ void of_propagate_archdata(struct of_device *bus)
 	}
 }
 
-#ifdef CONFIG_PCI
-struct bus_type ebus_bus_type;
-EXPORT_SYMBOL(ebus_bus_type);
-#endif
-
 struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
@@ -584,11 +579,6 @@ static int __init of_bus_driver_init(void)
 	int err;
 
 	err = of_bus_type_init(&of_platform_bus_type, "of");
-#ifdef CONFIG_PCI
-	if (!err)
-		err = of_bus_type_init(&ebus_bus_type, "ebus");
-#endif
-
 	if (!err)
 		scan_of_devices();
 
diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 6ae9253..e427086 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -88,11 +88,6 @@ void of_propagate_archdata(struct of_device *bus)
 	}
 }
 
-#ifdef CONFIG_PCI
-struct bus_type ebus_bus_type;
-EXPORT_SYMBOL(ebus_bus_type);
-#endif
-
 struct bus_type of_platform_bus_type;
 EXPORT_SYMBOL(of_platform_bus_type);
 
@@ -865,11 +860,6 @@ static int __init of_bus_driver_init(void)
 	int err;
 
 	err = of_bus_type_init(&of_platform_bus_type, "of");
-#ifdef CONFIG_PCI
-	if (!err)
-		err = of_bus_type_init(&ebus_bus_type, "ebus");
-#endif
-
 	if (!err)
 		scan_of_devices();
 
-- 
1.5.6.5.GIT

