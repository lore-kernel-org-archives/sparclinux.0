From: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Dec 2018 14:14:07 +0000
Subject: [PATCH 4/4] sparc: remove not required includes from dma-mapping.h
Message-Id: <20181207141407.3154-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The only thing we need to explicitly pull in is the defines for the
CPU type.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/dma-mapping.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index b0bb2fcaf1c9..55a44f08a9a4 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -2,9 +2,7 @@
 #ifndef ___ASM_SPARC_DMA_MAPPING_H
 #define ___ASM_SPARC_DMA_MAPPING_H
 
-#include <linux/scatterlist.h>
-#include <linux/mm.h>
-#include <linux/dma-debug.h>
+#include <asm/cpu_type.h>
 
 extern const struct dma_map_ops *dma_ops;
 
-- 
2.19.1
