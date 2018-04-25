From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Apr 2018 05:15:37 +0000
Subject: [PATCH 11/13] mips,unicore32: swiotlb doesn't need sg->dma_length
Message-Id: <20180425051539.1989-12-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180425051539.1989-1-hch@lst.de>
In-Reply-To: <20180425051539.1989-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
swiotlb.  swiotlb itself never merges segements and doesn't accesses the
dma_length field directly, so drop the dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/Kconfig | 1 -
 arch/mips/loongson64/Kconfig    | 1 -
 arch/unicore32/mm/Kconfig       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 5d73041547a7..eb5faeed4f66 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -70,7 +70,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
 
 config OCTEON_ILM
 	tristate "Module to measure interrupt latency using Octeon CIU Timer"
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 641a1477031e..2a4fb91adbb6 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -135,7 +135,6 @@ config SWIOTLB
 	default y
 	depends on CPU_LOONGSON3
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
 
 config PHYS48_TO_HT40
diff --git a/arch/unicore32/mm/Kconfig b/arch/unicore32/mm/Kconfig
index 1d9fed0ada71..45b7f769375e 100644
--- a/arch/unicore32/mm/Kconfig
+++ b/arch/unicore32/mm/Kconfig
@@ -43,4 +43,3 @@ config CPU_TLB_SINGLE_ENTRY_DISABLE
 config SWIOTLB
 	def_bool y
 	select DMA_DIRECT_OPS
-	select NEED_SG_DMA_LENGTH
-- 
2.17.0

