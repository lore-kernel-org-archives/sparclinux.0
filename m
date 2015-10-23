From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 20:56:10 +0000
Subject: [PATCH 1/7 v3] dma-mapping: add generic dma_get_page_shift API
Message-Id: <20151023205610.GB10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Drivers like NVMe need to be able to determine the page size used for
DMA transfers. Add a new API that defaults to return PAGE_SHIFT on all
architectures.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Based upon feedback from Christoph Hellwig, implement the IOMMU page
  size lookup as a generic DMA API, rather than an architecture-specific
  hack.
v2 -> v3:
  Based upon feedback from Christoph Hellwig that not all architectures
  have moved to dma-mapping-common.h, so move the #ifdef and default to
  linux/dma-mapping.h.
---
 include/linux/dma-mapping.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac07ff0..7eaba8d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -95,6 +95,13 @@ static inline u64 dma_get_mask(struct device *dev)
 	return DMA_BIT_MASK(32);
 }
 
+#ifndef HAVE_ARCH_DMA_GET_PAGE_SHIFT
+static inline unsigned long dma_get_page_shift(struct device *dev)
+{
+	return PAGE_SHIFT;
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 #else
-- 
1.9.1

