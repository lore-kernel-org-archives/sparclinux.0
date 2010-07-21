From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 23:40:15 +0000
Subject: [PATCH 5/5] of: remove asm/of_device.h
Message-Id: <20100721234015.7782.98378.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
In-Reply-To: <20100721232817.7782.23410.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

It is mostly unused now.  Sparc has a few defines left in it, but they
can be moved to other headers.  Removing this header means that new
architectures adding CONFIG_OF support don't need to also add this
header file.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/microblaze/include/asm/of_device.h |   13 -------------
 arch/powerpc/include/asm/of_device.h    |    3 ---
 arch/sparc/include/asm/device.h         |    2 ++
 arch/sparc/include/asm/of_device.h      |   19 -------------------
 arch/sparc/include/asm/prom.h           |    4 ++++
 include/linux/of_device.h               |    2 +-
 6 files changed, 7 insertions(+), 36 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/of_device.h
 delete mode 100644 arch/powerpc/include/asm/of_device.h
 delete mode 100644 arch/sparc/include/asm/of_device.h

diff --git a/arch/microblaze/include/asm/of_device.h b/arch/microblaze/include/asm/of_device.h
deleted file mode 100644
index 47e8d42..0000000
--- a/arch/microblaze/include/asm/of_device.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Copyright (C) 2007-2008 Michal Simek <monstr@monstr.eu>
- *
- * based on PowerPC of_device.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef _ASM_MICROBLAZE_OF_DEVICE_H
-#define _ASM_MICROBLAZE_OF_DEVICE_H
-#endif /* _ASM_MICROBLAZE_OF_DEVICE_H */
diff --git a/arch/powerpc/include/asm/of_device.h b/arch/powerpc/include/asm/of_device.h
deleted file mode 100644
index 04f7671..0000000
--- a/arch/powerpc/include/asm/of_device.h
+++ /dev/null
@@ -1,3 +0,0 @@
-#ifndef _ASM_POWERPC_OF_DEVICE_H
-#define _ASM_POWERPC_OF_DEVICE_H
-#endif /* _ASM_POWERPC_OF_DEVICE_H */
diff --git a/arch/sparc/include/asm/device.h b/arch/sparc/include/asm/device.h
index fb220e4..daa6a8a 100644
--- a/arch/sparc/include/asm/device.h
+++ b/arch/sparc/include/asm/device.h
@@ -19,6 +19,8 @@ struct dev_archdata {
 	int			numa_node;
 };
 
+extern void of_propagate_archdata(struct platform_device *bus);
+
 struct pdev_archdata {
 	struct resource		resource[PROMREG_MAX];
 	unsigned int		irqs[PROMINTR_MAX];
diff --git a/arch/sparc/include/asm/of_device.h b/arch/sparc/include/asm/of_device.h
deleted file mode 100644
index 22b9828..0000000
--- a/arch/sparc/include/asm/of_device.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _ASM_SPARC_OF_DEVICE_H
-#define _ASM_SPARC_OF_DEVICE_H
-#ifdef __KERNEL__
-
-#include <linux/device.h>
-#include <linux/of.h>
-#include <linux/mod_devicetable.h>
-#include <asm/openprom.h>
-
-extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
-extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
-
-extern void of_propagate_archdata(struct of_device *bus);
-
-/* This is just here during the transition */
-#include <linux/of_platform.h>
-
-#endif /* __KERNEL__ */
-#endif /* _ASM_SPARC_OF_DEVICE_H */
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index ac69574..d35df5a 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -51,6 +51,10 @@ extern void prom_build_devicetree(void);
 extern void of_populate_present_mask(void);
 extern void of_fill_in_cpu_data(void);
 
+struct resource;
+extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
+extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
+
 /* These routines are here to provide compatibility with how powerpc
  * handles IRQ mapping for OF device nodes.  We precompute and permanently
  * register them in the of_device objects, whereas powerpc computes them
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8cd1fe7..0f19119 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -16,12 +16,12 @@
  */
 #define of_device platform_device
 #include <linux/platform_device.h>
+#include <linux/of_platform.h> /* temporary until merge */
 
 #ifdef CONFIG_OF_DEVICE
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/mod_devicetable.h>
-#include <asm/of_device.h>
 
 #define	to_of_device(d) container_of(d, struct of_device, dev)
 

