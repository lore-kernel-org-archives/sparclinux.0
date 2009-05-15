From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 15 May 2009 02:23:09 +0000
Subject: [PATCH 2/4] sparc: add sync_single_for_device and sync_sg_for_device to struct dma_ops
Message-Id: <1242354191-6232-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp

This adds sync_single_for_device() and sync_sg_for_device() to struct
dma_ops in order to unify dma-mpping_{32|64}.h. dma-mpping_32.h needs them though dma-mpping_64.h doesn't.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/sparc/include/asm/dma-mapping_64.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping_64.h b/arch/sparc/include/asm/dma-mapping_64.h
index 017ae70..0c4fb1f 100644
--- a/arch/sparc/include/asm/dma-mapping_64.h
+++ b/arch/sparc/include/asm/dma-mapping_64.h
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
 
-- 
1.6.0.6

