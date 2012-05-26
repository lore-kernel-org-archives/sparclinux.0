From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 14:45:09 +0000
Subject: [PATCH 3/4 (fixed)] sparc32,leon: always support leon in ioport
Message-Id: <20120526144509.GA6863@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From de66b6ab349d5b9494fc5d1597a8cf836a252b19 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 15:56:03 +0200
Subject: [PATCH 3/4] sparc32,leon: always support leon in ioport

Unconditially define pci32_dma_ops as this is used
for leon.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---

Grumble...
Fixed spelling error in subject.

	Sam

 arch/sparc/include/asm/dma-mapping.h |    9 +++++++--
 arch/sparc/kernel/ioport.c           |   11 ++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 48a7c65..8493fd3 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -12,13 +12,18 @@ extern int dma_supported(struct device *dev, u64 mask);
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
-extern struct dma_map_ops *dma_ops, pci32_dma_ops;
+extern struct dma_map_ops *dma_ops;
+extern struct dma_map_ops *leon_dma_ops;
+extern struct dma_map_ops pci32_dma_ops;
+
 extern struct bus_type pci_bus_type;
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 {
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
-	if (dev->bus = &pci_bus_type)
+	if (sparc_cpu_model = sparc_leon)
+		return leon_dma_ops;
+	else if (dev->bus = &pci_bus_type)
 		return &pci32_dma_ops;
 #endif
 	return dma_ops;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index a2846f5..8bc4db0 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -427,9 +427,6 @@ arch_initcall(sparc_register_ioport);
 #endif /* CONFIG_SBUS */
 
 
-/* LEON reuses PCI DMA ops */
-#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
-
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
@@ -657,13 +654,9 @@ struct dma_map_ops pci32_dma_ops = {
 };
 EXPORT_SYMBOL(pci32_dma_ops);
 
-#endif /* CONFIG_PCI || CONFIG_SPARC_LEON */
-
-#ifdef CONFIG_SPARC_LEON
-struct dma_map_ops *dma_ops = &pci32_dma_ops;
-#elif defined(CONFIG_SBUS)
+/* leon re-uses pci32_dma_ops */
+struct dma_map_ops *leon_dma_ops = &pci32_dma_ops;
 struct dma_map_ops *dma_ops = &sbus_dma_ops;
-#endif
 
 EXPORT_SYMBOL(dma_ops);
 
-- 
1.6.0.6

