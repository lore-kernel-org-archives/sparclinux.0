From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:55:52 +0000
Subject: [PATCH 2/3]: sparc32: Setup OF bus layer earlier.
Message-Id: <20080910.235552.79921728.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Setup OF bus layer earlier.

This will allow us to use the OF driver layer for counters,
timers, interrupt controllers, etc. which need to initialize
before initcalls are run.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/of_device.c |    6 ++----
 arch/sparc/kernel/prom.c      |    4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device.c b/arch/sparc/kernel/of_device.c
index c88af7e..6e0f110 100644
--- a/arch/sparc/kernel/of_device.c
+++ b/arch/sparc/kernel/of_device.c
@@ -601,7 +601,7 @@ static void __init scan_of_devices(void)
 	scan_tree(root->child, &parent->dev);
 }
 
-static int __init of_bus_driver_init(void)
+int __init of_bus_driver_init(void)
 {
 	int err;
 
@@ -612,8 +612,6 @@ static int __init of_bus_driver_init(void)
 	return err;
 }
 
-postcore_initcall(of_bus_driver_init);
-
 static int __init of_debug(char *str)
 {
 	int val = 0;
@@ -624,4 +622,4 @@ static int __init of_debug(char *str)
 	return 1;
 }
 
-__setup("of_debug=", of_debug);
+early_param("of_debug=", of_debug);
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index eee5efc..3510561 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -547,6 +547,8 @@ static void __init of_console_init(void)
 	printk(msg, of_console_path);
 }
 
+extern int __init of_bus_driver_init(void);
+
 void __init prom_build_devicetree(void)
 {
 	struct device_node **nextp;
@@ -563,4 +565,6 @@ void __init prom_build_devicetree(void)
 
 	printk("PROM: Built device tree with %u bytes of memory.\n",
 	       prom_early_allocated);
+
+	of_bus_driver_init();
 }
-- 
1.5.6.5.GIT

