From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 14:02:35 +0000
Subject: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and debug_dma_dump_mappings
Message-Id: <20180424140235.9125-4-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
In-Reply-To: <20180424140235.9125-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

Only used by the AMD GART driver, which must be built in.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 075253cb613b..6a1ebaa83623 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
 		spin_unlock_irqrestore(&bucket->lock, flags);
 	}
 }
-EXPORT_SYMBOL(debug_dma_dump_mappings);
 
 /*
  * For each mapping (initial cacheline in the case of
@@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
 
 	return ret;
 }
-EXPORT_SYMBOL(dma_debug_resize_entries);
 
 /*
  * DMA-API debugging init code
-- 
2.17.0

