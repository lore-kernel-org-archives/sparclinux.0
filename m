From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:48 +0000
Subject: [PATCH 5/8] sparc32,leon: remove duplicate definitions in leon.h
Message-Id: <1337493771-18535-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 7a66bd9..24f802b 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -240,18 +240,11 @@ static inline int sparc_leon3_cpuid(void)
 #define LEON2_CFG_SSIZE_MASK 0x00007000UL
 
 #ifndef __ASSEMBLY__
-extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
-extern void leon_flush_icache_all(void);
-extern void leon_flush_dcache_all(void);
-extern void leon_flush_cache_all(void);
-extern void leon_flush_tlb_all(void);
-extern int leon_flush_during_switch;
-extern int leon_flush_needed(void);
-
 struct vm_area_struct;
+
+extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
 extern void leon_flush_icache_all(void);
 extern void leon_flush_dcache_all(void);
-extern void leon_flush_pcache_all(struct vm_area_struct *vma, unsigned long page);
 extern void leon_flush_cache_all(void);
 extern void leon_flush_tlb_all(void);
 extern int leon_flush_during_switch;
@@ -286,15 +279,9 @@ extern void leon_update_virq_handling(unsigned int virq,
 extern void leon_init_timers(void);
 extern void leon_trans_init(struct device_node *dp);
 extern void leon_node_init(struct device_node *dp, struct device_node ***nextp);
-extern void leon_init_IRQ(void);
-extern void leon_init(void);
-extern unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr);
 extern void init_leon(void);
 extern void poke_leonsparc(void);
 extern void leon3_getCacheRegs(struct leon3_cacheregs *regs);
-extern int leon_flush_needed(void);
-extern void leon_switch_mm(void);
-extern int srmmu_swprobe_trace;
 extern int leon3_ticker_irq;
 
 #ifdef CONFIG_SMP
-- 
1.6.0.6

