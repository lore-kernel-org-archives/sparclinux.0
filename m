From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 05 Nov 2009 07:45:22 +0000
Subject: [PATCH 01/11] of/flattree: merge find_flat_dt_string and
Message-Id: <20091105074515.10460.83467.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
In-Reply-To: <20091105073728.10460.6061.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, benh@kernel.crashing.org, sfr@canb.auug.org.au, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu

Merge common code between Microblaze and PowerPC.  Also move instance of
---

 arch/microblaze/Kconfig       |    1 +
 arch/microblaze/kernel/prom.c |    8 --------
 arch/powerpc/Kconfig          |    1 +
 arch/powerpc/kernel/prom.c    |   12 ------------
 drivers/of/Kconfig            |    4 ++++
 drivers/of/Makefile           |    1 +
 drivers/of/fdt.c              |   21 +++++++++++++++++++++
 include/linux/of_fdt.h        |    4 ++++
 8 files changed, 32 insertions(+), 20 deletions(-)
 create mode 100644 drivers/of/fdt.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index bbd8327..f39c927 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -111,6 +111,7 @@ config CMDLINE_FORCE
 
 config OF
 	def_bool y
+	select OF_FLATTREE
 
 config PROC_DEVICETREE
 	bool "Support for device tree in /proc"
diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index b817df1..06d620a 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -47,17 +47,9 @@ static int __initdata dt_root_size_cells;
 
 typedef u32 cell_t;
 
-static struct boot_param_header *initial_boot_params;
-
 /* export that to outside world */
 struct device_node *of_chosen;
 
-static inline char *find_flat_dt_string(u32 offset)
-{
-	return ((char *)initial_boot_params) +
-		initial_boot_params->off_dt_strings + offset;
-}
-
 /**
  * This function is used to scan the flattened device-tree, it is
  * used to extract the memory informations at boot before we can
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10a0a54..5f6eed9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -163,6 +163,7 @@ config PPC_OF
 
 config OF
 	def_bool y
+	select OF_FLATTREE
 
 config PPC_UDBG_16550
 	bool
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4ec3008..fccf7e4 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -73,12 +73,6 @@ unsigned long tce_alloc_start, tce_alloc_end;
 
 typedef u32 cell_t;
 
-#if 0
-static struct boot_param_header *initial_boot_params __initdata;
-#else
-struct boot_param_header *initial_boot_params;
-#endif
-
 extern struct device_node *allnodes;	/* temporary while merging */
 
 extern rwlock_t devtree_lock;	/* temporary while merging */
@@ -86,12 +80,6 @@ extern rwlock_t devtree_lock;	/* temporary while merging */
 /* export that to outside world */
 struct device_node *of_chosen;
 
-static inline char *find_flat_dt_string(u32 offset)
-{
-	return ((char *)initial_boot_params) +
-		initial_boot_params->off_dt_strings + offset;
-}
-
 /**
  * This function is used to scan the flattened device-tree, it is
  * used to extract the memory informations at boot before we can
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index d2fa27c..462825e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -1,3 +1,7 @@
+config OF_FLATTREE
+	bool
+	depends on OF
+
 config OF_DEVICE
 	def_bool y
 	depends on OF && (SPARC || PPC_OF || MICROBLAZE)
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index bdfb5f5..f232cc9 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,4 +1,5 @@
 obj-y = base.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
 obj-$(CONFIG_OF_GPIO)   += gpio.o
 obj-$(CONFIG_OF_I2C)	+= of_i2c.o
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
new file mode 100644
index 0000000..9faa9a5
--- /dev/null
+++ b/drivers/of/fdt.c
@@ -0,0 +1,21 @@
+/*
+ * Functions for working with the Flattened Device Tree data format
+ *
+ * Copyright 2009 Benjamin Herrenschmidt, IBM Corp
+ * benh@kernel.crashing.org
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+
+struct boot_param_header *initial_boot_params;
+
+char *find_flat_dt_string(u32 offset)
+{
+	return ((char *)initial_boot_params) +
+		initial_boot_params->off_dt_strings + offset;
+}
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 41d432b..d1a79f3 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -57,7 +57,11 @@ struct boot_param_header {
 	u32	dt_struct_size;		/* size of the DT structure block */
 };
 
+/* TBD: Temporary export of fdt globals - remove when code fully merged */
+extern struct boot_param_header *initial_boot_params;
+
 /* For scanning the flat device-tree at boot time */
+extern char *find_flat_dt_string(u32 offset);
 extern int __init of_scan_flat_dt(int (*it)(unsigned long node,
 					    const char *uname, int depth,
 					    void *data),

