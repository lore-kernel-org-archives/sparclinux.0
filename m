From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:16 +0000
Subject: [PATCH 22/49]: alsa: Remove special SBUS dma support code.
Message-Id: <20080827.212416.108470742.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


alsa: Remove special SBUS dma support code.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 .../sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    3 +-
 include/sound/core.h                               |    3 -
 include/sound/memalloc.h                           |    2 -
 sound/core/memalloc.c                              |   50 +-------------------
 4 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
index e13c4e6..56723b4 100644
--- a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
@@ -5073,8 +5073,7 @@ struct _snd_pcm_runtime {
       with <constant>SNDRV_DMA_TYPE_CONTINUOUS</constant> type and the
       <function>snd_dma_continuous_data(GFP_KERNEL)</function> device pointer,
       where <constant>GFP_KERNEL</constant> is the kernel allocation flag to
-      use.  For the SBUS, <constant>SNDRV_DMA_TYPE_SBUS</constant> and
-      <function>snd_dma_sbus_data(sbus_dev)</function> are used instead.
+      use.
       For the PCI scatter-gather buffers, use
       <constant>SNDRV_DMA_TYPE_DEV_SG</constant> with
       <function>snd_dma_pci_data(pci)</function>
diff --git a/include/sound/core.h b/include/sound/core.h
index 558b962..821d5a5 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -42,9 +42,6 @@
 #ifdef CONFIG_PCI
 struct pci_dev;
 #endif
-#ifdef CONFIG_SBUS
-struct sbus_dev;
-#endif
 
 /* device allocation stuff */
 
diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index ae2921d..6a3e755 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -37,7 +37,6 @@ struct snd_dma_device {
 #ifndef snd_dma_pci_data
 #define snd_dma_pci_data(pci)	(&(pci)->dev)
 #define snd_dma_isa_data()	NULL
-#define snd_dma_sbus_data(sbus)	((struct device *)(sbus))
 #define snd_dma_continuous_data(x)	((struct device *)(unsigned long)(x))
 #endif
 
@@ -49,7 +48,6 @@ struct snd_dma_device {
 #define SNDRV_DMA_TYPE_CONTINUOUS	1	/* continuous no-DMA memory */
 #define SNDRV_DMA_TYPE_DEV		2	/* generic device continuous */
 #define SNDRV_DMA_TYPE_DEV_SG		3	/* generic device SG-buffer */
-#define SNDRV_DMA_TYPE_SBUS		4	/* SBUS continuous */
 
 /*
  * info for buffer allocation
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index ccaaac4..3733351 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -33,9 +33,6 @@
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <sound/memalloc.h>
-#ifdef CONFIG_SBUS
-#include <asm/sbus.h>
-#endif
 
 
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>");
@@ -180,41 +177,6 @@ static void snd_free_dev_pages(struct device *dev, size_t size, void *ptr,
 }
 #endif /* CONFIG_HAS_DMA */
 
-#ifdef CONFIG_SBUS
-
-static void *snd_malloc_sbus_pages(struct device *dev, size_t size,
-				   dma_addr_t *dma_addr)
-{
-	struct sbus_dev *sdev = (struct sbus_dev *)dev;
-	int pg;
-	void *res;
-
-	snd_assert(size > 0, return NULL);
-	snd_assert(dma_addr != NULL, return NULL);
-	pg = get_order(size);
-	res = dma_alloc_coherent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
-				 dma_addr, GFP_ATOMIC);
-	if (res != NULL)
-		inc_snd_pages(pg);
-	return res;
-}
-
-static void snd_free_sbus_pages(struct device *dev, size_t size,
-				void *ptr, dma_addr_t dma_addr)
-{
-	struct sbus_dev *sdev = (struct sbus_dev *)dev;
-	int pg;
-
-	if (ptr = NULL)
-		return;
-	pg = get_order(size);
-	dec_snd_pages(pg);
-	dma_free_coherent(&sdev->ofdev.dev, PAGE_SIZE * (1 << pg),
-			  ptr, dma_addr);
-}
-
-#endif /* CONFIG_SBUS */
-
 /*
  *
  *  ALSA generic memory management
@@ -249,11 +211,6 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 		dmab->area = snd_malloc_pages(size, (unsigned long)device);
 		dmab->addr = 0;
 		break;
-#ifdef CONFIG_SBUS
-	case SNDRV_DMA_TYPE_SBUS:
-		dmab->area = snd_malloc_sbus_pages(device, size, &dmab->addr);
-		break;
-#endif
 #ifdef CONFIG_HAS_DMA
 	case SNDRV_DMA_TYPE_DEV:
 		dmab->area = snd_malloc_dev_pages(device, size, &dmab->addr);
@@ -322,11 +279,6 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 	case SNDRV_DMA_TYPE_CONTINUOUS:
 		snd_free_pages(dmab->area, dmab->bytes);
 		break;
-#ifdef CONFIG_SBUS
-	case SNDRV_DMA_TYPE_SBUS:
-		snd_free_sbus_pages(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
-		break;
-#endif
 #ifdef CONFIG_HAS_DMA
 	case SNDRV_DMA_TYPE_DEV:
 		snd_free_dev_pages(dmab->dev.dev, dmab->bytes, dmab->area, dmab->addr);
@@ -433,7 +385,7 @@ static int snd_mem_proc_read(struct seq_file *seq, void *offset)
 	long pages = snd_allocated_pages >> (PAGE_SHIFT-12);
 	struct snd_mem_list *mem;
 	int devno;
-	static char *types[] = { "UNKNOWN", "CONT", "DEV", "DEV-SG", "SBUS" };
+	static char *types[] = { "UNKNOWN", "CONT", "DEV", "DEV-SG" };
 
 	mutex_lock(&list_mutex);
 	seq_printf(seq, "pages  : %li bytes (%li pages per %likB)\n",
-- 
1.5.6.5.GIT

