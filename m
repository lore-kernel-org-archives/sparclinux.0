From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2012 20:14:23 +0000
Subject: [PATCH] sparc32: Kill btfixup for xchg()'s 'swap' instruction.
Message-Id: <20120513.161423.1387701471724599460.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We always have this instruction available, so no need to use
btfixup for it any more.

This also eradicates the whole of atomic_32.S and thus the
__atomic_begin and __atomic_end symbols completely.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cmpxchg_32.h |   25 -------------------------
 arch/sparc/kernel/sparc_ksyms_32.c  |    4 +---
 arch/sparc/kernel/time_32.c         |    3 ---
 arch/sparc/lib/Makefile             |    2 +-
 arch/sparc/lib/atomic_32.S          |   24 ------------------------
 arch/sparc/mm/srmmu.c               |    5 -----
 6 files changed, 2 insertions(+), 61 deletions(-)
 delete mode 100644 arch/sparc/lib/atomic_32.S

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index c786b0a..78ac549 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -13,38 +13,13 @@
 
 #include <asm/btfixup.h>
 
-/* This has special calling conventions */
-#ifndef CONFIG_SMP
-BTFIXUPDEF_CALL(void, ___xchg32, void)
-#endif
-
 static inline unsigned long xchg_u32(__volatile__ unsigned long *m, unsigned long val)
 {
-#ifdef CONFIG_SMP
 	__asm__ __volatile__("swap [%2], %0"
 			     : "=&r" (val)
 			     : "0" (val), "r" (m)
 			     : "memory");
 	return val;
-#else
-	register unsigned long *ptr asm("g1");
-	register unsigned long ret asm("g2");
-
-	ptr = (unsigned long *) m;
-	ret = val;
-
-	/* Note: this is magic and the nop there is
-	   really needed. */
-	__asm__ __volatile__(
-	"mov	%%o7, %%g4\n\t"
-	"call	___f____xchg32\n\t"
-	" nop\n\t"
-	: "=&r" (ret)
-	: "0" (ret), "r" (ptr)
-	: "g3", "g4", "g7", "memory", "cc");
-
-	return ret;
-#endif
 }
 
 extern void __xchg_called_with_bad_pointer(void);
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index fd38a92..9763895 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -29,9 +29,7 @@ EXPORT_SYMBOL(__ret_efault);
 EXPORT_SYMBOL(empty_zero_page);
 
 /* Defined using magic */
-#ifndef CONFIG_SMP
-EXPORT_SYMBOL(BTFIXUP_CALL(___xchg32));
-#else
+#ifdef CONFIG_SMP
 EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
 #endif
 EXPORT_SYMBOL(BTFIXUP_CALL(mmu_unlockarea));
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 157dcc5..1e25a7a 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -68,7 +68,6 @@ static int set_rtc_mmss(unsigned long);
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	extern char __copy_user_begin[], __copy_user_end[];
-	extern char __atomic_begin[], __atomic_end[];
 	extern char __bzero_begin[], __bzero_end[];
 
 	unsigned long pc = regs->pc;
@@ -76,8 +75,6 @@ unsigned long profile_pc(struct pt_regs *regs)
 	if (in_lock_functions(pc) ||
 	    (pc >= (unsigned long) __copy_user_begin &&
 	     pc < (unsigned long) __copy_user_end) ||
-	    (pc >= (unsigned long) __atomic_begin &&
-	     pc < (unsigned long) __atomic_end) ||
 	    (pc >= (unsigned long) __bzero_begin &&
 	     pc < (unsigned long) __bzero_end))
 		pc = regs->u_regs[UREG_RETPC];
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index a3fc437..33d8d85 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -13,7 +13,7 @@ lib-y                 += memscan_$(BITS).o memcmp.o strncmp_$(BITS).o
 lib-y                 += strncpy_from_user_$(BITS).o strlen_user_$(BITS).o
 lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
-lib-y                 += atomic_$(BITS).o
+lib-$(CONFIG_SPARC64) += atomic_64.o
 lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 
diff --git a/arch/sparc/lib/atomic_32.S b/arch/sparc/lib/atomic_32.S
deleted file mode 100644
index e2a9085..0000000
--- a/arch/sparc/lib/atomic_32.S
+++ /dev/null
@@ -1,24 +0,0 @@
-/* atomic.S: Move this stuff here for better ICACHE hit rates.
- *
- * Copyright (C) 1996 David S. Miller (davem@caipfs.rutgers.edu)
- */
-
-#include <asm/ptrace.h>
-#include <asm/psr.h>
-
-	.text
-	.align	4
-
-	.globl  __atomic_begin
-__atomic_begin:
-
-#ifndef CONFIG_SMP
-	.globl	___xchg32_sun4md
-___xchg32_sun4md:
-	swap	[%g1], %g2
-	jmpl	%o7 + 8, %g0
-	 mov	%g4, %o7
-#endif
-
-	.globl  __atomic_end
-__atomic_end:
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 0a47b82..6efcb6b 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1980,13 +1980,8 @@ void __init load_mmu(void)
 {
 	extern void ld_mmu_iommu(void);
 	extern void ld_mmu_iounit(void);
-	extern void ___xchg32_sun4md(void);
 
 	/* Functions */
-#ifndef CONFIG_SMP	
-	BTFIXUPSET_CALL(___xchg32, ___xchg32_sun4md, BTFIXUPCALL_SWAPG1G2);
-#endif
-
 	BTFIXUPSET_CALL(update_mmu_cache, srmmu_update_mmu_cache, BTFIXUPCALL_NOP);
 
 	get_srmmu_type();
-- 
1.7.10

