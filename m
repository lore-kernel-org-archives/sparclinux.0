From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:09 +0000
Subject: [PATCH 05/15] sparc32: add support for run-time patching of leon/sun single instructions
Message-Id: <1338016819-22245-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This will be used to handle that MMUREGS has different ASI for SUN and LEON.
This is the infrastructure only - users will come later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/asmmacro.h |   22 ++++++++++++++
 arch/sparc/include/asm/sections.h |    3 ++
 arch/sparc/kernel/setup_32.c      |   58 ++++++++++++++++++++++++++----------
 arch/sparc/kernel/vmlinux.lds.S   |    5 +++
 4 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/include/asm/asmmacro.h b/arch/sparc/include/asm/asmmacro.h
index 02a172f..a0e28ef 100644
--- a/arch/sparc/include/asm/asmmacro.h
+++ b/arch/sparc/include/asm/asmmacro.h
@@ -20,4 +20,26 @@
 /* All traps low-level code here must end with this macro. */
 #define RESTORE_ALL b ret_trap_entry; clr %l6;
 
+/* Support for run-time patching of single instructions.
+ * This is used to handle the differences in the ASI for
+ * MMUREGS for LEON and SUN.
+ *
+ * Sample:
+ * LEON_PI(lda [%g0] ASI_LEON_MMUREGS, %o0
+ * SUN_PI_(lda [%g0] ASI_M_MMUREGS, %o0
+ * PI = Patch Instruction
+ *
+ * For LEON we will use the first variant,
+ * and for all other we will use the SUN variant.
+ * The order is important.
+ */
+#define LEON_PI(...)				\
+662:	__VA_ARGS__
+
+#define SUN_PI_(...)				\
+	.section .leon_1insn_patch, "ax";	\
+	.word 662b;				\
+	__VA_ARGS__;				\
+	.previous
+
 #endif /* !(_SPARC_ASMMACRO_H) */
diff --git a/arch/sparc/include/asm/sections.h b/arch/sparc/include/asm/sections.h
index 0b0553b..f300d1a 100644
--- a/arch/sparc/include/asm/sections.h
+++ b/arch/sparc/include/asm/sections.h
@@ -7,4 +7,7 @@
 /* sparc entry point */
 extern char _start[];
 
+extern char __leon_1insn_patch[];
+extern char __leon_1insn_patch_end[];
+
 #endif
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 68dd63d..efe3e64 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -46,6 +46,7 @@
 #include <asm/cpudata.h>
 #include <asm/setup.h>
 #include <asm/cacheflush.h>
+#include <asm/sections.h>
 
 #include "kernel.h"
 
@@ -238,11 +239,34 @@ static void __init per_cpu_patch(void)
 	}
 }
 
+struct leon_1insn_patch_entry {
+	unsigned int addr;
+	unsigned int insn;
+};
+
 enum sparc_cpu sparc_cpu_model;
 EXPORT_SYMBOL(sparc_cpu_model);
 
-struct tt_entry *sparc_ttable;
+static __init void leon_patch(void)
+{
+	struct leon_1insn_patch_entry *start = (void *)__leon_1insn_patch;
+	struct leon_1insn_patch_entry *end = (void *)__leon_1insn_patch_end;
+
+	/* Default instruction is leon - no patching */
+	if (sparc_cpu_model = sparc_leon)
+		return;
+
+	while (start < end) {
+		unsigned long addr = start->addr;
+
+		*(unsigned int *)(addr) = start->insn;
+		flushi(addr);
+
+		start++;
+	}
+}
 
+struct tt_entry *sparc_ttable;
 struct pt_regs fake_swapper_regs;
 
 /* Called from head_32.S - before we have setup anything
@@ -251,6 +275,23 @@ struct pt_regs fake_swapper_regs;
 void __init sparc32_start_kernel(struct linux_romvec *rp)
 {
 	prom_init(rp);
+
+	/* Set sparc_cpu_model */
+	sparc_cpu_model = sun_unknown;
+	if (!strcmp(&cputypval[0], "sun4m"))
+		sparc_cpu_model = sun4m;
+	if (!strcmp(&cputypval[0], "sun4s"))
+		sparc_cpu_model = sun4m; /* CP-1200 with PROM 2.30 -E */
+	if (!strcmp(&cputypval[0], "sun4d"))
+		sparc_cpu_model = sun4d;
+	if (!strcmp(&cputypval[0], "sun4e"))
+		sparc_cpu_model = sun4e;
+	if (!strcmp(&cputypval[0], "sun4u"))
+		sparc_cpu_model = sun4u;
+	if (!strncmp(&cputypval[0], "leon" , 4))
+		sparc_cpu_model = sparc_leon;
+
+	leon_patch();
 	start_kernel();
 }
 
@@ -270,21 +311,6 @@ void __init setup_arch(char **cmdline_p)
 
 	register_console(&prom_early_console);
 
-	/* Set sparc_cpu_model */
-	sparc_cpu_model = sun_unknown;
-	if (!strcmp(&cputypval[0], "sun4m"))
-		sparc_cpu_model = sun4m;
-	if (!strcmp(&cputypval[0], "sun4s"))
-		sparc_cpu_model = sun4m; /* CP-1200 with PROM 2.30 -E */
-	if (!strcmp(&cputypval[0], "sun4d"))
-		sparc_cpu_model = sun4d;
-	if (!strcmp(&cputypval[0], "sun4e"))
-		sparc_cpu_model = sun4e;
-	if (!strcmp(&cputypval[0], "sun4u"))
-		sparc_cpu_model = sun4u;
-	if (!strncmp(&cputypval[0], "leon" , 4))
-		sparc_cpu_model = sparc_leon;
-
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4m:
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 0e16056..89c2c29 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -107,6 +107,11 @@ SECTIONS
 		*(.sun4v_2insn_patch)
 		__sun4v_2insn_patch_end = .;
 	}
+	.leon_1insn_patch : {
+		__leon_1insn_patch = .;
+		*(.leon_1insn_patch)
+		__leon_1insn_patch_end = .;
+	}
 	.swapper_tsb_phys_patch : {
 		__swapper_tsb_phys_patch = .;
 		*(.swapper_tsb_phys_patch)
-- 
1.6.0.6

