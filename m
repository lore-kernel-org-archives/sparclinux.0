From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Apr 2018 14:02:34 +0000
Subject: [PATCH 2/3] dma-debug: simplify counting of preallocated requests
Message-Id: <20180424140235.9125-3-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180424140235.9125-1-hch@lst.de>
In-Reply-To: <20180424140235.9125-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

Just keep a single variable with a descriptive name instead of two
with confusing names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-debug.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/lib/dma-debug.c b/lib/dma-debug.c
index 712a897174e4..075253cb613b 100644
--- a/lib/dma-debug.c
+++ b/lib/dma-debug.c
@@ -132,7 +132,7 @@ static u32 min_free_entries;
 static u32 nr_total_entries;
 
 /* number of preallocated entries requested by kernel cmdline */
-static u32 req_entries;
+static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
 
 /* debugfs dentry's for the stuff above */
 static struct dentry *dma_debug_dent        __read_mostly;
@@ -1011,7 +1011,6 @@ void dma_debug_add_bus(struct bus_type *bus)
 
 static int dma_debug_init(void)
 {
-	u32 num_entries;
 	int i;
 
 	/* Do not use dma_debug_initialized here, since we really want to be
@@ -1032,12 +1031,7 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (req_entries)
-		num_entries = req_entries;
-	else
-		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
-
-	if (prealloc_memory(num_entries) != 0) {
+	if (prealloc_memory(nr_prealloc_entries) != 0) {
 		pr_err("DMA-API: debugging out of memory error - disabled\n");
 		global_disable = true;
 
@@ -1068,16 +1062,10 @@ static __init int dma_debug_cmdline(char *str)
 
 static __init int dma_debug_entries_cmdline(char *str)
 {
-	int res;
-
 	if (!str)
 		return -EINVAL;
-
-	res = get_option(&str, &req_entries);
-
-	if (!res)
-		req_entries = 0;
-
+	if (!get_option(&str, &nr_prealloc_entries))
+		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
 	return 0;
 }
 
-- 
2.17.0

