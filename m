From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:13 +0000
Subject: [PATCH 09/15] sparc32,leon: always include leon_kernel in build
Message-Id: <1338016819-22245-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h      |    2 --
 arch/sparc/include/asm/leon_amba.h |    4 ----
 arch/sparc/kernel/Makefile         |    2 +-
 3 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 00530a5..95fa931 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -257,9 +257,7 @@ extern int leon_ipi_irq;
 #ifndef CONFIG_SPARC_LEON
 
 /* nop definitions for !LEON case */
-#define leon_init() do {} while (0)
 #define leon_switch_mm() do {} while (0)
-#define leon_init_IRQ() do {} while (0)
 #define init_leon() do {} while (0)
 #define leon_smp_done() do {} while (0)
 #define leon_boot_cpus() do {} while (0)
diff --git a/arch/sparc/include/asm/leon_amba.h b/arch/sparc/include/asm/leon_amba.h
index e50f326..f3034ed 100644
--- a/arch/sparc/include/asm/leon_amba.h
+++ b/arch/sparc/include/asm/leon_amba.h
@@ -87,8 +87,6 @@ struct amba_prom_registers {
 #define LEON3_GPTIMER_CONFIG_NRTIMERS(c) ((c)->config & 0x7)
 #define LEON3_GPTIMER_CTRL_ISPENDING(r)  (((r)&LEON3_GPTIMER_CTRL_PENDING) ? 1 : 0)
 
-#ifdef CONFIG_SPARC_LEON
-
 #ifndef __ASSEMBLY__
 
 struct leon3_irqctrl_regs_map {
@@ -264,6 +262,4 @@ extern unsigned int sparc_leon_eirq;
 
 #define amba_device(x) (((x) >> 12) & 0xfff)
 
-#endif /* !defined(CONFIG_SPARC_LEON) */
-
 #endif
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 72308f9..43af0d6 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -51,7 +51,7 @@ obj-y                   += of_device_common.o
 obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
-obj-$(CONFIG_SPARC_LEON)+= leon_kernel.o
+obj-$(CONFIG_SPARC32)   += leon_kernel.o
 obj-$(CONFIG_SPARC_LEON)+= leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
-- 
1.6.0.6

