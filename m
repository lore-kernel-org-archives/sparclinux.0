From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 10 Aug 2009 02:53:11 +0000
Subject: [PATCH 2/8] IA64: remove NULL flush_write_buffers
Message-Id: <1249872797-1314-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

flush_write_buffers() in dma-mapping-common.h was removed so we can
remove NULL flush_write_buffers() in IA64.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/ia64/include/asm/dma-mapping.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 5a61b5c..fe9c822 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -44,7 +44,6 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 
 #define get_dma_ops(dev) platform_dma_get_ops(dev)
-#define flush_write_buffers()
 
 #include <asm-generic/dma-mapping-common.h>
 
-- 
1.6.0.6

