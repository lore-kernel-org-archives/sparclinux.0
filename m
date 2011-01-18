From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 18 Jan 2011 14:10:26 +0000
Subject: [PATCH 3/6 V3] sparc/leon: Add LEON dma_ops.
Message-Id: <1295359829-27308-4-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch sets the dma_ops structure for LEON. It reuses the pci32_dma_ops.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 1b9f07c..b817481 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -409,9 +409,6 @@ struct dma_map_ops sbus_dma_ops = {
 	.sync_sg_for_device	= sbus_sync_sg_for_device,
 };
 
-struct dma_map_ops *dma_ops = &sbus_dma_ops;
-EXPORT_SYMBOL(dma_ops);
-
 static int __init sparc_register_ioport(void)
 {
 	register_proc_sparc_ioport();
@@ -423,7 +420,9 @@ arch_initcall(sparc_register_ioport);
 
 #endif /* CONFIG_SBUS */
 
-#ifdef CONFIG_PCI
+
+/* LEON reuses PCI DMA ops */
+#if defined(CONFIG_PCI) || defined(CONFIG_SPARC_LEON)
 
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
@@ -663,7 +662,16 @@ struct dma_map_ops pci32_dma_ops = {
 };
 EXPORT_SYMBOL(pci32_dma_ops);
 
-#endif /* CONFIG_PCI */
+#endif /* CONFIG_PCI || CONFIG_SPARC_LEON */
+
+#ifdef CONFIG_SPARC_LEON
+struct dma_map_ops *dma_ops = &pci32_dma_ops;
+#elif defined(CONFIG_SBUS)
+struct dma_map_ops *dma_ops = &sbus_dma_ops;
+#endif
+
+EXPORT_SYMBOL(dma_ops);
+
 
 /*
  * Return whether the given PCI device DMA address mask can be
-- 
1.6.4.1

