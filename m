From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:15 +0000
Subject: [PATCH 11/15] sparc32,leon: fix section mismatch warning
Message-Id: <1338016819-22245-11-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:

WARNING: arch/sparc/kernel/built-in.o(.cpuinit.text+0x9f4): Section mismatch in reference from the function leon_callin() to the function .init.text:leon_configure_cache_smp()
The function __cpuinit leon_callin() references
a function __init leon_configure_cache_smp().
If leon_configure_cache_smp is only used by leon_callin then
annotate leon_configure_cache_smp with a matching annotation.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/leon_smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 218c2f0..0f3fb6d 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -54,7 +54,7 @@ extern ctxd_t *srmmu_ctx_table_phys;
 static int smp_processors_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern cpumask_t smp_commenced_mask;
-void __init leon_configure_cache_smp(void);
+void __cpuinit leon_configure_cache_smp(void);
 static void leon_ipi_init(void);
 
 /* IRQ number of LEON IPIs */
@@ -121,7 +121,7 @@ void __cpuinit leon_callin(void)
 
 extern struct linux_prom_registers smp_penguin_ctable;
 
-void __init leon_configure_cache_smp(void)
+void __cpuinit leon_configure_cache_smp(void)
 {
 	unsigned long cfg = sparc_leon3_get_dcachecfg();
 	int me = smp_processor_id();
-- 
1.6.0.6

