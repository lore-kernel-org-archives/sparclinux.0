From: Andre Przywara <andre.przywara@arm.com>
Date: Thu, 17 Sep 2015 08:40:27 +0000
Subject: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
Message-Id: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Though the file lib/iommu_common.c resides in a common directory, the
code in there is actually only used by Sparc(64).
The recent change of DMA_ERROR_CODE in the ARM tree now generates a
compiler warning when compiled with LPAE support (where dma_addr_t is
u64, but unsigned long is still u32):
*********
In file included from /src/linux/include/linux/dma-mapping.h:86:0,
                 from /src/linux/lib/iommu-common.c:11:
/src/linux/lib/iommu-common.c: In function 'iommu_tbl_range_alloc':
/src/linux/arch/arm/include/asm/dma-mapping.h:16:24: warning: large
integer implicitly truncated to unsigned type [-Woverflow]
 #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                        ^
/src/linux/lib/iommu-common.c:127:10: note: in expansion of macro
'DMA_ERROR_CODE'
   return DMA_ERROR_CODE;
          ^
*********

It seems the types used in this file are not really correct, but a
fix isn't trivial.
So for the time being restrict this code to be compiled only when we
actually need it.
Compile tested on Sparc, Sparc64, PPC64, ARM, ARM64, x86.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/sparc/Kconfig | 3 +++
 lib/Makefile       | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 56442d2..1cedb7e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -93,6 +93,9 @@ config IOMMU_HELPER
 	bool
 	default y if SPARC64
 
+config IOMMU_TBL_HELPER
+	def_bool y if IOMMU_HELPER
+
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
diff --git a/lib/Makefile b/lib/Makefile
index 13a7c6a..82944a1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -113,7 +113,8 @@ obj-$(CONFIG_AUDIT_GENERIC) += audit.o
 obj-$(CONFIG_AUDIT_COMPAT_GENERIC) += compat_audit.o
 
 obj-$(CONFIG_SWIOTLB) += swiotlb.o
-obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o iommu-common.o
+obj-$(CONFIG_IOMMU_HELPER) += iommu-helper.o
+obj-$(CONFIG_IOMMU_TBL_HELPER) += iommu-common.o
 obj-$(CONFIG_FAULT_INJECTION) += fault-inject.o
 obj-$(CONFIG_NOTIFIER_ERROR_INJECTION) += notifier-error-inject.o
 obj-$(CONFIG_CPU_NOTIFIER_ERROR_INJECT) += cpu-notifier-error-inject.o
-- 
2.5.1

