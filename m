From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 08 Sep 2011 13:11:15 +0000
Subject: [PATCH] sparc32,leon: SRMMU MMU Table probe fix
Message-Id: <1315487475-16690-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The LEON MMU Model (SRMMU) does not implement MMu Table probing
in hardware, instead it is implemented in software. However the
software implementation does not return the PTE as it should which
always results in INVALID entires and the PROM mappings are not
inherited as they should during startup. The following patch
removes the masking of the PTE.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/pgtsrmmu.h |    2 +-
 arch/sparc/mm/leon_mm.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 1407c07..f6ae2b2 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -280,7 +280,7 @@ static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 	return retval;
 }
 #else
-#define srmmu_hwprobe(addr) (srmmu_swprobe(addr, 0) & SRMMU_PTE_PMASK)
+#define srmmu_hwprobe(addr) srmmu_swprobe(addr, 0)
 #endif
 
 static inline int
diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
index e485a68..13c2169 100644
--- a/arch/sparc/mm/leon_mm.c
+++ b/arch/sparc/mm/leon_mm.c
@@ -162,7 +162,7 @@ ready:
 		printk(KERN_INFO "swprobe: padde %x\n", paddr_calc);
 	if (paddr)
 		*paddr = paddr_calc;
-	return paddrbase;
+	return pte;
 }
 
 void leon_flush_icache_all(void)
-- 
1.5.4

