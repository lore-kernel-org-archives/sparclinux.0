From: Christoph Hellwig <hch@lst.de>
Date: Wed, 09 May 2018 13:59:43 +0000
Subject: [PATCH 2/7] DAC960: don't use block layer bounce buffers
Message-Id: <20180509135948.20329-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180509135948.20329-1-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org

DAC960 just sets the block bounce limit to the dma mask, which means
that the iommu or swiotlb already take care of the bounce buffering,
and the block bouncing can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/DAC960.c | 9 ++-------
 drivers/block/DAC960.h | 1 -
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f781eff7d23e..c9ba48519d0f 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -1179,7 +1179,6 @@ static bool DAC960_V1_EnableMemoryMailboxInterface(DAC960_Controller_T
 
   if (pci_set_dma_mask(Controller->PCIDevice, DMA_BIT_MASK(32)))
 	return DAC960_Failure(Controller, "DMA mask out of range");
-  Controller->BounceBufferLimit = DMA_BIT_MASK(32);
 
   if ((hw_type = DAC960_PD_Controller) || (hw_type = DAC960_P_Controller)) {
     CommandMailboxesSize =  0;
@@ -1380,11 +1379,8 @@ static bool DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
   dma_addr_t	CommandMailboxDMA;
   DAC960_V2_CommandStatus_T CommandStatus;
 
-	if (!pci_set_dma_mask(Controller->PCIDevice, DMA_BIT_MASK(64)))
-		Controller->BounceBufferLimit = DMA_BIT_MASK(64);
-	else if (!pci_set_dma_mask(Controller->PCIDevice, DMA_BIT_MASK(32)))
-		Controller->BounceBufferLimit = DMA_BIT_MASK(32);
-	else
+	if (pci_set_dma_mask(Controller->PCIDevice, DMA_BIT_MASK(64)) &&
+	    pci_set_dma_mask(Controller->PCIDevice, DMA_BIT_MASK(32)))
 		return DAC960_Failure(Controller, "DMA mask out of range");
 
   /* This is a temporary dma mapping, used only in the scope of this function */
@@ -2540,7 +2536,6 @@ static bool DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
 		continue;
   	}
   	Controller->RequestQueue[n] = RequestQueue;
-  	blk_queue_bounce_limit(RequestQueue, Controller->BounceBufferLimit);
   	RequestQueue->queuedata = Controller;
 	blk_queue_max_segments(RequestQueue, Controller->DriverScatterGatherLimit);
 	blk_queue_max_hw_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
diff --git a/drivers/block/DAC960.h b/drivers/block/DAC960.h
index 21aff470d268..1439e651928b 100644
--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -2295,7 +2295,6 @@ typedef struct DAC960_Controller
   unsigned short MaxBlocksPerCommand;
   unsigned short ControllerScatterGatherLimit;
   unsigned short DriverScatterGatherLimit;
-  u64		BounceBufferLimit;
   unsigned int CombinedStatusBufferLength;
   unsigned int InitialStatusLength;
   unsigned int CurrentStatusLength;
-- 
2.17.0

