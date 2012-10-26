From: Shuah Khan <shuah.khan@hp.com>
Date: Fri, 26 Oct 2012 00:36:13 +0000
Subject: [PATCH RFT] sparc: dma-mapping: support debug_dma_mapping_error
Message-Id: <1351211773.6851.24.camel@lorien2>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, kyungmin.park@samsung.com, m.szyprowski@samsung.com, sam@ravnborg.org, arnd@arndb.de
Cc: sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

From 9e8feb61482288c5a5dd609e0dd17c1a262a48a3 Mon Sep 17 00:00:00 2001
From: Shuah Khan <shuahkhan@gmail.com>
Date: Thu, 25 Oct 2012 18:31:42 -0600
Subject: [PATCH RFT] sparc: dma-mapping: support debug_dma_mapping_error

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/sparc/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index 8493fd3..05fe53f 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -59,6 +59,7 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
+	debug_dma_mapping_error(dev, dma_addr);
 	return (dma_addr = DMA_ERROR_CODE);
 }
 
-- 
1.7.9.5



