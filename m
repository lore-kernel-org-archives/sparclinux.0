From: Christoph Hellwig <hch@lst.de>
Date: Mon, 09 Nov 2015 18:17:06 +0000
Subject: [PATCH 01/16] dma-mapping: make the generic coherent dma mmap implementation optional
Message-Id: <1447093041-21832-2-git-send-email-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
In-Reply-To: <1447093041-21832-1-git-send-email-hch-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Koichi Yasutake <yasutake.koichi-NAum8xwdG0+S7A1Ibl2khg@public.gmane.org>, Chris Metcalf <cmetcalf-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org>, linux-snps-arc-IAPFreCvJWPLiZjB17Co1B2eb7JE58TQ@public.gmane.org, linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org, linux-cris-kernel-VrBV9hrLPhE@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

We have a couple architectures that do not want to support this code,
so add another Kconfig symbol that disables the code similar to what we
do for the nommu case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/Kconfig               | 3 +++
 drivers/base/dma-mapping.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4e949e5..e47995f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -564,4 +564,7 @@ config OLD_SIGACTION
 config COMPAT_OLD_SIGACTION
 	bool
 
+config ARCH_NO_COHERENT_DMA_MMAP
+	bool
+
 source "kernel/gcov/Kconfig"
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index d95c597..381e39d 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -247,7 +247,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int ret = -ENXIO;
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) && !defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP)
 	unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
@@ -264,7 +264,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 				      user_count << PAGE_SHIFT,
 				      vma->vm_page_prot);
 	}
-#endif	/* CONFIG_MMU */
+#endif	/* CONFIG_MMU && !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 
 	return ret;
 }
-- 
1.9.1

