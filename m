From: "hch@lst.de" <hch@lst.de>
Date: Thu, 26 Apr 2018 06:45:00 +0000
Subject: Re: [PATCH 06/22] arc: use generic dma_noncoherent_ops
Message-Id: <20180426064500.GB13895@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-7-hch@lst.de> <1524655020.5315.9.camel@synopsys.com>
In-Reply-To: <1524655020.5315.9.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "hch@lst.de" <hch@lst.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 25, 2018 at 11:17:01AM +0000, Alexey Brodkin wrote:
> Which is actually strange as I would expect ARC code to be built by bots.

I don't think I got any notification.  Thank for the fixes!

I think I found the bug, based on the fact that so far all tests for
architectures that also need a cache op for device to cpu transitions
failed.  I did a stupid typo when changing kconfig symbols, so please
try the patch below.

>  
>  static int l2_line_sz;
>  static int ioc_exists;
> -int slc_enable = 1, ioc_enable = 1;
> +int slc_enable = 1, ioc_enable = 0;

Hmm.  It seems if ioc_enable is 0 we should simply be using
dma_direct_ops on arc, but that is a different discussion.

---
diff --git a/lib/dma-noncoherent.c b/lib/dma-noncoherent.c
index f4b8532c20ac..a2c192b3508d 100644
--- a/lib/dma-noncoherent.c
+++ b/lib/dma-noncoherent.c
@@ -48,7 +48,7 @@ static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT_SYNC_FOR_CPU
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 static void dma_noncoherent_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
@@ -88,7 +88,7 @@ const struct dma_map_ops dma_noncoherent_ops = {
 	.sync_sg_for_device	= dma_noncoherent_sync_sg_for_device,
 	.map_page		= dma_noncoherent_map_page,
 	.map_sg			= dma_noncoherent_map_sg,
-#ifdef CONFIG_DMA_NONCOHERENT_SYNC_FOR_CPU
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 	.sync_single_for_cpu	= dma_noncoherent_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_noncoherent_sync_sg_for_cpu,
 	.unmap_page		= dma_noncoherent_unmap_page,
