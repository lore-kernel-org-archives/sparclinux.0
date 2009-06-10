From: akpm@linux-foundation.org
Date: Wed, 10 Jun 2009 19:57:21 +0000
Subject: [patch 2/4] sparc: add sync_single_for_device and sync_sg_for_device to struct dma_ops
Message-Id: <200906101957.n5AJvLuS010298@imap1.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

This adds sync_single_for_device() and sync_sg_for_device() to struct
dma_ops in order to unify dma-mpping_{32|64}.h.  dma-mpping_32.h needs
them though dma-mpping_64.h doesn't.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Tested-by: Robert Reif <reif@earthlink.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sparc/include/asm/dma-mapping_64.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff -puN arch/sparc/include/asm/dma-mapping_64.h~sparc-add-sync_single_for_device-and-sync_sg_for_device-to-struct-dma_ops arch/sparc/include/asm/dma-mapping_64.h
--- a/arch/sparc/include/asm/dma-mapping_64.h~sparc-add-sync_single_for_device-and-sync_sg_for_device-to-struct-dma_ops
+++ a/arch/sparc/include/asm/dma-mapping_64.h
@@ -23,9 +23,15 @@ struct dma_ops {
 	void (*sync_single_for_cpu)(struct device *dev,
 				    dma_addr_t dma_handle, size_t size,
 				    enum dma_data_direction direction);
+	void (*sync_single_for_device)(struct device *dev,
+				       dma_addr_t dma_handle, size_t size,
+				       enum dma_data_direction direction);
 	void (*sync_sg_for_cpu)(struct device *dev, struct scatterlist *sg,
 				int nelems,
 				enum dma_data_direction direction);
+	void (*sync_sg_for_device)(struct device *dev,
+				   struct scatterlist *sg, int nents,
+				   enum dma_data_direction dir);
 };
 extern const struct dma_ops *dma_ops;
 
_
