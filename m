From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 19:16:40 +0000
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-Id: <20180424191640.GA32495@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de> <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
In-Reply-To: <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greentime Hu <green.hu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Greentime,

thanks for testing the patch!

It looks like nds32 doesn't have a buildbot yet, so this code didn't
even get syntax checkin, sorry.

Below is the incremental fixes based on this thread.

Can you check if my tree works if you just revert the
"nds32: use generic dma_noncoherent_ops" commit?

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index 688f1a03dee6..48018275e7f4 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -330,7 +330,7 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
 	unsigned long start = (unsigned long)addr;
 
-	switch (direction) {
+	switch (dir) {
 	case DMA_FROM_DEVICE:
 		break;
 	case DMA_TO_DEVICE:
@@ -350,12 +350,12 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	void *addr = kmap_atomic_pfn(PHYS_PFN(paddr));
 	unsigned long start = (unsigned long)addr;
 
-	switch (direction) {
+	switch (dir) {
 	case DMA_TO_DEVICE:
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		cpu_dma_inval_range(start, end);
+		cpu_dma_inval_range(start, start + size);
 		break;
 	default:
 		BUG();
