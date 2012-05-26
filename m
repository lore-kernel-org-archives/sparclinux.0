From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:08 +0000
Subject: [PATCH 04/15] sparc32: introduce sparc32_start_kernel called from head_32.S
Message-Id: <1338016819-22245-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This gives us a C hook before we call start_kernel()

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S  |   10 ++--------
 arch/sparc/kernel/kernel.h   |    3 +++
 arch/sparc/kernel/setup_32.c |   10 ++++++++++
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index f22a729..6c6b8c2 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -661,16 +661,10 @@ continue_boot:
 		wr	%g3, PSR_ET, %psr
 		WRITE_PAUSE
 
-		/* First we call prom_init() to set up PROMLIB, then
-		 * off to start_kernel().
-		 */
-
+		/* Call sparc32_start_kernel(struct linux_romvec *rp) */
 		sethi	%hi(prom_vector_p), %g5
 		ld	[%g5 + %lo(prom_vector_p)], %o0
-		call	prom_init
-		 nop
-
-		call	start_kernel
+		call	sparc32_start_kernel
 		 nop
 
 		/* We should not get here. */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index a86372d..291bb5d 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -26,6 +26,9 @@ static inline unsigned long kimage_addr_to_ra(const char *p)
 #endif
 
 #ifdef CONFIG_SPARC32
+/* setup_32.c */
+void sparc32_start_kernel(struct linux_romvec *rp);
+
 /* cpu.c */
 extern void cpu_probe(void);
 
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c052313..68dd63d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -32,6 +32,7 @@
 #include <linux/cpu.h>
 #include <linux/kdebug.h>
 #include <linux/export.h>
+#include <linux/start_kernel.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -244,6 +245,15 @@ struct tt_entry *sparc_ttable;
 
 struct pt_regs fake_swapper_regs;
 
+/* Called from head_32.S - before we have setup anything
+ * in the kernel. Be very careful with what you do here.
+ */
+void __init sparc32_start_kernel(struct linux_romvec *rp)
+{
+	prom_init(rp);
+	start_kernel();
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	int i;
-- 
1.6.0.6

