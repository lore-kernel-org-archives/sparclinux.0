From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 16:02:01 +0000
Subject: [PATCH 2/2] sparc32: remove runtime btfix support
Message-Id: <20120514160201.GB11195@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From e8ba60ce8fd0238f38c677c199488356b5564ef0 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 17:58:57 +0200
Subject: [PATCH 2/2] sparc32: remove runtime btfix support

- remove all uses of btfixup header
- remove the btfixup header
- remove the btfixup code

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/asmmacro.h       |    1 -
 arch/sparc/include/asm/btfixup.h        |  207 --------------------
 arch/sparc/include/asm/cmpxchg_32.h     |    2 -
 arch/sparc/include/asm/mmu_context_32.h |    2 -
 arch/sparc/include/asm/page_32.h        |    2 -
 arch/sparc/include/asm/pgalloc_32.h     |    1 -
 arch/sparc/include/asm/pgtable_32.h     |    1 -
 arch/sparc/include/asm/processor_32.h   |    1 -
 arch/sparc/include/asm/smp_32.h         |    1 -
 arch/sparc/include/asm/thread_info_32.h |    1 -
 arch/sparc/include/asm/timer_32.h       |    1 -
 arch/sparc/kernel/irq.h                 |    1 -
 arch/sparc/kernel/irq_32.c              |    1 -
 arch/sparc/kernel/time_32.c             |    2 -
 arch/sparc/mm/Makefile                  |    2 +-
 arch/sparc/mm/btfixup.c                 |  316 -------------------------------
 arch/sparc/mm/init_32.c                 |    1 -
 arch/sparc/mm/iommu.c                   |    1 -
 arch/sparc/mm/srmmu.c                   |    3 -
 arch/sparc/mm/viking.S                  |    1 -
 20 files changed, 1 insertions(+), 547 deletions(-)
 delete mode 100644 arch/sparc/include/asm/btfixup.h
 delete mode 100644 arch/sparc/mm/btfixup.c

diff --git a/arch/sparc/include/asm/asmmacro.h b/arch/sparc/include/asm/asmmacro.h
index 90db649..1d51161 100644
--- a/arch/sparc/include/asm/asmmacro.h
+++ b/arch/sparc/include/asm/asmmacro.h
@@ -6,7 +6,6 @@
 #ifndef _SPARC_ASMMACRO_H
 #define _SPARC_ASMMACRO_H
 
-#include <asm/btfixup.h>
 #include <asm/asi.h>
 
 #define GET_PROCESSOR4M_ID(reg) \
diff --git a/arch/sparc/include/asm/btfixup.h b/arch/sparc/include/asm/btfixup.h
deleted file mode 100644
index 48b0141..0000000
--- a/arch/sparc/include/asm/btfixup.h
+++ /dev/null
@@ -1,207 +0,0 @@
-/*
- *  asm/btfixup.h:    Macros for boot time linking.
- *
- *  Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
- 
-#ifndef _SPARC_BTFIXUP_H
-#define _SPARC_BTFIXUP_H
-
-#include <linux/init.h>
-
-#ifndef __ASSEMBLY__
-
-#ifdef MODULE
-extern unsigned int ___illegal_use_of_BTFIXUP_SIMM13_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_SETHI_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_HALF_in_module(void);
-extern unsigned int ___illegal_use_of_BTFIXUP_INT_in_module(void);
-
-#define BTFIXUP_SIMM13(__name) ___illegal_use_of_BTFIXUP_SIMM13_in_module()
-#define BTFIXUP_HALF(__name) ___illegal_use_of_BTFIXUP_HALF_in_module()
-#define BTFIXUP_SETHI(__name) ___illegal_use_of_BTFIXUP_SETHI_in_module()
-#define BTFIXUP_INT(__name) ___illegal_use_of_BTFIXUP_INT_in_module()
-#define BTFIXUP_BLACKBOX(__name) ___illegal_use_of_BTFIXUP_BLACKBOX_in_module
-
-#else
-
-#define BTFIXUP_SIMM13(__name) ___sf_##__name()
-#define BTFIXUP_HALF(__name) ___af_##__name()
-#define BTFIXUP_SETHI(__name) ___hf_##__name()
-#define BTFIXUP_INT(__name) ((unsigned int)&___i_##__name)
-/* This must be written in assembly and present in a sethi */
-#define BTFIXUP_BLACKBOX(__name) ___b_##__name
-#endif /* MODULE */
-
-/* Fixup call xx */
-
-#define BTFIXUPDEF_CALL(__type, __name, __args...) 					\
-	extern __type ___f_##__name(__args);						\
-	extern unsigned ___fs_##__name[3];
-#define BTFIXUPDEF_CALL_CONST(__type, __name, __args...) 				\
-	extern __type ___f_##__name(__args) __attribute_const__;			\
-	extern unsigned ___fs_##__name[3];
-#define BTFIXUP_CALL(__name) ___f_##__name
-
-#define BTFIXUPDEF_BLACKBOX(__name)							\
-	extern unsigned ___bs_##__name[2];
-
-/* Put bottom 13bits into some register variable */
-
-#define BTFIXUPDEF_SIMM13(__name)							\
-	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
-	extern unsigned ___ss_##__name[2];						\
-	static inline unsigned int ___sf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___s_" #__name ", %0" : "=r"(ret));			\
-		return ret;								\
-	}
-#define BTFIXUPDEF_SIMM13_INIT(__name,__val)						\
-	static inline unsigned int ___sf_##__name(void) __attribute_const__;		\
-	extern unsigned ___ss_##__name[2];						\
-	static inline unsigned int ___sf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___s_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
-		return ret;								\
-	}
-
-/* Put either bottom 13 bits, or upper 22 bits into some register variable
- * (depending on the value, this will lead into sethi FIX, reg; or
- * mov FIX, reg; )
- */
-
-#define BTFIXUPDEF_HALF(__name)								\
-	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
-	extern unsigned ___as_##__name[2];						\
-	static inline unsigned int ___af_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___a_" #__name ", %0" : "=r"(ret));			\
-		return ret;								\
-	}
-#define BTFIXUPDEF_HALF_INIT(__name,__val)						\
-	static inline unsigned int ___af_##__name(void) __attribute_const__;		\
-	extern unsigned ___as_##__name[2];						\
-	static inline unsigned int ___af_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("or %%g0, ___a_" #__name "__btset_" #__val ", %0" : "=r"(ret));\
-		return ret;								\
-	}
-
-/* Put upper 22 bits into some register variable */
-
-#define BTFIXUPDEF_SETHI(__name)							\
-	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
-	extern unsigned ___hs_##__name[2];						\
-	static inline unsigned int ___hf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("sethi %%hi(___h_" #__name "), %0" : "=r"(ret));		\
-		return ret;								\
-	}
-#define BTFIXUPDEF_SETHI_INIT(__name,__val)						\
-	static inline unsigned int ___hf_##__name(void) __attribute_const__;		\
-	extern unsigned ___hs_##__name[2];						\
-	static inline unsigned int ___hf_##__name(void) {				\
-		unsigned int ret;							\
-		__asm__ ("sethi %%hi(___h_" #__name "__btset_" #__val "), %0" : 	\
-			 "=r"(ret));							\
-		return ret;								\
-	}
-
-/* Put a full 32bit integer into some register variable */
-
-#define BTFIXUPDEF_INT(__name)								\
-	extern unsigned char ___i_##__name;						\
-	extern unsigned ___is_##__name[2];
-
-#define BTFIXUPCALL_NORM	0x00000000			/* Always call */
-#define BTFIXUPCALL_NOP		0x01000000			/* Possibly optimize to nop */
-#define BTFIXUPCALL_RETINT(i)	(0x90102000|((i) & 0x1fff))	/* Possibly optimize to mov i, %o0 */
-#define BTFIXUPCALL_ORINT(i)	(0x90122000|((i) & 0x1fff))	/* Possibly optimize to or %o0, i, %o0 */
-#define BTFIXUPCALL_RETO0	0x01000000			/* Return first parameter, actually a nop */
-#define BTFIXUPCALL_ANDNINT(i)	(0x902a2000|((i) & 0x1fff))	/* Possibly optimize to andn %o0, i, %o0 */
-#define BTFIXUPCALL_SWAPO0O1	0xd27a0000			/* Possibly optimize to swap [%o0],%o1 */
-#define BTFIXUPCALL_SWAPG1G2	0xc4784000			/* Possibly optimize to swap [%g1],%g2 */
-#define BTFIXUPCALL_STG0O0	0xc0220000			/* Possibly optimize to st %g0,[%o0] */
-#define BTFIXUPCALL_STO1O0	0xd2220000			/* Possibly optimize to st %o1,[%o0] */
-
-#define BTFIXUPSET_CALL(__name, __addr, __insn)						\
-	do {										\
-		___fs_##__name[0] |= 1;							\
-		___fs_##__name[1] = (unsigned long)__addr;				\
-		___fs_##__name[2] = __insn;						\
-	} while (0)
-	
-#define BTFIXUPSET_BLACKBOX(__name, __func)						\
-	do {										\
-		___bs_##__name[0] |= 1;							\
-		___bs_##__name[1] = (unsigned long)__func;				\
-	} while (0)
-	
-#define BTFIXUPCOPY_CALL(__name, __from)						\
-	do {										\
-		___fs_##__name[0] |= 1;							\
-		___fs_##__name[1] = ___fs_##__from[1];					\
-		___fs_##__name[2] = ___fs_##__from[2];					\
-	} while (0)
-		
-#define BTFIXUPSET_SIMM13(__name, __val)						\
-	do {										\
-		___ss_##__name[0] |= 1;							\
-		___ss_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_SIMM13(__name, __from)						\
-	do {										\
-		___ss_##__name[0] |= 1;							\
-		___ss_##__name[1] = ___ss_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_HALF(__name, __val)							\
-	do {										\
-		___as_##__name[0] |= 1;							\
-		___as_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_HALF(__name, __from)						\
-	do {										\
-		___as_##__name[0] |= 1;							\
-		___as_##__name[1] = ___as_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_SETHI(__name, __val)							\
-	do {										\
-		___hs_##__name[0] |= 1;							\
-		___hs_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_SETHI(__name, __from)						\
-	do {										\
-		___hs_##__name[0] |= 1;							\
-		___hs_##__name[1] = ___hs_##__from[1];					\
-	} while (0)
-		
-#define BTFIXUPSET_INT(__name, __val)							\
-	do {										\
-		___is_##__name[0] |= 1;							\
-		___is_##__name[1] = (unsigned)__val;					\
-	} while (0)
-	
-#define BTFIXUPCOPY_INT(__name, __from)							\
-	do {										\
-		___is_##__name[0] |= 1;							\
-		___is_##__name[1] = ___is_##__from[1];					\
-	} while (0)
-	
-#define BTFIXUPVAL_CALL(__name)								\
-	((unsigned long)___fs_##__name[1])
-	
-extern void btfixup(void);
-
-#else /* __ASSEMBLY__ */
-
-#define BTFIXUP_SETHI(__name)			%hi(___h_ ## __name)
-#define BTFIXUP_SETHI_INIT(__name,__val)	%hi(___h_ ## __name ## __btset_ ## __val)
-
-#endif /* __ASSEMBLY__ */
-	
-#endif /* !(_SPARC_BTFIXUP_H) */
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 78ac549..1fae1a0 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -11,8 +11,6 @@
 #ifndef __ARCH_SPARC_CMPXCHG__
 #define __ARCH_SPARC_CMPXCHG__
 
-#include <asm/btfixup.h>
-
 static inline unsigned long xchg_u32(__volatile__ unsigned long *m, unsigned long val)
 {
 	__asm__ __volatile__("swap [%2], %0"
diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 623b598..01456c9 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -1,8 +1,6 @@
 #ifndef __SPARC_MMU_CONTEXT_H
 #define __SPARC_MMU_CONTEXT_H
 
-#include <asm/btfixup.h>
-
 #ifndef __ASSEMBLY__
 
 #include <asm-generic/mm_hooks.h>
diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 0c902ae..fab78a3 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -14,8 +14,6 @@
 #define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK    (~(PAGE_SIZE-1))
 
-#include <asm/btfixup.h>
-
 #ifndef __ASSEMBLY__
 
 #define clear_page(page)	 memset((void *)(page), 0, PAGE_SIZE)
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 47bf660..e5b169b 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -5,7 +5,6 @@
 #include <linux/sched.h>
 
 #include <asm/pgtsrmmu.h>
-#include <asm/btfixup.h>
 #include <asm/pgtable.h>
 #include <asm/vaddrs.h>
 #include <asm/page.h>
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index b7c202f..28a67bf 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -19,7 +19,6 @@
 #include <asm/pgtsrmmu.h>
 #include <asm/vaddrs.h>
 #include <asm/oplib.h>
-#include <asm/btfixup.h>
 #include <asm/cpu_type.h>
 
 
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/processor_32.h
index 09521c6..9cbd854 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -16,7 +16,6 @@
 #include <asm/ptrace.h>
 #include <asm/head.h>
 #include <asm/signal.h>
-#include <asm/btfixup.h>
 #include <asm/page.h>
 
 /*
diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index d596061..b9cf697 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -8,7 +8,6 @@
 
 #include <linux/threads.h>
 #include <asm/head.h>
-#include <asm/btfixup.h>
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index 74316de..cd0b2dc 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -15,7 +15,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/btfixup.h>
 #include <asm/ptrace.h>
 #include <asm/page.h>
 
diff --git a/arch/sparc/include/asm/timer_32.h b/arch/sparc/include/asm/timer_32.h
index 703653e..72f40a5 100644
--- a/arch/sparc/include/asm/timer_32.h
+++ b/arch/sparc/include/asm/timer_32.h
@@ -14,7 +14,6 @@
 #include <asm-generic/percpu.h>
 
 #include <asm/cpu_type.h>  /* For SUN4M_NCPUS */
-#include <asm/btfixup.h>
 
 #define SBUS_CLOCK_RATE   2000000 /* 2MHz */
 #define TIMER_VALUE_SHIFT 9
diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index f558f71..b66b6aa 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -1,6 +1,5 @@
 #include <linux/platform_device.h>
 
-#include <asm/btfixup.h>
 #include <asm/cpu_type.h>
 
 struct irq_bucket {
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 998d90c..a33009f 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -366,6 +366,5 @@ void __init init_IRQ(void)
 		prom_printf("Cannot initialize IRQs on this Sun machine...");
 		break;
 	}
-	btfixup();
 }
 
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 459cf66..9536415 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -356,8 +356,6 @@ static void __init sbus_time_init(void)
 
 void __init time_init(void)
 {
-	btfixup();
-
 	sparc_config.features = 0;
 	late_time_init = sparc32_late_time_init;
 
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index c7f156a..69ffd31 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -7,7 +7,7 @@ ccflags-y := -Werror
 obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o gup.o
 obj-y                   += fault_$(BITS).o
 obj-y                   += init_$(BITS).o
-obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
+obj-$(CONFIG_SPARC32)   += extable.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
 obj-$(CONFIG_SPARC_LEON)+= leon_mm.o
 
diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
deleted file mode 100644
index dcbb7ff..0000000
--- a/arch/sparc/mm/btfixup.c
+++ /dev/null
@@ -1,316 +0,0 @@
-/* btfixup.c: Boot time code fixup and relocator, so that
- * we can get rid of most indirect calls to achieve single
- * image sun4c and srmmu kernel.
- *
- * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <asm/btfixup.h>
-#include <asm/page.h>
-#include <asm/pgalloc.h>
-#include <asm/pgtable.h>
-#include <asm/oplib.h>
-#include <asm/cacheflush.h>
-
-#define BTFIXUP_OPTIMIZE_NOP
-#define BTFIXUP_OPTIMIZE_OTHER
-
-extern char *srmmu_name;
-static char version[] __initdata = "Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for ";
-static char str_srmmu[] __initdata = "srmmu[%s]/";
-static char str_iommu[] __initdata = "iommu\n";
-static char str_iounit[] __initdata = "io-unit\n";
-
-static int visited __initdata = 0;
-extern unsigned int ___btfixup_start[], ___btfixup_end[], __init_begin[], __init_end[], __init_text_end[];
-extern unsigned int _stext[], _end[], __start___ksymtab[], __stop___ksymtab[];
-static char wrong_f[] __initdata = "Trying to set f fixup %p to invalid function %08x\n";
-static char wrong_b[] __initdata = "Trying to set b fixup %p to invalid function %08x\n";
-static char wrong_s[] __initdata = "Trying to set s fixup %p to invalid value %08x\n";
-static char wrong_h[] __initdata = "Trying to set h fixup %p to invalid value %08x\n";
-static char wrong_a[] __initdata = "Trying to set a fixup %p to invalid value %08x\n";
-static char wrong[] __initdata = "Wrong address for %c fixup %p\n";
-static char insn_f[] __initdata = "Fixup f %p refers to weird instructions at %p[%08x,%08x]\n";
-static char insn_b[] __initdata = "Fixup b %p doesn't refer to a SETHI at %p[%08x]\n";
-static char insn_s[] __initdata = "Fixup s %p doesn't refer to an OR at %p[%08x]\n";
-static char insn_h[] __initdata = "Fixup h %p doesn't refer to a SETHI at %p[%08x]\n";
-static char insn_a[] __initdata = "Fixup a %p doesn't refer to a SETHI nor OR at %p[%08x]\n";
-static char insn_i[] __initdata = "Fixup i %p doesn't refer to a valid instruction at %p[%08x]\n";
-static char wrong_setaddr[] __initdata = "Garbled CALL/INT patch at %p[%08x,%08x,%08x]=%08x\n";
-
-#ifdef BTFIXUP_OPTIMIZE_OTHER
-static void __init set_addr(unsigned int *addr, unsigned int q1, int fmangled, unsigned int value)
-{
-	if (!fmangled)
-		*addr = value;
-	else {
-		unsigned int *q = (unsigned int *)q1;
-		if (*addr = 0x01000000) {
-			/* Noped */
-			*q = value;
-		} else if (addr[-1] = *q) {
-			/* Moved */
-			addr[-1] = value;
-			*q = value;
-		} else {
-			prom_printf(wrong_setaddr, addr-1, addr[-1], *addr, *q, value);
-			prom_halt();
-		}
-	}
-}
-#else
-static inline void set_addr(unsigned int *addr, unsigned int q1, int fmangled, unsigned int value)
-{
-	*addr = value;
-}
-#endif
-
-void __init btfixup(void)
-{
-	unsigned int *p, *q;
-	int type, count;
-	unsigned insn;
-	unsigned *addr;
-	int fmangled = 0;
-	
-	if (!visited) {
-		visited++;
-		printk(version);
-		printk(str_srmmu, srmmu_name);
-		if (sparc_cpu_model = sun4d)
-			printk(str_iounit);
-		else
-			printk(str_iommu);
-	}
-	for (p = ___btfixup_start; p < ___btfixup_end; ) {
-		count = p[2];
-		q = p + 3;
-		switch (type = *(unsigned char *)p) {
-		case 'f': 
-			count = p[3];
-			q = p + 4;
-			if (((p[0] & 1) || p[1]) 
-			    && ((p[1] & 3) || (unsigned *)(p[1]) < _stext || (unsigned *)(p[1]) >= _end)) {
-				prom_printf(wrong_f, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 'b':
-			if (p[1] < (unsigned long)__init_begin || p[1] >= (unsigned long)__init_text_end || (p[1] & 3)) {
-				prom_printf(wrong_b, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 's':
-			if (p[1] + 0x1000 >= 0x2000) {
-				prom_printf(wrong_s, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 'h':
-			if (p[1] & 0x3ff) {
-				prom_printf(wrong_h, p, p[1]);
-				prom_halt();
-			}
-			break;
-		case 'a':
-			if (p[1] + 0x1000 >= 0x2000 && (p[1] & 0x3ff)) {
-				prom_printf(wrong_a, p, p[1]);
-				prom_halt();
-			}
-			break;
-		}
-		if (p[0] & 1) {
-			p[0] &= ~1;
-			while (count) {
-				fmangled = 0;
-				addr = (unsigned *)*q;
-				if (addr < _stext || addr >= _end) {
-					prom_printf(wrong, type, p);
-					prom_halt();
-				}
-				insn = *addr;
-#ifdef BTFIXUP_OPTIMIZE_OTHER				
-				if (type != 'f' && q[1]) {
-					insn = *(unsigned int *)q[1];
-					if (!insn || insn = 1)
-						insn = *addr;
-					else
-						fmangled = 1;
-				}
-#endif
-				switch (type) {
-				case 'f':	/* CALL */
-					if (addr >= __start___ksymtab && addr < __stop___ksymtab) {
-						*addr = p[1];
-						break;
-					} else if (!q[1]) {
-						if ((insn & 0xc1c00000) = 0x01000000) { /* SETHI */
-							*addr = (insn & 0xffc00000) | (p[1] >> 10); break;
-						} else if ((insn & 0xc1f82000) = 0x80102000) { /* OR X, %LO(i), Y */
-							*addr = (insn & 0xffffe000) | (p[1] & 0x3ff); break;
-						} else if ((insn & 0xc0000000) != 0x40000000) { /* !CALL */
-				bad_f:
-							prom_printf(insn_f, p, addr, insn, addr[1]);
-							prom_halt();
-						}
-					} else if (q[1] != 1)
-						addr[1] = q[1];
-					if (p[2] = BTFIXUPCALL_NORM) {
-				norm_f:	
-						*addr = 0x40000000 | ((p[1] - (unsigned)addr) >> 2);
-						q[1] = 0;
-						break;
-					}
-#ifndef BTFIXUP_OPTIMIZE_NOP
-					goto norm_f;
-#else
-					if (!(addr[1] & 0x80000000)) {
-						if ((addr[1] & 0xc1c00000) != 0x01000000)	/* !SETHI */
-							goto bad_f; /* CALL, Bicc, FBfcc, CBccc are weird in delay slot, aren't they? */
-					} else {
-						if ((addr[1] & 0x01800000) = 0x01800000) {
-							if ((addr[1] & 0x01f80000) = 0x01e80000) {
-								/* RESTORE */
-								goto norm_f; /* It is dangerous to patch that */
-							}
-							goto bad_f;
-						}
-						if ((addr[1] & 0xffffe003) = 0x9e03e000) {
-							/* ADD %O7, XX, %o7 */
-							int displac = (addr[1] << 19);
-							
-							displac = (displac >> 21) + 2;
-							*addr = (0x10800000) + (displac & 0x3fffff);
-							q[1] = addr[1];
-							addr[1] = p[2];
-							break;
-						}
-						if ((addr[1] & 0x201f) = 0x200f || (addr[1] & 0x7c000) = 0x3c000)
-							goto norm_f; /* Someone is playing bad tricks with us: rs1 or rs2 is o7 */
-						if ((addr[1] & 0x3e000000) = 0x1e000000)
-							goto norm_f; /* rd is %o7. We'd better take care. */
-					}
-					if (p[2] = BTFIXUPCALL_NOP) {
-						*addr = 0x01000000;
-						q[1] = 1;
-						break;
-					}
-#ifndef BTFIXUP_OPTIMIZE_OTHER
-					goto norm_f;
-#else
-					if (addr[1] = 0x01000000) {	/* NOP in the delay slot */
-						q[1] = addr[1];
-						*addr = p[2];
-						break;
-					}
-					if ((addr[1] & 0xc0000000) != 0xc0000000) {
-						/* Not a memory operation */
-						if ((addr[1] & 0x30000000) = 0x10000000) {
-							/* Ok, non-memory op with rd %oX */
-							if ((addr[1] & 0x3e000000) = 0x1c000000)
-								goto bad_f; /* Aiee. Someone is playing strange %sp tricks */
-							if ((addr[1] & 0x3e000000) > 0x12000000 ||
-							    ((addr[1] & 0x3e000000) = 0x12000000 &&
-							     p[2] != BTFIXUPCALL_STO1O0 && p[2] != BTFIXUPCALL_SWAPO0O1) ||
-							    ((p[2] & 0xffffe000) = BTFIXUPCALL_RETINT(0))) {
-								/* Nobody uses the result. We can nop it out. */
-								*addr = p[2];
-								q[1] = addr[1];
-								addr[1] = 0x01000000;
-								break;
-							}
-							if ((addr[1] & 0xf1ffffe0) = 0x90100000) {
-								/* MOV %reg, %Ox */
-								if ((addr[1] & 0x3e000000) = 0x10000000 &&
-								    (p[2] & 0x7c000) = 0x20000) {
-								    	/* Ok, it is call xx; mov reg, %o0 and call optimizes
-								    	   to doing something on %o0. Patch the patch. */
-									*addr = (p[2] & ~0x7c000) | ((addr[1] & 0x1f) << 14);
-									q[1] = addr[1];
-									addr[1] = 0x01000000;
-									break;
-								}
-								if ((addr[1] & 0x3e000000) = 0x12000000 &&
-								    p[2] = BTFIXUPCALL_STO1O0) {
-								    	*addr = (p[2] & ~0x3e000000) | ((addr[1] & 0x1f) << 25);
-								    	q[1] = addr[1];
-								    	addr[1] = 0x01000000;
-								    	break;
-								}
-							}
-						}
-					}
-					*addr = addr[1];
-					q[1] = addr[1];
-					addr[1] = p[2];
-					break;
-#endif /* BTFIXUP_OPTIMIZE_OTHER */
-#endif /* BTFIXUP_OPTIMIZE_NOP */
-				case 'b':	/* BLACKBOX */
-					/* Has to be sethi i, xx */
-					if ((insn & 0xc1c00000) != 0x01000000) {
-						prom_printf(insn_b, p, addr, insn);
-						prom_halt();
-					} else {
-						void (*do_fixup)(unsigned *);
-						
-						do_fixup = (void (*)(unsigned *))p[1];
-						do_fixup(addr);
-					}
-					break;
-				case 's':	/* SIMM13 */
-					/* Has to be or %g0, i, xx */
-					if ((insn & 0xc1ffe000) != 0x80102000) {
-						prom_printf(insn_s, p, addr, insn);
-						prom_halt();
-					}
-					set_addr(addr, q[1], fmangled, (insn & 0xffffe000) | (p[1] & 0x1fff));
-					break;
-				case 'h':	/* SETHI */
-					/* Has to be sethi i, xx */
-					if ((insn & 0xc1c00000) != 0x01000000) {
-						prom_printf(insn_h, p, addr, insn);
-						prom_halt();
-					}
-					set_addr(addr, q[1], fmangled, (insn & 0xffc00000) | (p[1] >> 10));
-					break;
-				case 'a':	/* HALF */
-					/* Has to be sethi i, xx or or %g0, i, xx */
-					if ((insn & 0xc1c00000) != 0x01000000 &&
-					    (insn & 0xc1ffe000) != 0x80102000) {
-						prom_printf(insn_a, p, addr, insn);
-						prom_halt();
-					}
-					if (p[1] & 0x3ff)
-						set_addr(addr, q[1], fmangled, 
-							(insn & 0x3e000000) | 0x80102000 | (p[1] & 0x1fff));
-					else
-						set_addr(addr, q[1], fmangled, 
-							(insn & 0x3e000000) | 0x01000000 | (p[1] >> 10));
-					break;
-				case 'i':	/* INT */
-					if ((insn & 0xc1c00000) = 0x01000000) /* %HI */
-						set_addr(addr, q[1], fmangled, (insn & 0xffc00000) | (p[1] >> 10));
-					else if ((insn & 0x80002000) = 0x80002000) /* %LO */
-						set_addr(addr, q[1], fmangled, (insn & 0xffffe000) | (p[1] & 0x3ff));
-					else {
-						prom_printf(insn_i, p, addr, insn);
-						prom_halt();
-					}
-					break;
-				}
-				count -= 2;
-				q += 2;
-			}
-		} else
-			p = q + count;
-	}
-#ifdef CONFIG_SMP
-	local_ops->cache_all();
-#else
-	sparc32_cachetlb_ops->cache_all();
-#endif
-}
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index a64b0bb..ef5c779 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -308,7 +308,6 @@ void __init paging_init(void)
 		prom_halt();
 	}
 
-	btfixup();
 	prom_build_devicetree();
 	of_fill_in_cpu_data();
 	device_scan();
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 720bea2..a8a58ca 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -141,7 +141,6 @@ static int __init iommu_init(void)
 
 subsys_initcall(iommu_init);
 
-/* This begs to be btfixup-ed by srmmu. */
 /* Flush the iotlb entries to ram. */
 /* This could be better if we didn't have to flush whole pages. */
 static void iommu_flush_iotlb(iopte_t *iopte, unsigned int niopte)
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cba05fa..765b1a5 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -48,8 +48,6 @@
 #include <asm/turbosparc.h>
 #include <asm/leon.h>
 
-#include <asm/btfixup.h>
-
 enum mbus_module srmmu_modtype;
 static unsigned int hwbug_bitmask;
 int vac_cache_size;
@@ -2186,5 +2184,4 @@ void __init load_mmu(void)
 	else
 		sun4m_init_smp();
 #endif
-	btfixup();
 }
diff --git a/arch/sparc/mm/viking.S b/arch/sparc/mm/viking.S
index 6dfcc13..bf8ee06 100644
--- a/arch/sparc/mm/viking.S
+++ b/arch/sparc/mm/viking.S
@@ -14,7 +14,6 @@
 #include <asm/page.h>
 #include <asm/pgtsrmmu.h>
 #include <asm/viking.h>
-#include <asm/btfixup.h>
 
 #ifdef CONFIG_SMP
 	.data
-- 
1.6.0.6

