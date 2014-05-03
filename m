From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:25 +0000
Subject: [PATCH 20/34] sparc64: fix sparse warning in pci.c
Message-Id: <1399157559-19901-20-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
pci.c:886:5: warning: symbol 'pci64_dma_supported' was not declared. Should it be static?

Add proper prototype in kernel.h and delete local prototype in iommu.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/iommu.c  | 3 +--
 arch/sparc/kernel/kernel.h | 3 +++
 arch/sparc/kernel/pci.c    | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 76663b0..bfa4d0c 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -21,6 +21,7 @@
 #include <asm/iommu.h>
 
 #include "iommu_common.h"
+#include "kernel.h"
 
 #define STC_CTXMATCH_ADDR(STC, CTX)	\
 	((STC)->strbuf_ctxmatch_base + ((CTX) << 3))
@@ -840,8 +841,6 @@ static struct dma_map_ops sun4u_dma_ops = {
 struct dma_map_ops *dma_ops = &sun4u_dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
-extern int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
-
 int dma_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 5ab4bc2..eeb87f7 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -41,6 +41,9 @@ void __irq_entry smp_new_mmu_context_version_client(int irq, struct pt_regs *reg
 void __irq_entry smp_penguin_jailcell(int irq, struct pt_regs *regs);
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs);
 
+/* pci.c */
+int pci64_dma_supported(struct pci_dev *pdev, u64 device_mask);
+
 #endif
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 1555bbc..38fd867 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -28,6 +28,7 @@
 #include <asm/apb.h>
 
 #include "pci_impl.h"
+#include "kernel.h"
 
 /* List of all PCI controllers found in the system. */
 struct pci_pbm_info *pci_pbm_root = NULL;
-- 
1.9.0

