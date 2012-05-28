From: David Miller <davem@davemloft.net>
Date: Mon, 28 May 2012 07:12:08 +0000
Subject: [PATCH] sparc32: Export leon_dma_ops to modules.
Message-Id: <20120528.031208.779922094210485625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ioport.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index f00945b..0f094db 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -652,8 +652,9 @@ EXPORT_SYMBOL(pci32_dma_ops);
 
 /* leon re-uses pci32_dma_ops */
 struct dma_map_ops *leon_dma_ops = &pci32_dma_ops;
-struct dma_map_ops *dma_ops = &sbus_dma_ops;
+EXPORT_SYMBOL(leon_dma_ops);
 
+struct dma_map_ops *dma_ops = &sbus_dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
 
-- 
1.7.10

