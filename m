From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2014 21:37:29 +0000
Subject: [PATCH] sparc: Add NOP dma_cache_sync() implementation.
Message-Id: <20141126.163729.360323322939266935.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This can be a NOP because we forward dma_{alloc,free}_noncoherent to
dma_{alloc,free}_coherent.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/dma-mapping.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 5b1b52a..7e064c6 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -12,6 +12,14 @@ int dma_supported(struct device *dev, u64 mask);
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+				  enum dma_data_direction dir)
+{
+	/* Since dma_{alloc,free}_noncoherent() allocated coherent memory, this
+	 * routine can be a nop.
+	 */
+}
+
 extern struct dma_map_ops *dma_ops;
 extern struct dma_map_ops *leon_dma_ops;
 extern struct dma_map_ops pci32_dma_ops;
-- 
2.1.2.532.g19b5d50

