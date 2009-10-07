From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 07 Oct 2009 04:30:59 +0000
Subject: [RFC PATCH 05/12] of: add common header for flattened device tree
Message-Id: <20091007043052.16890.15975.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net, sparclinux@vger.kernel.org, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org

Add a common header file for working with the flattened device tree
data structure and merge the shared data tags used by Microblaze and
PowerPC

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/include/asm/prom.h |   12 +-----------
 arch/powerpc/include/asm/prom.h    |   12 +-----------
 include/linux/of_fdt.h             |   30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/of_fdt.h

diff --git a/arch/microblaze/include/asm/prom.h b/arch/microblaze/include/asm/prom.h
index 64e8b3a..5f461f0 100644
--- a/arch/microblaze/include/asm/prom.h
+++ b/arch/microblaze/include/asm/prom.h
@@ -17,20 +17,10 @@
 #ifndef _ASM_MICROBLAZE_PROM_H
 #define _ASM_MICROBLAZE_PROM_H
 #ifdef __KERNEL__
-
-/* Definitions used by the flattened device tree */
-#define OF_DT_HEADER		0xd00dfeed /* marker */
-#define OF_DT_BEGIN_NODE	0x1 /* Start of node, full name */
-#define OF_DT_END_NODE		0x2 /* End node */
-#define OF_DT_PROP		0x3 /* Property: name off, size, content */
-#define OF_DT_NOP		0x4 /* nop */
-#define OF_DT_END		0x9
-
-#define OF_DT_VERSION		0x10
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
+#include <linux/of_fdt.h>
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index c918db5..7181f8a 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -17,6 +17,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <linux/types.h>
+#include <linux/of_fdt.h>
 #include <linux/proc_fs.h>
 #include <linux/platform_device.h>
 #include <asm/irq.h>
@@ -29,17 +30,6 @@
 #define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
 #define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
 
-/* Definitions used by the flattened device tree */
-#define OF_DT_HEADER		0xd00dfeed	/* marker */
-#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
-#define OF_DT_END_NODE		0x2		/* End node */
-#define OF_DT_PROP		0x3		/* Property: name off, size,
-						 * content */
-#define OF_DT_NOP		0x4		/* nop */
-#define OF_DT_END		0x9
-
-#define OF_DT_VERSION		0x10
-
 /*
  * This is what gets passed to the kernel by prom_init or kexec
  *
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
new file mode 100644
index 0000000..f81d3f8
--- /dev/null
+++ b/include/linux/of_fdt.h
@@ -0,0 +1,30 @@
+/*
+ * Definitions for working with the Flattened Device Tree data format
+ *
+ * Copyright (C) 1996-2005 Paul Mackerras.
+ *
+ * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
+ * Updates for SPARC by David S. Miller
+ * Merged to common code by Grant Likely
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LINUX_OF_FDT_H
+#define _LINUX_OF_FDT_H
+
+/* Definitions used by the flattened device tree */
+#define OF_DT_HEADER		0xd00dfeed	/* marker */
+#define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
+#define OF_DT_END_NODE		0x2		/* End node */
+#define OF_DT_PROP		0x3		/* Property: name off, size,
+						 * content */
+#define OF_DT_NOP		0x4		/* nop */
+#define OF_DT_END		0x9
+
+#define OF_DT_VERSION		0x10
+
+#endif /* _LINUX_OF_FDT_H */

