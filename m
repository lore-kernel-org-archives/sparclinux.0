From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:17 +0000
Subject: [PATCH 13/15] sparc32: introduce run-time patching of srmmu access functions
Message-Id: <1338016819-22245-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

LEON uses a different ASI than SUN for MMUREGS

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/pgtsrmmu.h |   68 +++---------------------------
 arch/sparc/mm/Makefile            |    1 +
 arch/sparc/mm/srmmu_access.S      |   82 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 61 deletions(-)
 create mode 100644 arch/sparc/mm/srmmu_access.S

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 394fe25..72f7121 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -149,67 +149,13 @@ extern void *srmmu_nocache_pool;
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
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 389aebd..30c3ecc 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o gup.o
 obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o srmmu.o iommu.o io-unit.o
+obj-$(CONFIG_SPARC32)   += srmmu_access.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
 obj-$(CONFIG_SPARC32)   += leon_mm.o
 
diff --git a/arch/sparc/mm/srmmu_access.S b/arch/sparc/mm/srmmu_access.S
new file mode 100644
index 0000000..d0a67b2
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
+LEON_PI(lda	[%g0] ASI_LEON_MMUREGS, %o0)
+SUN_PI_(lda	[%g0] ASI_M_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_mmureg)
+
+/* void srmmu_set_mmureg(unsigned long regval) */
+ENTRY(srmmu_set_mmureg)
+LEON_PI(sta	%o0, [%g0] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%o0, [%g0] ASI_M_MMUREGS)
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
+LEON_PI(sta	%g1, [%g2] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%g1, [%g2] ASI_M_MMUREGS)
+	retl
+	 nop
+ENDPROC(srmmu_set_ctable_ptr)
+
+
+/* void srmmu_set_context(int context) */
+ENTRY(srmmu_set_context)
+	mov	SRMMU_CTX_REG, %g1
+LEON_PI(sta	%o0, [%g1] ASI_LEON_MMUREGS)
+SUN_PI_(sta	%o0, [%g1] ASI_M_MMUREGS)
+	retl
+	 nop
+ENDPROC(srmmu_set_context)
+
+
+/* int srmmu_get_context(void) */
+ENTRY(srmmu_get_context)
+	mov	SRMMU_CTX_REG, %o0
+LEON_PI(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+SUN_PI_(lda	[%o0] ASI_M_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_context)
+
+
+/* unsigned int srmmu_get_fstatus(void) */
+ENTRY(srmmu_get_fstatus)
+	mov	SRMMU_FAULT_STATUS, %o0
+LEON_PI(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+SUN_PI_(lda	[%o0] ASI_M_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_fstatus)
+
+
+/* unsigned int srmmu_get_faddr(void) */
+ENTRY(srmmu_get_faddr)
+	mov	SRMMU_FAULT_ADDR, %o0
+LEON_PI(lda     [%o0] ASI_LEON_MMUREGS, %o0)
+SUN_PI_(lda	[%o0] ASI_M_MMUREGS, %o0)
+	retl
+	 nop
+ENDPROC(srmmu_get_faddr)
-- 
1.6.0.6

