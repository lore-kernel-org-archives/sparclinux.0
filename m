From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:19 +0000
Subject: [PATCH 48/49]: sparc: Delete asm/sbus*.h
Message-Id: <20080827.212519.149328814.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Delete asm/sbus*.h

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus.h    |    8 ------
 arch/sparc/include/asm/sbus_32.h |   52 --------------------------------------
 arch/sparc/include/asm/sbus_64.h |   48 -----------------------------------
 3 files changed, 0 insertions(+), 108 deletions(-)
 delete mode 100644 arch/sparc/include/asm/sbus.h
 delete mode 100644 arch/sparc/include/asm/sbus_32.h
 delete mode 100644 arch/sparc/include/asm/sbus_64.h

diff --git a/arch/sparc/include/asm/sbus.h b/arch/sparc/include/asm/sbus.h
deleted file mode 100644
index f82481a..0000000
--- a/arch/sparc/include/asm/sbus.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef ___ASM_SPARC_SBUS_H
-#define ___ASM_SPARC_SBUS_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/sbus_64.h>
-#else
-#include <asm/sbus_32.h>
-#endif
-#endif
diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
deleted file mode 100644
index d960f3e..0000000
--- a/arch/sparc/include/asm/sbus_32.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * sbus.h:  Defines for the Sun SBus.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _SPARC_SBUS_H
-#define _SPARC_SBUS_H
-
-#include <linux/dma-mapping.h>
-#include <linux/ioport.h>
-#include <linux/of_device.h>
-
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/scatterlist.h>
-
-/* We scan which devices are on the SBus using the PROM node device
- * tree.  SBus devices are described in two different ways.  You can
- * either get an absolute address at which to access the device, or
- * you can get a SBus 'slot' number and an offset within that slot.
- */
-
-struct sbus_bus;
-
-/* Linux SBUS device tables */
-struct sbus_dev {
-	struct of_device	ofdev;
-	struct sbus_bus		*bus;
-	struct sbus_dev		*next;
-	struct sbus_dev		*child;
-	struct sbus_dev		*parent;
-};
-#define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
-
-/* This struct describes the SBus(s) found on this machine. */
-struct sbus_bus {
-	struct of_device	ofdev;
-	struct sbus_dev		*devices;	/* Link to devices on this SBus */
-	struct sbus_bus		*next;		/* next SBus, if more than one SBus */
-};
-#define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
-
-/* These yield IOMMU mappings in consistent mode. */
-void prom_adjust_ranges(struct linux_prom_ranges *, int,
-			struct linux_prom_ranges *, int);
-
-extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
-extern int sbus_arch_preinit(void);
-extern void sbus_arch_postinit(void);
-
-#endif /* !(_SPARC_SBUS_H) */
diff --git a/arch/sparc/include/asm/sbus_64.h b/arch/sparc/include/asm/sbus_64.h
deleted file mode 100644
index b7b7694..0000000
--- a/arch/sparc/include/asm/sbus_64.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* sbus.h: Defines for the Sun SBus.
- *
- * Copyright (C) 1996, 1999, 2007 David S. Miller (davem@davemloft.net)
- */
-
-#ifndef _SPARC64_SBUS_H
-#define _SPARC64_SBUS_H
-
-#include <linux/dma-mapping.h>
-#include <linux/ioport.h>
-#include <linux/of_device.h>
-
-#include <asm/oplib.h>
-#include <asm/prom.h>
-#include <asm/iommu.h>
-#include <asm/scatterlist.h>
-
-/* We scan which devices are on the SBus using the PROM node device
- * tree.  SBus devices are described in two different ways.  You can
- * either get an absolute address at which to access the device, or
- * you can get a SBus 'slot' number and an offset within that slot.
- */
-
-struct sbus_bus;
-
-/* Linux SBUS device tables */
-struct sbus_dev {
-	struct of_device	ofdev;
-	struct sbus_bus		*bus;
-	struct sbus_dev		*next;
-	struct sbus_dev		*child;
-	struct sbus_dev		*parent;
-};
-#define to_sbus_device(d) container_of(d, struct sbus_dev, ofdev.dev)
-
-/* This struct describes the SBus(s) found on this machine. */
-struct sbus_bus {
-	struct of_device	ofdev;
-	struct sbus_dev		*devices;	/* Tree of SBUS devices	*/
-	struct sbus_bus		*next;		/* Next SBUS in system	*/
-};
-#define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
-
-extern void sbus_setup_iommu(struct sbus_bus *, struct device_node *);
-extern int sbus_arch_preinit(void);
-extern void sbus_arch_postinit(void);
-
-#endif /* !(_SPARC64_SBUS_H) */
-- 
1.5.6.5.GIT

