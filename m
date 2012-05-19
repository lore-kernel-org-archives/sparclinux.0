From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 May 2012 20:03:21 +0000
Subject: [RFC PATCH] sparc32: make srmmu helpers leon compatible
Message-Id: <20120519200321.GA7617@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I am trying to make the saprc32 kernel compatible with
leon and sun4m, sun4d boxes at the same time.

The stuff in arch/sparc/mm/ looked like the simplest
to fix so I looked at that first.
Some of the helper functions used ASI_M_MMUREGS which
is redefiend to 0x19 in the LEON case - so these functions
needs some special care.

I was originally planning to use the cpuid_patch support
to deal with the differences - but this is only in place
_after_ we have initialised the mmu.

But sparc_cpu_model is set before we initialize the mmu,
so we could use that.

I came up with the following that I am not too happy with...
Some of the functions are really not used by leon, but I
converted all to be complete.

Any better ideas?

Could we call per_cpu_patch() before paging_init() maybe?

The patch below depends on other changes I only have in my
tree - to be submitted if/when ready.

	Sam


diff --git a/arch/sparc/include/asm/cpu_type.h b/arch/sparc/include/asm/cpu_type.h
index 84d7d83..5a8b206 100644
--- a/arch/sparc/include/asm/cpu_type.h
+++ b/arch/sparc/include/asm/cpu_type.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_CPU_TYPE_H
 #define __ASM_CPU_TYPE_H
 
+#ifndef __ASSEMBLY__
 /*
  * Sparc (general) CPU types
  */
@@ -25,4 +26,5 @@ extern enum sparc_cpu sparc_cpu_model;
 
 #endif
 
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index cb82870..4b50085 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -7,6 +7,7 @@
 #ifndef _SPARC_PGTSRMMU_H
 #define _SPARC_PGTSRMMU_H
 
+#include <asm/cpu_type.h>
 #include <asm/page.h>
 
 #ifdef __ASSEMBLY__
@@ -151,42 +152,81 @@ extern void *srmmu_nocache_pool;
 static inline unsigned int srmmu_get_mmureg(void)
 {
         unsigned int retval;
-	__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
-			     "=r" (retval) :
-			     "i" (ASI_M_MMUREGS));
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
+				     "=r" (retval) :
+				     "i" (ASI_M_MMUREGS));
+	} else {
+		__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
+				     "=r" (retval) :
+				     "i" (ASI_LEON_MMUREGS));
+	}
+
 	return retval;
 }
 
 static inline void srmmu_set_mmureg(unsigned long regval)
 {
-	__asm__ __volatile__("sta %0, [%%g0] %1\n\t" : :
-			     "r" (regval), "i" (ASI_M_MMUREGS) : "memory");
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("sta %0, [%%g0] %1\n\t" : :
+				     "r" (regval),
+				     "i" (ASI_M_MMUREGS) :
+				     "memory");
+	} else {
+		__asm__ __volatile__("sta %0, [%%g0] %1\n\t" : :
+				     "r" (regval),
+				     "i" (ASI_LEON_MMUREGS) :
+				     "memory");
+	}
 
 }
 
 static inline void srmmu_set_ctable_ptr(unsigned long paddr)
 {
 	paddr = ((paddr >> 4) & SRMMU_CTX_PMASK);
-	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
-			     "r" (paddr), "r" (SRMMU_CTXTBL_PTR),
-			     "i" (ASI_M_MMUREGS) :
-			     "memory");
+
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
+				     "r" (paddr), "r" (SRMMU_CTXTBL_PTR),
+				     "i" (ASI_M_MMUREGS) :
+				     "memory");
+	} else {
+		__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
+				     "r" (paddr), "r" (SRMMU_CTXTBL_PTR),
+				     "i" (ASI_LEON_MMUREGS) :
+				     "memory");
+	}
 }
 
 static inline void srmmu_set_context(int context)
 {
-	__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
-			     "r" (context), "r" (SRMMU_CTX_REG),
-			     "i" (ASI_M_MMUREGS) : "memory");
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
+				     "r" (context), "r" (SRMMU_CTX_REG),
+				     "i" (ASI_M_MMUREGS) : "memory");
+	} else {
+		__asm__ __volatile__("sta %0, [%1] %2\n\t" : :
+				     "r" (context), "r" (SRMMU_CTX_REG),
+				     "i" (ASI_LEON_MMUREGS) : "memory");
+	}
 }
 
 static inline int srmmu_get_context(void)
 {
 	register int retval;
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_CTX_REG),
-			     "i" (ASI_M_MMUREGS));
+
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_CTX_REG),
+				     "i" (ASI_M_MMUREGS));
+	} else {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_CTX_REG),
+				     "i" (ASI_LEON_MMUREGS));
+	}
+
 	return retval;
 }
 
@@ -194,9 +234,15 @@ static inline unsigned int srmmu_get_fstatus(void)
 {
 	unsigned int retval;
 
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_FAULT_STATUS), "i" (ASI_M_MMUREGS));
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_FAULT_STATUS), "i" (ASI_M_MMUREGS));
+	} else {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_FAULT_STATUS), "i" (ASI_LEON_MMUREGS));
+	}
 	return retval;
 }
 
@@ -204,9 +250,15 @@ static inline unsigned int srmmu_get_faddr(void)
 {
 	unsigned int retval;
 
-	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
-			     "=r" (retval) :
-			     "r" (SRMMU_FAULT_ADDR), "i" (ASI_M_MMUREGS));
+	if (sparc_cpu_model != sparc_leon) {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_FAULT_ADDR), "i" (ASI_M_MMUREGS));
+	} else {
+		__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+				     "=r" (retval) :
+				     "r" (SRMMU_FAULT_ADDR), "i" (ASI_LEON_MMUREGS));
+	}
 	return retval;
 }
 
