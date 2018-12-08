From: Christoph Hellwig <hch@lst.de>
Date: Sat, 08 Dec 2018 17:41:13 +0000
Subject: [PATCH 4/6] sparc: remove not required includes from dma-mapping.h
Message-Id: <20181208174115.16237-5-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181208174115.16237-1-hch@lst.de>
In-Reply-To: <20181208174115.16237-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org, "Matwey V. Kornilov" <matwey@sai.msu.ru>, openrisc@lists.librecores.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

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
2.19.2
