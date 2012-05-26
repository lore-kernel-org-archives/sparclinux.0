From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 14:43:29 +0000
Subject: [PATCH 4/4] sparc32: support leon + sun in dma_make_coherent()
Message-Id: <1338043409-6827-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

No need for two implementations - we check the cpu model.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 8bc4db0..f00945b 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -55,17 +55,13 @@ const struct sparc32_dma_ops *sparc32_dma_ops;
 /* This function must make sure that caches and memory are coherent after DMA
  * On LEON systems without cache snooping it flushes the entire D-CACHE.
  */
-#ifndef CONFIG_SPARC_LEON
 static inline void dma_make_coherent(unsigned long pa, unsigned long len)
 {
+	if (sparc_cpu_model = sparc_leon) {
+		if (!sparc_leon3_snooping_enabled())
+			leon_flush_dcache_all();
+	}
 }
-#else
-static inline void dma_make_coherent(unsigned long pa, unsigned long len)
-{
-	if (!sparc_leon3_snooping_enabled())
-		leon_flush_dcache_all();
-}
-#endif
 
 static void __iomem *_sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz);
 static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
-- 
1.6.0.6

