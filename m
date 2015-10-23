From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 23 Oct 2015 21:02:23 +0000
Subject: [PATCH 7/7 v2] drivers/nvme: default to the IOMMU page size
Message-Id: <20151023210223.GI10197@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
In-Reply-To: <20151023205420.GA10197@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We received a bug report recently when DDW (64-bit direct DMA on Power)
is not enabled for NVMe devices. In that case, we fall back to 32-bit
DMA via the IOMMU, which is always done via 4K TCEs (Translation Control
Entries).

The NVMe device driver, though, assumes that the DMA alignment for the
PRP entries will match the device's page size, and that the DMA aligment
matches the kernel's page aligment. On Power, the the IOMMU page size,
as mentioned above, can be 4K, while the device can have a page size of
8K, while the kernel has a page size of 64K. This eventually trips the
BUG_ON in nvme_setup_prps(), as we have a 'dma_len' that is a multiple
of 4K but not 8K (e.g., 0xF000).

In this particular case of page sizes, we clearly want to use the
IOMMU's page size in the driver. And generally, the NVMe driver in this
function should be using the IOMMU's page size for the default device
page size, rather than the kernel's page size.

With this patch, a NVMe device survives our internal hardware
exerciser; the kernel BUGs within a few seconds without the patch.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
v1 -> v2:
  Based upon feedback from Christoph Hellwig, implement the IOMMU page
  size lookup as a generic DMA API, rather than an architecture-specific
  hack.

 drivers/block/nvme-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6f04771..5a79106 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -18,6 +18,7 @@
 #include <linux/blk-mq.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
@@ -1711,7 +1712,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = readq(&dev->bar->cap);
 	struct nvme_queue *nvmeq;
-	unsigned page_shift = PAGE_SHIFT;
+	unsigned page_shift = dma_get_page_shift(dev->dev);
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
 	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
 
-- 
1.9.1

