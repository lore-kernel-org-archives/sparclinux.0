From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 05:09:44 +0000
Subject: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515.010944.1681839607025121917.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It's the one aberration in v8, the only cpu that
didn't actually have hardware multiply and divide
instructions.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I'm tempted to push this.

Sam, what's your take on it?

 arch/sparc/include/asm/cypress.h |   79 ---------
 arch/sparc/include/asm/elf_32.h  |   12 +-
 arch/sparc/include/asm/mbus.h    |    4 -
 arch/sparc/kernel/head_32.S      |   15 --
 arch/sparc/kernel/irq_32.c       |   11 --
 arch/sparc/mm/srmmu.c            |  333 +-------------------------------------
 6 files changed, 5 insertions(+), 449 deletions(-)
 delete mode 100644 arch/sparc/include/asm/cypress.h

diff --git a/arch/sparc/include/asm/cypress.h b/arch/sparc/include/asm/cypress.h
deleted file mode 100644
index 95e9772..0000000
--- a/arch/sparc/include/asm/cypress.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * cypress.h: Cypress module specific definitions and defines.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-#ifndef _SPARC_CYPRESS_H
-#define _SPARC_CYPRESS_H
-
-/* Cypress chips have %psr 'impl' of '0001' and 'vers' of '0001'. */
-
-/* The MMU control register fields on the Sparc Cypress 604/605 MMU's.
- *
- * ---------------------------------------------------------------
- * |implvers| MCA | MCM |MV| MID |BM| C|RSV|MR|CM|CL|CE|RSV|NF|ME|
- * ---------------------------------------------------------------
- *  31    24 23-22 21-20 19 18-15 14 13  12 11 10  9  8 7-2  1  0
- *
- * MCA: MultiChip Access -- Used for configuration of multiple
- *      CY7C604/605 cache units.
- * MCM: MultiChip Mask -- Again, for multiple cache unit config.
- * MV: MultiChip Valid -- Indicates MCM and MCA have valid settings.
- * MID: ModuleID -- Unique processor ID for MBus transactions. (605 only)
- * BM: Boot Mode -- 0 = not in boot mode, 1 = in boot mode
- * C: Cacheable -- Indicates whether accesses are cacheable while
- *    the MMU is off.  0=no 1=yes
- * MR: MemoryReflection -- Indicates whether the bus attached to the
- *     MBus supports memory reflection. 0=no 1=yes (605 only)
- * CM: CacheMode -- Indicates whether the cache is operating in write
- *     through or copy-back mode. 0=write-through 1=copy-back
- * CL: CacheLock -- Indicates if the entire cache is locked or not.
- *     0=not-locked 1=locked  (604 only)
- * CE: CacheEnable -- Is the virtual cache on? 0=no 1=yes
- * NF: NoFault -- Do faults generate traps? 0=yes 1=no
- * ME: MmuEnable -- Is the MMU doing translations? 0=no 1=yes
- */
-
-#define CYPRESS_MCA       0x00c00000
-#define CYPRESS_MCM       0x00300000
-#define CYPRESS_MVALID    0x00080000
-#define CYPRESS_MIDMASK   0x00078000   /* Only on 605 */
-#define CYPRESS_BMODE     0x00004000
-#define CYPRESS_ACENABLE  0x00002000
-#define CYPRESS_MRFLCT    0x00000800   /* Only on 605 */
-#define CYPRESS_CMODE     0x00000400
-#define CYPRESS_CLOCK     0x00000200   /* Only on 604 */
-#define CYPRESS_CENABLE   0x00000100
-#define CYPRESS_NFAULT    0x00000002
-#define CYPRESS_MENABLE   0x00000001
-
-static inline void cypress_flush_page(unsigned long page)
-{
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
-			     "r" (page), "i" (ASI_M_FLUSH_PAGE));
-}
-
-static inline void cypress_flush_segment(unsigned long addr)
-{
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
-			     "r" (addr), "i" (ASI_M_FLUSH_SEG));
-}
-
-static inline void cypress_flush_region(unsigned long addr)
-{
-	__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
-			     "r" (addr), "i" (ASI_M_FLUSH_REGION));
-}
-
-static inline void cypress_flush_context(void)
-{
-	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t" : :
-			     "i" (ASI_M_FLUSH_CTX));
-}
-
-/* XXX Displacement flushes for buggy chips and initial testing
- * XXX go here.
- */
-
-#endif /* !(_SPARC_CYPRESS_H) */
diff --git a/arch/sparc/include/asm/elf_32.h b/arch/sparc/include/asm/elf_32.h
index b5beb11..2d4d755 100644
--- a/arch/sparc/include/asm/elf_32.h
+++ b/arch/sparc/include/asm/elf_32.h
@@ -118,15 +118,9 @@ typedef struct {
    instruction set this cpu supports.  This can NOT be done in userspace
    on Sparc.  */
 
-/* Most sun4m's have them all.
- * XXX This is gross, set some global variable at boot time. -DaveM
- */
-#define ELF_HWCAP	((HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | \
-			  HWCAP_SPARC_SWAP | \
-			  ((srmmu_modtype != Cypress && \
-			    srmmu_modtype != Cypress_vE && \
-			    srmmu_modtype != Cypress_vD) ? \
-			   HWCAP_SPARC_MULDIV : 0)))
+/* Most sun4m's have them all.  */
+#define ELF_HWCAP	(HWCAP_SPARC_FLUSH | HWCAP_SPARC_STBAR | \
+			 HWCAP_SPARC_SWAP | HWCAP_SPARC_MULDIV)
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
diff --git a/arch/sparc/include/asm/mbus.h b/arch/sparc/include/asm/mbus.h
index 69f07a0..14128bc 100644
--- a/arch/sparc/include/asm/mbus.h
+++ b/arch/sparc/include/asm/mbus.h
@@ -8,14 +8,10 @@
 #define _SPARC_MBUS_H
 
 #include <asm/ross.h>    /* HyperSparc stuff */
-#include <asm/cypress.h> /* Cypress Chips */
 #include <asm/viking.h>  /* Ugh, bug city... */
 
 enum mbus_module {
 	HyperSparc        = 0,
-	Cypress           = 1,
-	Cypress_vE        = 2,
-	Cypress_vD        = 3,
 	Swift_ok          = 4,
 	Swift_bad_c       = 5,
 	Swift_lots_o_bugs = 6,
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 9b2d43d..6c95e9f 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -746,21 +746,6 @@ sun4d_init:
 	/* Fall through to sun4m_init */
 
 sun4m_init:
-	/* XXX Fucking Cypress... */
-	lda	[%g0] ASI_M_MMUREGS, %g5
-	srl	%g5, 28, %g4
-
-	cmp	%g4, 1
-	bne	1f
-	 srl	%g5, 24, %g4
-
-	and	%g4, 0xf, %g4
-	cmp	%g4, 7		/* This would be a HyperSparc. */
-
-	bne	2f
-	 nop
-
-1:
 
 #define PATCH_IT(dst, src)	\
 	set	(dst), %g5;	\
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index a33009f..ae04914 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -23,14 +23,6 @@
 #include "kernel.h"
 #include "irq.h"
 
-#ifdef CONFIG_SMP
-#define SMP_NOP2 "nop; nop;\n\t"
-#define SMP_NOP3 "nop; nop; nop;\n\t"
-#else
-#define SMP_NOP2
-#define SMP_NOP3
-#endif /* SMP */
-
 /* platform specific irq setup */
 struct sparc_config sparc_config;
 
@@ -41,7 +33,6 @@ unsigned long arch_local_irq_save(void)
 
 	__asm__ __volatile__(
 		"rd	%%psr, %0\n\t"
-		SMP_NOP3	/* Sun4m + Cypress + SMP bug */
 		"or	%0, %2, %1\n\t"
 		"wr	%1, 0, %%psr\n\t"
 		"nop; nop; nop\n"
@@ -59,7 +50,6 @@ void arch_local_irq_enable(void)
 
 	__asm__ __volatile__(
 		"rd	%%psr, %0\n\t"
-		SMP_NOP3	/* Sun4m + Cypress + SMP bug */
 		"andn	%0, %1, %0\n\t"
 		"wr	%0, 0, %%psr\n\t"
 		"nop; nop; nop\n"
@@ -76,7 +66,6 @@ void arch_local_irq_restore(unsigned long old_psr)
 	__asm__ __volatile__(
 		"rd	%%psr, %0\n\t"
 		"and	%2, %1, %2\n\t"
-		SMP_NOP2	/* Sun4m + Cypress + SMP bug */
 		"andn	%0, %1, %0\n\t"
 		"wr	%0, %2, %%psr\n\t"
 		"nop; nop; nop\n"
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 765b1a5..4875fcd 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -577,244 +577,6 @@ void swift_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
  * with respect to cache coherency.
  */
 
-/* Cypress flushes. */
-static void cypress_flush_cache_all(void)
-{
-	volatile unsigned long cypress_sucks;
-	unsigned long faddr, tagval;
-
-	flush_user_windows();
-	for(faddr = 0; faddr < 0x10000; faddr += 0x20) {
-		__asm__ __volatile__("lda [%1 + %2] %3, %0\n\t" :
-				     "=r" (tagval) :
-				     "r" (faddr), "r" (0x40000),
-				     "i" (ASI_M_DATAC_TAG));
-
-		/* If modified and valid, kick it. */
-		if((tagval & 0x60) = 0x60)
-			cypress_sucks = *(unsigned long *)(0xf0020000 + faddr);
-	}
-}
-
-static void cypress_flush_cache_mm(struct mm_struct *mm)
-{
-	register unsigned long a, b, c, d, e, f, g;
-	unsigned long flags, faddr;
-	int octx;
-
-	FLUSH_BEGIN(mm)
-	flush_user_windows();
-	local_irq_save(flags);
-	octx = srmmu_get_context();
-	srmmu_set_context(mm->context);
-	a = 0x20; b = 0x40; c = 0x60;
-	d = 0x80; e = 0xa0; f = 0xc0; g = 0xe0;
-
-	faddr = (0x10000 - 0x100);
-	goto inside;
-	do {
-		faddr -= 0x100;
-	inside:
-		__asm__ __volatile__("sta %%g0, [%0] %1\n\t"
-				     "sta %%g0, [%0 + %2] %1\n\t"
-				     "sta %%g0, [%0 + %3] %1\n\t"
-				     "sta %%g0, [%0 + %4] %1\n\t"
-				     "sta %%g0, [%0 + %5] %1\n\t"
-				     "sta %%g0, [%0 + %6] %1\n\t"
-				     "sta %%g0, [%0 + %7] %1\n\t"
-				     "sta %%g0, [%0 + %8] %1\n\t" : :
-				     "r" (faddr), "i" (ASI_M_FLUSH_CTX),
-				     "r" (a), "r" (b), "r" (c), "r" (d),
-				     "r" (e), "r" (f), "r" (g));
-	} while(faddr);
-	srmmu_set_context(octx);
-	local_irq_restore(flags);
-	FLUSH_END
-}
-
-static void cypress_flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	register unsigned long a, b, c, d, e, f, g;
-	unsigned long flags, faddr;
-	int octx;
-
-	FLUSH_BEGIN(mm)
-	flush_user_windows();
-	local_irq_save(flags);
-	octx = srmmu_get_context();
-	srmmu_set_context(mm->context);
-	a = 0x20; b = 0x40; c = 0x60;
-	d = 0x80; e = 0xa0; f = 0xc0; g = 0xe0;
-
-	start &= SRMMU_REAL_PMD_MASK;
-	while(start < end) {
-		faddr = (start + (0x10000 - 0x100));
-		goto inside;
-		do {
-			faddr -= 0x100;
-		inside:
-			__asm__ __volatile__("sta %%g0, [%0] %1\n\t"
-					     "sta %%g0, [%0 + %2] %1\n\t"
-					     "sta %%g0, [%0 + %3] %1\n\t"
-					     "sta %%g0, [%0 + %4] %1\n\t"
-					     "sta %%g0, [%0 + %5] %1\n\t"
-					     "sta %%g0, [%0 + %6] %1\n\t"
-					     "sta %%g0, [%0 + %7] %1\n\t"
-					     "sta %%g0, [%0 + %8] %1\n\t" : :
-					     "r" (faddr),
-					     "i" (ASI_M_FLUSH_SEG),
-					     "r" (a), "r" (b), "r" (c), "r" (d),
-					     "r" (e), "r" (f), "r" (g));
-		} while (faddr != start);
-		start += SRMMU_REAL_PMD_SIZE;
-	}
-	srmmu_set_context(octx);
-	local_irq_restore(flags);
-	FLUSH_END
-}
-
-static void cypress_flush_cache_page(struct vm_area_struct *vma, unsigned long page)
-{
-	register unsigned long a, b, c, d, e, f, g;
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long flags, line;
-	int octx;
-
-	FLUSH_BEGIN(mm)
-	flush_user_windows();
-	local_irq_save(flags);
-	octx = srmmu_get_context();
-	srmmu_set_context(mm->context);
-	a = 0x20; b = 0x40; c = 0x60;
-	d = 0x80; e = 0xa0; f = 0xc0; g = 0xe0;
-
-	page &= PAGE_MASK;
-	line = (page + PAGE_SIZE) - 0x100;
-	goto inside;
-	do {
-		line -= 0x100;
-	inside:
-			__asm__ __volatile__("sta %%g0, [%0] %1\n\t"
-					     "sta %%g0, [%0 + %2] %1\n\t"
-					     "sta %%g0, [%0 + %3] %1\n\t"
-					     "sta %%g0, [%0 + %4] %1\n\t"
-					     "sta %%g0, [%0 + %5] %1\n\t"
-					     "sta %%g0, [%0 + %6] %1\n\t"
-					     "sta %%g0, [%0 + %7] %1\n\t"
-					     "sta %%g0, [%0 + %8] %1\n\t" : :
-					     "r" (line),
-					     "i" (ASI_M_FLUSH_PAGE),
-					     "r" (a), "r" (b), "r" (c), "r" (d),
-					     "r" (e), "r" (f), "r" (g));
-	} while(line != page);
-	srmmu_set_context(octx);
-	local_irq_restore(flags);
-	FLUSH_END
-}
-
-/* Cypress is copy-back, at least that is how we configure it. */
-static void cypress_flush_page_to_ram(unsigned long page)
-{
-	register unsigned long a, b, c, d, e, f, g;
-	unsigned long line;
-
-	a = 0x20; b = 0x40; c = 0x60; d = 0x80; e = 0xa0; f = 0xc0; g = 0xe0;
-	page &= PAGE_MASK;
-	line = (page + PAGE_SIZE) - 0x100;
-	goto inside;
-	do {
-		line -= 0x100;
-	inside:
-		__asm__ __volatile__("sta %%g0, [%0] %1\n\t"
-				     "sta %%g0, [%0 + %2] %1\n\t"
-				     "sta %%g0, [%0 + %3] %1\n\t"
-				     "sta %%g0, [%0 + %4] %1\n\t"
-				     "sta %%g0, [%0 + %5] %1\n\t"
-				     "sta %%g0, [%0 + %6] %1\n\t"
-				     "sta %%g0, [%0 + %7] %1\n\t"
-				     "sta %%g0, [%0 + %8] %1\n\t" : :
-				     "r" (line),
-				     "i" (ASI_M_FLUSH_PAGE),
-				     "r" (a), "r" (b), "r" (c), "r" (d),
-				     "r" (e), "r" (f), "r" (g));
-	} while(line != page);
-}
-
-/* Cypress is also IO cache coherent. */
-static void cypress_flush_page_for_dma(unsigned long page)
-{
-}
-
-/* Cypress has unified L2 VIPT, from which both instructions and data
- * are stored.  It does not have an onboard icache of any sort, therefore
- * no flush is necessary.
- */
-static void cypress_flush_sig_insns(struct mm_struct *mm, unsigned long insn_addr)
-{
-}
-
-static void cypress_flush_tlb_all(void)
-{
-	srmmu_flush_whole_tlb();
-}
-
-static void cypress_flush_tlb_mm(struct mm_struct *mm)
-{
-	FLUSH_BEGIN(mm)
-	__asm__ __volatile__(
-	"lda	[%0] %3, %%g5\n\t"
-	"sta	%2, [%0] %3\n\t"
-	"sta	%%g0, [%1] %4\n\t"
-	"sta	%%g5, [%0] %3\n"
-	: /* no outputs */
-	: "r" (SRMMU_CTX_REG), "r" (0x300), "r" (mm->context),
-	  "i" (ASI_M_MMUREGS), "i" (ASI_M_FLUSH_PROBE)
-	: "g5");
-	FLUSH_END
-}
-
-static void cypress_flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long size;
-
-	FLUSH_BEGIN(mm)
-	start &= SRMMU_PGDIR_MASK;
-	size = SRMMU_PGDIR_ALIGN(end) - start;
-	__asm__ __volatile__(
-		"lda	[%0] %5, %%g5\n\t"
-		"sta	%1, [%0] %5\n"
-		"1:\n\t"
-		"subcc	%3, %4, %3\n\t"
-		"bne	1b\n\t"
-		" sta	%%g0, [%2 + %3] %6\n\t"
-		"sta	%%g5, [%0] %5\n"
-	: /* no outputs */
-	: "r" (SRMMU_CTX_REG), "r" (mm->context), "r" (start | 0x200),
-	  "r" (size), "r" (SRMMU_PGDIR_SIZE), "i" (ASI_M_MMUREGS),
-	  "i" (ASI_M_FLUSH_PROBE)
-	: "g5", "cc");
-	FLUSH_END
-}
-
-static void cypress_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	FLUSH_BEGIN(mm)
-	__asm__ __volatile__(
-	"lda	[%0] %3, %%g5\n\t"
-	"sta	%1, [%0] %3\n\t"
-	"sta	%%g0, [%2] %4\n\t"
-	"sta	%%g5, [%0] %3\n"
-	: /* no outputs */
-	: "r" (SRMMU_CTX_REG), "r" (mm->context), "r" (page & PAGE_MASK),
-	  "i" (ASI_M_MMUREGS), "i" (ASI_M_FLUSH_PROBE)
-	: "g5");
-	FLUSH_END
-}
-
 /* viking.S */
 extern void viking_flush_cache_all(void);
 extern void viking_flush_cache_mm(struct mm_struct *mm);
@@ -1307,90 +1069,6 @@ static void __init init_hypersparc(void)
 	hypersparc_setup_blockops();
 }
 
-static void __cpuinit poke_cypress(void)
-{
-	unsigned long mreg = srmmu_get_mmureg();
-	unsigned long faddr, tagval;
-	volatile unsigned long cypress_sucks;
-	volatile unsigned long clear;
-
-	clear = srmmu_get_faddr();
-	clear = srmmu_get_fstatus();
-
-	if (!(mreg & CYPRESS_CENABLE)) {
-		for(faddr = 0x0; faddr < 0x10000; faddr += 20) {
-			__asm__ __volatile__("sta %%g0, [%0 + %1] %2\n\t"
-					     "sta %%g0, [%0] %2\n\t" : :
-					     "r" (faddr), "r" (0x40000),
-					     "i" (ASI_M_DATAC_TAG));
-		}
-	} else {
-		for(faddr = 0; faddr < 0x10000; faddr += 0x20) {
-			__asm__ __volatile__("lda [%1 + %2] %3, %0\n\t" :
-					     "=r" (tagval) :
-					     "r" (faddr), "r" (0x40000),
-					     "i" (ASI_M_DATAC_TAG));
-
-			/* If modified and valid, kick it. */
-			if((tagval & 0x60) = 0x60)
-				cypress_sucks = *(unsigned long *)
-							(0xf0020000 + faddr);
-		}
-	}
-
-	/* And one more, for our good neighbor, Mr. Broken Cypress. */
-	clear = srmmu_get_faddr();
-	clear = srmmu_get_fstatus();
-
-	mreg |= (CYPRESS_CENABLE | CYPRESS_CMODE);
-	srmmu_set_mmureg(mreg);
-}
-
-static const struct sparc32_cachetlb_ops cypress_ops = {
-	.cache_all	= cypress_flush_cache_all,
-	.cache_mm	= cypress_flush_cache_mm,
-	.cache_page	= cypress_flush_cache_page,
-	.cache_range	= cypress_flush_cache_range,
-	.tlb_all	= cypress_flush_tlb_all,
-	.tlb_mm		= cypress_flush_tlb_mm,
-	.tlb_page	= cypress_flush_tlb_page,
-	.tlb_range	= cypress_flush_tlb_range,
-	.page_to_ram	= cypress_flush_page_to_ram,
-	.sig_insns	= cypress_flush_sig_insns,
-	.page_for_dma	= cypress_flush_page_for_dma,
-};
-
-static void __init init_cypress_common(void)
-{
-	init_vac_layout();
-	sparc32_cachetlb_ops = &cypress_ops;
-	poke_srmmu = poke_cypress;
-}
-
-static void __init init_cypress_604(void)
-{
-	srmmu_name = "ROSS Cypress-604(UP)";
-	srmmu_modtype = Cypress;
-	init_cypress_common();
-}
-
-static void __init init_cypress_605(unsigned long mrev)
-{
-	srmmu_name = "ROSS Cypress-605(MP)";
-	if(mrev = 0xe) {
-		srmmu_modtype = Cypress_vE;
-		hwbug_bitmask |= HWBUG_COPYBACK_BROKEN;
-	} else {
-		if(mrev = 0xd) {
-			srmmu_modtype = Cypress_vD;
-			hwbug_bitmask |= HWBUG_ASIFLUSH_BROKEN;
-		} else {
-			srmmu_modtype = Cypress;
-		}
-	}
-	init_cypress_common();
-}
-
 static void __cpuinit poke_swift(void)
 {
 	unsigned long mreg;
@@ -1912,22 +1590,15 @@ static void __init get_srmmu_type(void)
 			break;
 		case 0:
 		case 2:
-			/* Uniprocessor Cypress */
-			init_cypress_604();
-			break;
 		case 10:
 		case 11:
 		case 12:
-			/* _REALLY OLD_ Cypress MP chips... */
 		case 13:
 		case 14:
 		case 15:
-			/* MP Cypress mmu/cache-controller */
-			init_cypress_605(mod_rev);
-			break;
 		default:
-			/* Some other Cypress revision, assume a 605. */
-			init_cypress_605(mod_rev);
+			prom_printf("Sparc-Linux Cypress support does not longer exit.\n");
+			prom_halt();
 			break;
 		}
 		return;
-- 
1.7.10

