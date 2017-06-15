From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 14:40:58 +0000
Subject: [v1 1/2] sparc64: use prom interface to get %stick frequency
Message-Id: <1497537659-419752-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We initialize time early, we must use prom interface instead of open
firmware driver, which is not yet initialized.

Also, use prom_getintdefault() instead of prom_getint() to be compatible
with the code before early boot timestamps project.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/sparc/kernel/time_64.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index a612a91..a62758c 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -32,7 +32,6 @@
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ftrace.h>
 
@@ -257,7 +256,7 @@ static int stick_add_compare(unsigned long adj)
 
 static unsigned long stick_get_frequency(void)
 {
-	return prom_getint(prom_root_node, "stick-frequency");
+	return prom_getintdefault(prom_root_node, "stick-frequency", 0);
 }
 
 static struct sparc64_tick_ops stick_operations __read_mostly = {
@@ -391,9 +390,7 @@ static int hbtick_add_compare(unsigned long adj)
 
 static unsigned long hbtick_get_frequency(void)
 {
-	struct device_node *dp = of_find_node_by_path("/");
-
-	return of_getintprop_default(dp, "stick-frequency", 0);
+	return prom_getintdefault(prom_root_node, "stick-frequency", 0);
 }
 
 static struct sparc64_tick_ops hbtick_operations __read_mostly = {
-- 
1.7.1

