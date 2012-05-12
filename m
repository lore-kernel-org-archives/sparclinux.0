From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 20:30:11 +0000
Subject: [PATCH] sparc32: drop loadmmu
Message-Id: <20120512203011.GA4906@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From b66f9d7bd0b715086ac0fb16538db073b5e52f35 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 20:35:52 +0200
Subject: [PATCH] sparc32: drop loadmmu

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I am mostly refreshing my mail-box to see all the good patches
that is floating in :-)

Everything looks good so far!

	Sam

 arch/sparc/mm/Makefile  |    1 -
 arch/sparc/mm/loadmmu.c |   38 --------------------------------------
 arch/sparc/mm/srmmu.c   |    7 ++++++-
 3 files changed, 6 insertions(+), 40 deletions(-)
 delete mode 100644 arch/sparc/mm/loadmmu.c

diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 697eab7..c7f156a 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -7,7 +7,6 @@ ccflags-y := -Werror
 obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o gup.o
 obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
-obj-$(CONFIG_SPARC32)   += loadmmu.o
 obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
 obj-$(CONFIG_SPARC_LEON)+= leon_mm.o
diff --git a/arch/sparc/mm/loadmmu.c b/arch/sparc/mm/loadmmu.c
deleted file mode 100644
index 49c396d..0000000
--- a/arch/sparc/mm/loadmmu.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * loadmmu.c:  This code loads up all the mm function pointers once the
- *             machine type has been determined.  It also sets the static
- *             mmu values such as PAGE_NONE, etc.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/mmu_context.h>
-#include <asm/oplib.h>
-
-struct ctx_list *ctx_list_pool;
-struct ctx_list ctx_free;
-struct ctx_list ctx_used;
-
-extern void ld_mmu_srmmu(void);
-
-void __init load_mmu(void)
-{
-	switch(sparc_cpu_model) {
-	case sun4m:
-	case sun4d:
-	case sparc_leon:
-		ld_mmu_srmmu();
-		break;
-	default:
-		prom_printf("load_mmu: %d unsupported\n", (int)sparc_cpu_model);
-		prom_halt();
-	}
-	btfixup();
-}
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cb18fa8..a9f53c6 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -55,6 +55,10 @@ static unsigned int hwbug_bitmask;
 int vac_cache_size;
 int vac_line_size;
 
+struct ctx_list *ctx_list_pool;
+struct ctx_list ctx_free;
+struct ctx_list ctx_used;
+
 extern struct resource sparc_iomap;
 
 extern unsigned long last_valid_pfn;
@@ -2139,7 +2143,7 @@ static void smp_flush_page_for_dma(unsigned long page)
 #endif
 
 /* Load up routines and constants for sun4m and sun4d mmu */
-void __init ld_mmu_srmmu(void)
+void __init load_mmu(void)
 {
 	extern void ld_mmu_iommu(void);
 	extern void ld_mmu_iounit(void);
@@ -2280,4 +2284,5 @@ void __init ld_mmu_srmmu(void)
 	else
 		sun4m_init_smp();
 #endif
+	btfixup();
 }
-- 
1.6.0.6

