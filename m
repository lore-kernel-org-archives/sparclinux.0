From: Shuah Khan <shuah@fc.hp.com>
Date: Fri, 26 Oct 2012 00:38:29 +0000
Subject: [PATCH RFT RESEND] sparc: dma-mapping: support debug_dma_mapping_error
Message-Id: <1351211909.6851.26.camel@lorien2>
List-Id: <sparclinux.vger.kernel.org>
References: <1351211773.6851.24.camel@lorien2>
In-Reply-To: <1351211773.6851.24.camel@lorien2>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, kyungmin.park@samsung.com, sam@ravnborg.org, arnd@arndb.de, m.szyprowski@samsung.com
Cc: sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

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



