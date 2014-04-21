From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:32 +0000
Subject: [PATCH 17/29] sparc32: fix sparse warnings in tadpole.c
Message-Id: <1398109184-3283-17-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
tadpole.c:21:6: warning: symbol 'cpu_pwr_save' was not declared. Should it be static?
tadpole.c:101:13: warning: symbol 'clock_stop_probe' was not declared. Should it be static?

This actually revealed that cpu_pwr_save is only assigned.
It was left static with a TODO comment for now - this should be cleaned up later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/devices.c | 2 +-
 arch/sparc/kernel/kernel.h  | 3 +++
 arch/sparc/kernel/tadpole.c | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index b9e9d8c..086faf6 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -21,7 +21,7 @@
 #include <asm/cpu_type.h>
 #include <asm/setup.h>
 
-extern void clock_stop_probe(void); /* tadpole.c */
+#include "kernel.h"
 
 static char *cpu_mid_prop(void)
 {
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7f05d3f..4877626 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -113,6 +113,9 @@ asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
 /* windows.c */
 void try_to_clear_window_buffer(struct pt_regs *regs, int who);
 
+/* tadpole.c */
+void __init clock_stop_probe(void);
+
 #else /* CONFIG_SPARC32 */
 #endif /* CONFIG_SPARC32 */
 #endif /* !(__SPARC_KERNEL_H) */
diff --git a/arch/sparc/kernel/tadpole.c b/arch/sparc/kernel/tadpole.c
index 9aba8bd..4bbfe4e 100644
--- a/arch/sparc/kernel/tadpole.c
+++ b/arch/sparc/kernel/tadpole.c
@@ -12,13 +12,17 @@
 #include <asm/oplib.h>
 #include <asm/io.h>
 
+#include "kernel.h"
+
 #define MACIO_SCSI_CSR_ADDR	0x78400000
 #define MACIO_EN_DMA		0x00000200
 #define CLOCK_INIT_DONE		1
 
 static int clk_state;
 static volatile unsigned char *clk_ctrl;
-void (*cpu_pwr_save)(void);
+
+/* TODO - cpu_pwr_save is only assigned - cleanup potential. */
+static void (*cpu_pwr_save)(void);
 
 static inline unsigned int ldphys(unsigned int addr)
 {
-- 
1.8.3.1

