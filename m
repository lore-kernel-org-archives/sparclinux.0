From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Aug 2018 09:29:15 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <20180828092915.GC12488@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1808272203270.28446-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

On Mon, Aug 27, 2018 at 10:04:58PM +0300, Meelis Roos wrote:
> > On Sun, Aug 26, 2018 at 10:48:44AM +0300, Meelis Roos wrote:
> > > Tried yesterdays git 4.18.0-12789-gaa5b105 on a Sun Ultra 1 with SBus 
> > > and several SBus connected devicess give DMA mapping related warnings:
> > 
> > This should have been around since the warning was added.
> > 
> > The patch below should fix it:
> > 
> > ---
> > >From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Mon, 27 Aug 2018 17:23:24 +0200
> > Subject: driver core: initialize a default DMA mask for platform device
> 
> No, it does not fix it. Dmesg from another SBus machine that conmpiled 
> it faster (Sun Ultra 2):

Based on the other thread here is a new attempt:

---
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 3641a294ed54..1738f7f12a9f 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -381,6 +381,10 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
 
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
+
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
 		       dp->full_name);
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 44e4d4435bed..60ebb1f976ab 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -675,6 +675,9 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 		dev_set_name(&op->dev, "root");
 	else
 		dev_set_name(&op->dev, "%08x", dp->phandle);
+	op->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	op->dev.dma_mask = &op->dma_mask;
+	op->dma_mask = DMA_BIT_MASK(32);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
