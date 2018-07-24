From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 24 Jul 2018 11:53:04 +0000
Subject: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Message-Id: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Hanna Hawa <hannah@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>

The definitions in arch/sparc/include/asm/msi.h are only used in
arch/sparc/mm/srmmu.c, so it makes sense to have them in the C file
directly.

In addition, having a custom arch/sparc/include/asm/msi.h prevents
from using the asm-generic version of this header, which is necessary
to be able to include <linux/msi.h> when CONFIG_GENERIC_MSI_IRQ_DOMAIN
is enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sparc/include/asm/msi.h | 32 --------------------------------
 arch/sparc/mm/srmmu.c        | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 33 deletions(-)
 delete mode 100644 arch/sparc/include/asm/msi.h

diff --git a/arch/sparc/include/asm/msi.h b/arch/sparc/include/asm/msi.h
deleted file mode 100644
index 3c17c1074431..000000000000
--- a/arch/sparc/include/asm/msi.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * msi.h:  Defines specific to the MBus - Sbus - Interface.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Eddie C. Dost   (ecd@skynet.be)
- */
-
-#ifndef _SPARC_MSI_H
-#define _SPARC_MSI_H
-
-/*
- * Locations of MSI Registers.
- */
-#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
-
-/*
- * Useful bits in the MSI Registers.
- */
-#define MSI_ASYNC_MODE  0x80000000	/* Operate the MSI asynchronously */
-
-
-static inline void msi_set_sync(void)
-{
-	__asm__ __volatile__ ("lda [%0] %1, %%g3\n\t"
-			      "andn %%g3, %2, %%g3\n\t"
-			      "sta %%g3, [%0] %1\n\t" : :
-			      "r" (MSI_MBUS_ARBEN),
-			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
-}
-
-#endif /* !(_SPARC_MSI_H) */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 1d70c3f6d986..be9cb0065179 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -37,7 +37,6 @@
 #include <asm/mbus.h>
 #include <asm/page.h>
 #include <asm/asi.h>
-#include <asm/msi.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 
@@ -116,6 +115,25 @@ static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
 	set_pte((pte_t *)ctxp, pte);
 }
 
+/*
+ * Locations of MSI Registers.
+ */
+#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
+
+/*
+ * Useful bits in the MSI Registers.
+ */
+#define MSI_ASYNC_MODE  0x80000000	/* Operate the MSI asynchronously */
+
+static void msi_set_sync(void)
+{
+	__asm__ __volatile__ ("lda [%0] %1, %%g3\n\t"
+			      "andn %%g3, %2, %%g3\n\t"
+			      "sta %%g3, [%0] %1\n\t" : :
+			      "r" (MSI_MBUS_ARBEN),
+			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
+}
+
 void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
-- 
2.14.4

