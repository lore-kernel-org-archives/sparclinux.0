From: Christoph Hellwig <hch@lst.de>
Date: Tue, 22 May 2018 12:04:12 +0000
Subject: [PATCH 07/25] nds32: remove the broken kmap code in nds32_dma_map_sg
Message-Id: <20180522120430.28709-8-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180522120430.28709-1-hch@lst.de>
In-Reply-To: <20180522120430.28709-1-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

nds32_dma_map_sg is the only of the various DMA operations that tries
to deal with highmem (the single page variants and SG sync routines are
missing, SG unmap is entirely unimplemented), and it does so without
taking into account S/G list items that are bigger than a page, which
are legal and can happen frequently.

Remove this code for now - if highmem support on nds32 becomes a real
thing it needs to be added back as a loop over pages in the newly
consolidated code that deals with all operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/dma.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/nds32/kernel/dma.c b/arch/nds32/kernel/dma.c
index d291800fc621..e1bf7206e015 100644
--- a/arch/nds32/kernel/dma.c
+++ b/arch/nds32/kernel/dma.c
@@ -393,24 +393,9 @@ static int nds32_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		void *virt;
-		unsigned long pfn;
-		struct page *page = sg_page(sg);
-
-		sg->dma_address = sg_phys(sg);
-		pfn = page_to_pfn(page) + sg->offset / PAGE_SIZE;
-		page = pfn_to_page(pfn);
-		if (PageHighMem(page)) {
-			virt = kmap_atomic(page);
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-			kunmap_atomic(virt);
-		} else {
-			if (sg->offset > PAGE_SIZE)
-				panic("sg->offset:%08x > PAGE_SIZE\n",
-				      sg->offset);
-			virt = page_address(page) + sg->offset;
-			consistent_sync(virt, sg->length, dir, FOR_CPU);
-		}
+		char *virt +		    page_address((struct page *)sg->page_link) + sg->offset;
+		consistent_sync(virt, sg->length, dir, FOR_CPU);
 	}
 	return nents;
 }
-- 
2.17.0

