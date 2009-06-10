From: konrad@gaisler.com
Date: Wed, 10 Jun 2009 10:15:43 +0000
Subject: [PATCH 4/7] Undefine srmmu_hwprobe in the CONFIG_SPARC_LEON case.
Message-Id: <1244628943-23907-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45E2.4070906@gaisler.com>
In-Reply-To: <4A2E45E2.4070906@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

>>  srmmu_get_pte (unsigned long addr)
> 
> Surely there is a better way to do this, oh and if this is the only
> way, #ifndef CONFIG_LEON is much cleaner.
> 

SPARC-LEON doesnt have a hardware probe, so the function cannot be
used for leon. I implement a softwareprobe instead. Changed to #ifndef CONFIG_LEON


The sparc-leon SRMMU has no mmu probe logic implemented.
Instead function srmmu_swprobe() is used that is defined in
arch/sparc/mm/leon.c. arch/sparc/include/asm/leon.h on the
other hand defines srmmu_hwprobe(addr) as a macro
---
 arch/sparc/include/asm/pgtsrmmu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 808555f..267178c 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(
 
 }
 
+#ifndef CONFIG_SPARC_LEON
 static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
 	unsigned long retval;
@@ -278,6 +279,7 @@ static inline unsigned long srmmu_hwprob
 
 	return retval;
 }
+#endif
 
 static inline int
 srmmu_get_pte (unsigned long addr)
-- 
1.4.2.1

