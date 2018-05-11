From: Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 07:59:39 +0000
Subject: [PATCH 14/20] sh: introduce a sh_cacheop_vaddr helper
Message-Id: <20180511075945.16548-15-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180511075945.16548-1-hch@lst.de>
In-Reply-To: <20180511075945.16548-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

And use it in the maple bus code to avoid a dma API dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/cacheflush.h | 7 +++++++
 arch/sh/mm/consistent.c          | 5 +----
 drivers/sh/maple/maple.c         | 7 ++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index d103ab5a4e4b..b932e42ef028 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -101,5 +101,12 @@ void kunmap_coherent(void *kvaddr);
 
 void cpu_cache_init(void);
 
+static inline void *sh_cacheop_vaddr(void *vaddr)
+{
+	if (__in_29bit_mode())
+		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
+	return vaddr;
+}
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_CACHEFLUSH_H */
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 221832eec33b..f18483494c46 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -69,10 +69,7 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
 void sh_sync_dma_for_device(void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-	void *addr;
-
-	addr = __in_29bit_mode() ?
-	       (void *)CAC_ADDR((unsigned long)vaddr) : vaddr;
+	void *addr = sh_cacheop_vaddr(vaddr);
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 7525039d812c..c9c354bd713a 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -300,8 +300,8 @@ static void maple_send(void)
 	mutex_unlock(&maple_wlist_lock);
 	if (maple_packets > 0) {
 		for (i = 0; i < (1 << MAPLE_DMA_PAGES); i++)
-			sh_sync_dma_for_device(maple_sendbuf + i * PAGE_SIZE,
-				       PAGE_SIZE, DMA_BIDIRECTIONAL);
+			__flush_purge_region(maple_sendbuf + i * PAGE_SIZE,
+					PAGE_SIZE);
 	}
 
 finish:
@@ -642,7 +642,8 @@ static void maple_dma_handler(struct work_struct *work)
 		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
 			mdev = mq->dev;
 			recvbuf = mq->recvbuf->buf;
-			sh_sync_dma_for_device(recvbuf, 0x400, DMA_FROM_DEVICE);
+			__flush_invalidate_region(sh_cacheop_vaddr(recvbuf),
+					0x400);
 			code = recvbuf[0];
 			kfree(mq->sendbuf);
 			list_del_init(&mq->list);
-- 
2.17.0

