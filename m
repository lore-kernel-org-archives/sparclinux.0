From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 11 Jan 2011 10:49:04 +0000
Subject: [PATCH 2/4] sparc/leon: Make mmu_inval_dma_area flush dcache for LEONs without snooping enabled.
Message-Id: <1294742946-1040-3-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/ioport.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index cea49c0..bfcbd1e 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -50,10 +50,15 @@
 #include <asm/io-unit.h>
 #include <asm/leon.h>
 
-#ifdef CONFIG_SPARC_LEON
-#define mmu_inval_dma_area(p, l) leon_flush_dcache_all()
-#else
+#ifndef CONFIG_SPARC_LEON
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
+#else
+static inline void mmu_inval_dma_area(unsigned long va, unsigned long len)
+{
+	if (!sparc_leon3_snooping_enabled()) {
+		leon_flush_dcache_all();
+	}
+}
 #endif
 
 static struct resource *_sparc_find_resource(struct resource *r,
-- 
1.6.4.1

