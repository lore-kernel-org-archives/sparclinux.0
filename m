From: konrad@gaisler.com
Date: Fri, 12 Jun 2009 08:44:15 +0000
Subject: round2 [PATCH 4/6] Undefine srmmu_hwprobe in the CONFIG_SPARC_LEON case. The sparc-leon SRMMU has no
Message-Id: <1244796255-7332-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

---
 arch/sparc/include/asm/pgtsrmmu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 808555f..267178c 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(unsigned long page)
 
 }
 
+#ifndef CONFIG_SPARC_LEON
 static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
 	unsigned long retval;
@@ -278,6 +279,7 @@ static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 
 	return retval;
 }
+#endif
 
 static inline int
 srmmu_get_pte (unsigned long addr)
-- 
1.6.3.2

