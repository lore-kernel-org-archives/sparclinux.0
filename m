From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 21:18:39 +0000
Subject: Re: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120520211839.GA4563@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120519200321.GA7617@merkur.ravnborg.org>
In-Reply-To: <20120519200321.GA7617@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Looks great.  If you want to get fancy you can write a macro for the
> whole section dance and LEON insn entry stuff.

Thanks for the quick feedback!

As we need this in several places being fancy would be good.
So I updated the patch.

I like how the two implementations are now much simpler to compare:

SUN_INS(lda    [%g0] ASI_M_MMUREGS, %o0)
LEON_IN(lda    [%g0] ASI_LEON_MMUREGS, %o0)

If I fool around with %g0 versus %o0 it will scream at me.
And getting rid of the line-nose is good too!

I deliberatly used 8 letter names to avoid breaking the
indentation in the code.

Updated RFC patch below.

	Sam

From d7773fd2e4f81e63dcccc1db3753a1433ce1e19d Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 22:31:44 +0200
Subject: [PATCH] sparc32: introduce run-time patching of srmmu access functions

LEON uses a different ASI than SUN for MMUREGS
To handle this introduce a dedicated run-time patching
for the functions which uses MMUREGS ASI.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/asmmacro.h |    9 ++++
 arch/sparc/include/asm/pgtsrmmu.h |   68 +++---------------------------
 arch/sparc/include/asm/sections.h |    3 +
 arch/sparc/kernel/setup_32.c      |   25 +++++++++++
 arch/sparc/kernel/vmlinux.lds.S   |    5 ++
 arch/sparc/mm/Makefile            |    1 +
 arch/sparc/mm/srmmu_access.S      |   82 +++++++++++++++++++++++++++++++++++++
 7 files changed, 132 insertions(+), 61 deletions(-)
 create mode 100644 arch/sparc/mm/srmmu_access.S

diff --git a/arch/sparc/include/asm/asmmacro.h b/arch/sparc/include/asm/asmmacro.h
index 02a172f..010eaed 100644
--- a/arch/sparc/include/asm/asmmacro.h
+++ b/arch/sparc/include/asm/asmmacro.h
@@ -20,4 +20,13 @@
 /* All traps low-level code here must end with this macro. */
 #define RESTORE_ALL b ret_trap_entry; clr %l6;
 
+#define SUN_INS(...)				\
+662:	__VA_ARGS__
+
+#define LEON_IN(...)				\
+	.section leon_1insn_patch, "ax";	\
+	.word 662b;				\
+	__VA_ARGS__;				\
+	.previous
+
 #endif /* !(_SPARC_ASMMACRO_H) */
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index cb82870..5d3413a 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -148,67 +148,13 @@ extern void *srmmu_nocache_pool;
 #define __nocache_fix(VADDR) __va(__nocache_pa(VADDR))
 
 /* Accessing the MMU control register. */
-static inline unsigned int srmmu_get_mmureg(void)
-{
-        unsigned int retval;
-	__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
-			     "=r" (retval) :
-			     "i" (ASI_M_MMUREGS));
-	return retval;
-}
-
-static inline void srmmu_set_mmureg(unsigned long regval)
-{
-	__asm__ __volatile__("sta %0, [%%g0] %1\n\t" : :
-			     "r" (regval), "i" (ASI_M_MMUREGS) : "memory");
-
-}
-
-static inline void srmmu_set_ctable_ptr(unsigned long paddr)
-{
-	paddr = ((paddr >> 4) & SRMMU_CTX_PMASK);
-	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
-			     "r" (paddr), "r" (SRMMU_CTXTBL_PTR),
-			     "i" (ASI_M_MMUREGS) :
-			     "memory");
-}
-
-static inline void srmmu_set_context(int context)
-{
-	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
-			     "r" (context), "r" (SRMMU_CTX_REG),
-			     "i" (ASI_M_MMUREGS) : "memory");
-}
-
-static inline int srmmu_get_context(void)
-{
-	register int retval;
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_CTX_REG),
-			     "i" (ASI_M_MMUREGS));
-	return retval;
-}
-
-static inline unsigned int srmmu_get_fstatus(void)
-{
-	unsigned int retval;
-
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_FAULT_STATUS), "i" (ASI_M_MMUREGS));
-	return retval;
-}
-
-static inline unsigned int srmmu_get_faddr(void)
-{
-	unsigned int retval;
-
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_FAULT_ADDR), "i" (ASI_M_MMUREGS));
-	return retval;
-}
+unsigned int srmmu_get_mmureg(void);
+void srmmu_set_mmureg(unsigned long regval);
+void srmmu_set_ctable_ptr(unsigned long paddr);
+void srmmu_set_context(int context);
+int srmmu_get_context(void);
+unsigned int srmmu_get_fstatus(void);
+unsigned int srmmu_get_faddr(void);
 
 /* This is guaranteed on all SRMMU's. */
 static inline void srmmu_flush_whole_tlb(void)
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
index c052313..7c239e5 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -45,6 +45,7 @@
 #include <asm/cpudata.h>
 #include <asm/setup.h>
 #include <asm/cacheflush.h>
+#include <asm/sections.h>
 
 #include "kernel.h"
 
@@ -237,6 +238,29 @@ static void __init per_cpu_patch(void)
 	}
 }
 
+struct leon_1insn_patch_entry {
+	unsigned int addr;
+	unsigned int insn;
+};
+
+static void leon_patch(void)
+{
+	struct leon_1insn_patch_entry *start = (void *)__leon_1insn_patch;
+	struct leon_1insn_patch_entry *end = (void *)__leon_1insn_patch_end;
+
+	if (sparc_cpu_model != sparc_leon)
+		return;
+
+	while (start < end) {
+		unsigned long addr = start->addr;
+
+		*(unsigned int *) (addr + 0) = start->insn;
+		flushi(addr);
+
+		start++;
+	}
+}
+
 enum sparc_cpu sparc_cpu_model;
 EXPORT_SYMBOL(sparc_cpu_model);
 
@@ -340,6 +364,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Run-time patch instructions to match the cpu model */
 	per_cpu_patch();
+	leon_patch();
 
 	paging_init();
 
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
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 69ffd31..a214829 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o gup.o
 obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o srmmu.o iommu.o io-unit.o
+obj-$(CONFIG_SPARC32)   += srmmu_access.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
 obj-$(CONFIG_SPARC_LEON)+= leon_mm.o
 
diff --git a/arch/sparc/mm/srmmu_access.S b/arch/sparc/mm/srmmu_access.S
new file mode 100644
index 0000000..d91e5c1
--- /dev/null
+++ b/arch/sparc/mm/srmmu_access.S
@@ -0,0 +1,82 @@
+/* Assembler variants of srmmu access functions.
+ * Implemented in assembler to allow run-time patching.
+ * LEON uses a different ASI for MMUREGS than SUN.
+ *
+ * The leon_1insn_patch infrastructure is used
+ * for the run-time patching.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asmmacro.h>
+#include <asm/pgtsrmmu.h>
+#include <asm/asi.h>
+
+/* unsigned int srmmu_get_mmureg(void) */
+ENTRY(srmmu_get_mmureg)
+SUN_INS(lda	[%g0] ASI_M_MMUREGS, %o0)
+LEON_IN(lda	[%g0] ASI_LEON_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_mmureg)
+
+/* void srmmu_set_mmureg(unsigned long regval) */
+ENTRY(srmmu_set_mmureg)
+SUN_INS(sta	%o0, [%g0] ASI_M_MMUREGS)
+LEON_IN(sta	%o0, [%g0] ASI_LEON_MMUREGS)
+	retl
+	 nop
+ENDPROC(srmmu_set_mmureg)
+
+/* void srmmu_set_ctable_ptr(unsigned long paddr) */
+ENTRY(srmmu_set_ctable_ptr)
+	/* paddr = ((paddr >> 4) & SRMMU_CTX_PMASK); */
+	srl	%o0, 4, %g1
+	and	%g1, SRMMU_CTX_PMASK, %g1
+
+	mov	SRMMU_CTXTBL_PTR, %g2
+SUN_INS(sta	%g1, [%g2] ASI_M_MMUREGS)
+LEON_IN(sta	%g1, [%g2] ASI_LEON_MMUREGS)
+	retl
+	 nop
+ENDPROC(srmmu_set_ctable_ptr)
+
+
+/* void srmmu_set_context(int context) */
+ENTRY(srmmu_set_context)
+	mov	SRMMU_CTX_REG, %g1
+SUN_INS(sta	%o0, [%g1] ASI_M_MMUREGS)
+LEON_IN(sta	%o0, [%g1] ASI_LEON_MMUREGS)
+	retl
+	 nop
+ENDPROC(srmmu_set_context)
+
+
+/* int srmmu_get_context(void) */
+ENTRY(srmmu_get_context)
+	mov	SRMMU_CTX_REG, %o0
+SUN_INS(lda	[%o0] ASI_M_MMUREGS, %o0)
+LEON_IN(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_context)
+
+
+/* unsigned int srmmu_get_fstatus(void) */
+ENTRY(srmmu_get_fstatus)
+	mov	SRMMU_FAULT_STATUS, %o0
+SUN_INS(lda	[%o0] ASI_M_MMUREGS, %o0)
+LEON_IN(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_fstatus)
+
+
+/* unsigned int srmmu_get_faddr(void) */
+ENTRY(srmmu_get_faddr)
+	mov	SRMMU_FAULT_ADDR, %o0
+SUN_INS(lda	[%o0] ASI_M_MMUREGS, %o0)
+LEON_IN(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_faddr)
-- 
1.6.0.6

