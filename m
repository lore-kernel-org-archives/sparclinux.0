From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:37 +0000
Subject: [PATCH 14/14]: sparc: Move of_console_{device,path,options} info
Message-Id: <20081205.190537.240657622.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Move of_console_{device,path,options} info prom_common.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_32.c     |    9 ---------
 arch/sparc/kernel/prom_64.c     |    9 ---------
 arch/sparc/kernel/prom_common.c |    9 +++++++++
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 5ad2012..f21e8fc 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -166,15 +166,6 @@ char * __init build_path_component(struct device_node *dp)
 	return n;
 }
 
-struct device_node *of_console_device;
-EXPORT_SYMBOL(of_console_device);
-
-char *of_console_path;
-EXPORT_SYMBOL(of_console_path);
-
-char *of_console_options;
-EXPORT_SYMBOL(of_console_options);
-
 extern void restore_current(void);
 
 void __init of_console_init(void)
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index 3afb838..edecca7 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -526,15 +526,6 @@ void __init of_fill_in_cpu_data(void)
 	smp_fill_in_sib_core_maps();
 }
 
-struct device_node *of_console_device;
-EXPORT_SYMBOL(of_console_device);
-
-char *of_console_path;
-EXPORT_SYMBOL(of_console_path);
-
-char *of_console_options;
-EXPORT_SYMBOL(of_console_options);
-
 void __init of_console_init(void)
 {
 	char *msg = "OF stdout device is: %s\n";
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 95e8e5d..2736f3d 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -25,6 +25,15 @@
 
 #include "prom.h"
 
+struct device_node *of_console_device;
+EXPORT_SYMBOL(of_console_device);
+
+char *of_console_path;
+EXPORT_SYMBOL(of_console_path);
+
+char *of_console_options;
+EXPORT_SYMBOL(of_console_options);
+
 struct device_node *of_find_node_by_phandle(phandle handle)
 {
 	struct device_node *np;
-- 
1.5.6.5

