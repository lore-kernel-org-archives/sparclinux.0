From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 14:43:27 +0000
Subject: [PATCH 2/4] sparc32,leon: always include leon_pmc in build
Message-Id: <1338043409-6827-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/Makefile   |    2 +-
 arch/sparc/kernel/leon_pmc.c |   15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 43af0d6..6cf591b 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -52,7 +52,7 @@ obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
 obj-$(CONFIG_SPARC32)   += leon_kernel.o
-obj-$(CONFIG_SPARC_LEON)+= leon_pmc.o
+obj-$(CONFIG_SPARC32)   += leon_pmc.o
 
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 519ca92..4e17432 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -7,6 +7,7 @@
 #include <linux/pm.h>
 
 #include <asm/leon_amba.h>
+#include <asm/cpu_type.h>
 #include <asm/leon.h>
 
 /* List of Systems that need fixup instructions around power-down instruction */
@@ -65,13 +66,15 @@ void pmc_leon_idle(void)
 /* Install LEON Power Down function */
 static int __init leon_pmc_install(void)
 {
-	/* Assign power management IDLE handler */
-	if (pmc_leon_need_fixup())
-		pm_idle = pmc_leon_idle_fixup;
-	else
-		pm_idle = pmc_leon_idle;
+	if (sparc_cpu_model = sparc_leon) {
+		/* Assign power management IDLE handler */
+		if (pmc_leon_need_fixup())
+			pm_idle = pmc_leon_idle_fixup;
+		else
+			pm_idle = pmc_leon_idle;
 
-	printk(KERN_INFO "leon: power management initialized\n");
+		printk(KERN_INFO "leon: power management initialized\n");
+	}
 
 	return 0;
 }
-- 
1.6.0.6

