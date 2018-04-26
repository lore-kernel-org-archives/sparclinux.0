From: Christoph Hellwig <hch@lst.de>
Date: Thu, 26 Apr 2018 06:42:39 +0000
Subject: Re: [PATCH 13/22] nds32: use generic dma_noncoherent_ops
Message-Id: <20180426064239.GA13895@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180420080313.18796-1-hch@lst.de> <20180420080313.18796-14-hch@lst.de> <CAEbi=3fkakVD2vxGu6SgJM77JnNM8Y79xS8_o6m9d_85BJpMFQ@mail.gmail.com> <20180424191640.GA32495@lst.de> <CAEbi=3f7yzE+KAM2GOh6QahC_E6BAUfB3ys3U-WdBSUf3DPZqg@mail.gmail.com> <20180425064055.GA11460@lst.de> <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com>
In-Reply-To: <CAEbi=3fcd8E=xi_hbef45LnPsBZhZv37yPO-xfZmU1gMaWnDvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greentime Hu <green.hu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Can you try this patch ontop of either the new or original one?

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
