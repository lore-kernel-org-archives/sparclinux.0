From: Stefan Holst <mail@s-holst.de>
Date: Sat, 03 Apr 2004 00:17:36 +0000
Subject: leon support - first proposal
Message-Id: <20040403001736.GA7330@spike>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hello!

thanks for merging my patches. just tested rc3 and it works
fine here :)

here is now a first proposal for actual leon support.
it has now a very low impact on existing code (mostly adding
some id's and a few branches for leon).

currently the kernel has to be explicitely configured
for leon architecture (like sun4). this has two reasons:

- gaisler research has received its official implementors
  id (0xf) quite recently and this id is still undefined in
  latest leon release

- there is an asi code which differs from srmmu and currently
  redefined in asi.h

actually there are some more nonstandard asi codes in leon
but these aren't used very often or not at all. ASI_M_MMUREGS
however seems to be used a lot and much code has to be added
to circumvent this redefinition.

if this asi.h change is a showstopper, however, i'll try to remove it.

what do you think anout this patch? are there any issues left
which need to be fixed?


diff -urN a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
--- a/drivers/sbus/sbus.c	2003-11-26 21:43:39.000000000 +0100
+++ b/drivers/sbus/sbus.c	2004-04-03 00:58:21.519621328 +0200
@@ -354,6 +354,8 @@
 		   (nd = prom_searchsiblings(nd, "sbi")) = 0) {
 		   	panic("sbi not found");
 		}
+	} else if(sparc_cpu_model = sparc_leon) {
+		return 0;
 	} else if((nd = prom_searchsiblings(topnd, "sbus")) = 0) {
 		if((iommund = prom_searchsiblings(topnd, "iommu")) = 0 ||
 		   (nd = prom_getchild(iommund)) = 0 ||
diff -urN a/include/asm-sparc/asi.h b/include/asm-sparc/asi.h
--- a/include/asm-sparc/asi.h	2003-11-26 21:43:51.000000000 +0100
+++ b/include/asm-sparc/asi.h	2004-04-03 01:06:44.762116840 +0200
@@ -108,4 +108,10 @@
 
 #define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
 
+/* FIXME: non-standard Leon ASI definition */
+#ifdef CONFIG_LEON
+#undef ASI_M_MMUREGS
+#define ASI_M_MMUREGS		0x19
+#endif /* CONFIG_LEON */
+
 #endif /* _SPARC_ASI_H */
diff -urN a/include/asm-sparc/machines.h b/include/asm-sparc/machines.h
--- a/include/asm-sparc/machines.h	2003-11-26 21:42:50.000000000 +0100
+++ b/include/asm-sparc/machines.h	2004-04-03 00:58:21.521621024 +0200
@@ -15,7 +15,7 @@
 /* Current number of machines we know about that has an IDPROM
  * machtype entry including one entry for the 0x80 OBP machines.
  */
-#define NUM_SUN_MACHINES   15
+#define NUM_SUN_MACHINES   16
 
 extern struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES];
 
@@ -32,6 +32,7 @@
 
 #define SM_ARCH_MASK  0xf0
 #define SM_SUN4       0x20
+#define  M_LEON2      0x30
 #define SM_SUN4C      0x50
 #define SM_SUN4M      0x70
 #define SM_SUN4M_OBP  0x80
@@ -43,6 +44,9 @@
 #define SM_4_330      0x03    /* Sun 4/300 series */
 #define SM_4_470      0x04    /* Sun 4/400 series */
 
+/* Leon machines */
+#define M_LEON2_SOC   0x01    /* Leon2 SoC */
+
 /* Sun4c machines                Full Name              - PROM NAME */
 #define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
 #define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
diff -urN a/include/asm-sparc/system.h b/include/asm-sparc/system.h
--- a/include/asm-sparc/system.h	2004-03-11 11:33:04.000000000 +0100
+++ b/include/asm-sparc/system.h	2004-04-03 00:58:21.521621024 +0200
@@ -29,6 +29,7 @@
   sun4u       = 0x05, /* V8 ploos ploos */
   sun_unknown = 0x06,
   ap1000      = 0x07, /* almost a sun4m */
+  sparc_leon  = 0x08, /* Leon2 SoC */
 };
 
 /* Really, userland should not be looking at any of this... */
diff -urN a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	2004-03-30 16:55:31.000000000 +0200
+++ b/arch/sparc/Kconfig	2004-04-03 00:58:21.511622544 +0200
@@ -226,6 +226,14 @@
 	  a kernel compiled with this option will run only on sun4.
 	  (And the current version will probably work only on sun4/330.)
 
+config LEON
+	bool "Running on SoC 'Leon', the open source sparc VHDL model"
+	help
+	  Say Y here if you want to run linux on the Leon System-on-a-Chip
+	  platform. For information go to www.gaisler.com. Download the VHDL 
+	  source and use the instruction level Leon sparc-simulator "tsim" which 
+	  is free for private use. 
+
 if !SUN4
 
 config PCI
diff -urN a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
--- a/arch/sparc/kernel/Makefile	2004-02-29 23:36:16.000000000 +0100
+++ b/arch/sparc/kernel/Makefile	2004-04-03 00:58:21.511622544 +0200
@@ -6,7 +6,7 @@
 
 EXTRA_AFLAGS	:= -ansi
 
-IRQ_OBJS := irq.o sun4m_irq.o sun4c_irq.o sun4d_irq.o
+IRQ_OBJS := irq.o sun4m_irq.o sun4c_irq.o sun4d_irq.o leon_irq.o
 obj-y    := entry.o wof.o wuf.o etrap.o rtrap.o traps.o $(IRQ_OBJS) \
 	    process.o signal.o ioport.o setup.o idprom.o \
 	    sys_sparc.o sunos_asm.o systbls.o \
diff -urN a/arch/sparc/kernel/auxio.c b/arch/sparc/kernel/auxio.c
--- a/arch/sparc/kernel/auxio.c	2003-11-26 21:44:52.000000000 +0100
+++ b/arch/sparc/kernel/auxio.c	2004-04-03 00:58:21.511622544 +0200
@@ -29,6 +29,7 @@
 	switch (sparc_cpu_model) {
 	case sun4d:
 	case sun4:
+	case sparc_leon:
 		return;
 	default:
 		break;
diff -urN a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
--- a/arch/sparc/kernel/cpu.c	2004-03-30 16:55:31.000000000 +0200
+++ b/arch/sparc/kernel/cpu.c	2004-04-03 01:03:39.863225744 +0200
@@ -73,6 +73,9 @@
   { 5, 6, "reserved"},
   { 5, 7, "No FPU"},
   { 9, 3, "Fujitsu or Weitek on-chip FPU"},
+  /* Leon */
+  { 0xf, 0, "Meiko FPU"},
+  { 0xf, 1, "GRFPU"},
 };
 
 #define NSPARCFPU  (sizeof(linux_sparc_fpu)/sizeof(struct cpu_fp_info))
@@ -117,7 +120,9 @@
   { 0xc, 0, "UNKNOWN CPU-VENDOR/TYPE"},
   { 0xd, 0, "UNKNOWN CPU-VENDOR/TYPE"},
   { 0xe, 0, "UNKNOWN CPU-VENDOR/TYPE"},
-  { 0xf, 0, "UNKNOWN CPU-VENDOR/TYPE"},
+  /* Leon */
+  { 0xf, 2, "Gaisler Research - Leon2 SoC"},
+  { 0xf, 3, "Gaisler Research - Leon3 SoC"},
 };
 
 #define NSPARCCHIPS  (sizeof(linux_sparc_chips)/sizeof(struct cpu_iu_info))
@@ -134,10 +139,14 @@
 
 	psr_impl = ((get_psr()>>28)&0xf);
 	psr_vers = ((get_psr()>>24)&0xf);
+#ifdef CONFIG_LEON
+	psr_impl = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+#endif
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
-	fpu_vers = ((get_fsr()>>17)&0x7);
+	fpu_vers = (get_psr() & PSR_EF) ? ((get_fsr()>>17)&0x7) : 7;
 	put_psr(psr);
 
 	for(i = 0; i<NSPARCCHIPS; i++) {
diff -urN a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
--- a/arch/sparc/kernel/head.S	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/kernel/head.S	2004-04-03 00:58:21.513622240 +0200
@@ -838,6 +838,8 @@
 
 		cmp	%l1, ' '
 		be	1f
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	1f
 		 cmp	%l1, 'c'
 		be	1f
 		 cmp	%l1, 'm'
@@ -860,6 +862,8 @@
 		be	sun4m_init
 		 cmp	%l1, 'd'		! Let us see how the beast will die
 		be	sun4d_init
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	sun4c_continue_boot
 		 nop
 
 		/* Jump into mmu context zero. */
diff -urN a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
--- a/arch/sparc/kernel/idprom.c	2003-11-26 21:43:25.000000000 +0100
+++ b/arch/sparc/kernel/idprom.c	2004-04-03 00:58:21.513622240 +0200
@@ -31,6 +31,8 @@
 { "Sun 4/200 Series", (SM_SUN4 | SM_4_260) },
 { "Sun 4/300 Series", (SM_SUN4 | SM_4_330) },
 { "Sun 4/400 Series", (SM_SUN4 | SM_4_470) },
+/* Now Leon */
+{ "Leon2 System-on-a-Chip", (M_LEON2 | M_LEON2_SOC) },
 /* Now, Sun4c's */
 { "Sun4c SparcStation 1", (SM_SUN4C | SM_4C_SS1) },
 { "Sun4c SparcStation IPC", (SM_SUN4C | SM_4C_IPC) },
diff -urN a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
--- a/arch/sparc/kernel/irq.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/kernel/irq.c	2004-04-03 00:58:21.514622088 +0200
@@ -579,6 +579,7 @@
 	extern void sun4c_init_IRQ( void );
 	extern void sun4m_init_IRQ( void );
 	extern void sun4d_init_IRQ( void );
+	extern void leon_init_IRQ(void);
 
 	switch(sparc_cpu_model) {
 	case sun4c:
@@ -586,6 +587,10 @@
 		sun4c_init_IRQ();
 		break;
 
+	case sparc_leon:
+		leon_init_IRQ();
+		break;
+
 	case sun4m:
 #ifdef CONFIG_PCI
 		pcic_probe();
diff -urN a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
--- a/arch/sparc/kernel/setup.c	2004-03-30 16:55:31.000000000 +0200
+++ b/arch/sparc/kernel/setup.c	2004-04-03 00:58:21.515621936 +0200
@@ -274,6 +274,7 @@
 	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=sun4d; }
 	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
 	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
+	if(!strcmp(&cputypval,"leon2")) { sparc_cpu_model=sparc_leon; }
 
 #ifdef CONFIG_SUN4
 	if (sparc_cpu_model != sun4) {
@@ -281,6 +282,13 @@
 		prom_halt();
 	}
 #endif
+#ifdef CONFIG_LEON
+	/* FIXME: psr ids, asi codes */
+	if (sparc_cpu_model != sparc_leon) {
+		prom_printf("This kernel is for Leon architecture only.\n");
+		prom_halt();
+	}
+#endif
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4:
@@ -301,6 +309,9 @@
 	case sun4u:
 		printk("SUN4U\n");
 		break;
+	case sparc_leon:
+		printk("LEON\n");
+		break;
 	default:
 		printk("UNKNOWN!\n");
 		break;
diff -urN a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
--- a/arch/sparc/kernel/time.c	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/kernel/time.c	2004-04-03 00:58:21.516621784 +0200
@@ -43,6 +43,7 @@
 #include <asm/sun4paddr.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
+#include <asm/leon.h>
 
 extern unsigned long wall_jiffies;
 
@@ -309,6 +310,9 @@
 	case sun4d:
 		node = prom_getchild(bootbus = prom_searchsiblings(prom_getchild(cpuunit = prom_searchsiblings(node, "cpu-unit")), "bootbus"));
 		break;
+	case sparc_leon:
+		node = 0;
+		return;
 	default:
 		prom_printf("CLOCK: Unsupported architecture!\n");
 		prom_halt();
@@ -393,6 +397,11 @@
 		clock_probe();
 
 	sparc_init_timers(timer_interrupt);
+
+	if (sparc_cpu_model = sparc_leon) {
+		local_irq_enable();
+		return;
+	}
 	
 #ifdef CONFIG_SUN4
 	if(idprom->id_machtype = (SM_SUN4 | SM_4_330)) {
@@ -469,6 +478,10 @@
 
 extern __inline__ unsigned long do_gettimeoffset(void)
 {
+	if (sparc_cpu_model = sparc_leon)
+		return ((LEON_REGLOAD_PA(LEON_TRLD0)&LEON_TCNT0_MASK) - 
+			(LEON_REGLOAD_PA(LEON_TCNT0)&LEON_TCNT0_MASK)) >> 2;
+
 	return (*master_l10_counter >> 10) & 0x1fffff;
 }
 
diff -urN a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
--- a/arch/sparc/mm/Makefile	2003-11-26 21:44:42.000000000 +0100
+++ b/arch/sparc/mm/Makefile	2004-04-03 00:58:21.516621784 +0200
@@ -21,3 +21,7 @@
 else
 obj-y   += sun4c.o
 endif
+
+ifdef CONFIG_LEON
+obj-y   += leon.o
+endif
diff -urN a/arch/sparc/mm/init.c b/arch/sparc/mm/init.c
--- a/arch/sparc/mm/init.c	2004-03-30 16:55:31.000000000 +0200
+++ b/arch/sparc/mm/init.c	2004-04-03 00:58:21.516621784 +0200
@@ -32,6 +32,7 @@
 #include <asm/vaddrs.h>
 #include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
 #include <asm/tlb.h>
+#include <asm/leon.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -324,6 +325,7 @@
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		srmmu_paging_init();
 		sparc_unmapped_base = 0x50000000;
 		BTFIXUPSET_SETHI(sparc_unmapped_base, 0x50000000);
diff -urN a/arch/sparc/mm/loadmmu.c b/arch/sparc/mm/loadmmu.c
--- a/arch/sparc/mm/loadmmu.c	2003-11-26 21:44:31.000000000 +0100
+++ b/arch/sparc/mm/loadmmu.c	2004-04-03 00:58:21.517621632 +0200
@@ -36,6 +36,7 @@
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		ld_mmu_srmmu();
 		break;
 	default:
diff -urN a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
--- a/arch/sparc/mm/srmmu.c	2004-04-01 16:08:16.000000000 +0200
+++ b/arch/sparc/mm/srmmu.c	2004-04-03 01:00:25.442782144 +0200
@@ -48,6 +48,7 @@
 #include <asm/tsunami.h>
 #include <asm/swift.h>
 #include <asm/turbosparc.h>
+#include <asm/leon.h>
 
 #include <asm/btfixup.h>
 
@@ -1269,7 +1270,11 @@
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
-        srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	if (sparc_cpu_model = sparc_leon) {
+        	leon_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	} else {
+        	srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	}
 	map_kernel();
 
 	/* ctx table has to be physically aligned to its size */
@@ -1966,6 +1971,123 @@
 	poke_srmmu = poke_viking;
 }
 
+void __init leon_inherit_prom_mappings(unsigned long start,unsigned long end)
+{
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	int what = 0; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
+	unsigned long prompte;
+
+	while(start <= end) {
+		if (start = 0)
+			break; /* probably wrap around */
+		if(start = 0xfef00000)
+			start = KADB_DEBUGGER_BEGVM;
+		if(!(prompte = srmmu_swprobe(start,0))) {
+			start += PAGE_SIZE;
+			continue;
+		}
+    
+		/* A red snapper, see what it really is. */
+		what = 0;
+    
+		if(!(start & ~(SRMMU_PMD_MASK))) {
+			if(srmmu_swprobe((start-PAGE_SIZE) + SRMMU_PMD_SIZE, 0) = prompte)
+				what = 1;
+		}
+    
+		if(!(start & ~(SRMMU_PGDIR_MASK))) {
+			if(srmmu_swprobe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE, 0) =
+			   prompte)
+				what = 2;
+		}
+    
+		pgdp = pgd_offset_k(start);
+		if(what = 2) {
+			*(pgd_t *)__nocache_fix(pgdp) = __pgd(prompte);
+			start += SRMMU_PGDIR_SIZE;
+			continue;
+		}
+		if(srmmu_pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
+			if (pmdp = NULL)
+				early_pgtable_allocfail("pmd");
+			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
+			srmmu_pgd_set(__nocache_fix(pgdp), pmdp);
+		}
+		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
+		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+			ptep = (pte_t *) __srmmu_get_nocache(SRMMU_PTE_SZ_SOFT,
+			    SRMMU_PTE_SZ_SOFT);
+			if (ptep = NULL)
+				early_pgtable_allocfail("pte");
+			memset(__nocache_fix(ptep), 0, SRMMU_PTE_SZ_SOFT);
+			srmmu_pmd_set(__nocache_fix(pmdp), ptep);
+		}
+		if(what = 1) {
+			/*
+			 * We bend the rule where all 16 PTPs in a pmd_t point
+			 * inside the same PTE page, and we leak a perfectly
+			 * good hardware PTE piece. Alternatives seem worse.
+			 */
+			unsigned int x;	/* Index of HW PMD in soft cluster */
+			x = (start >> SRMMU_PMD_SHIFT) & 15;
+			*(unsigned long *)__nocache_fix(&pmdp->pmdv[x]) = prompte;
+			start += SRMMU_PMD_SIZE;
+			continue;
+		}
+		ptep = srmmu_pte_offset(__nocache_fix(pmdp), start);
+		*(pte_t *)__nocache_fix(ptep) = __pte(prompte);
+		start += PAGE_SIZE;
+	}
+}
+
+void leon_flush_cache_all (void)
+{ 
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t": :
+			     "i" (ASI_LEON_IFLUSH) : "memory");
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t": :
+			     "i" (ASI_LEON_DFLUSH) : "memory");
+}
+
+void leon_flush_tlb_all (void)
+{
+	leon_flush_cache_all();
+	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
+			     "r" (0x400),
+			     "i" (ASI_LEON_MMUFLUSH) : "memory");
+}
+
+static void __init poke_leonsparc(void)
+{
+}
+
+static void __init init_leon(void) {
+
+	srmmu_name = "Leon2";
+
+	BTFIXUPSET_CALL(flush_cache_all, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_mm, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_page, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_range, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_page_for_dma, leon_flush_cache_all, BTFIXUPCALL_NORM);
+  
+	BTFIXUPSET_CALL(flush_tlb_all, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_mm, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_page, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_range, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+  
+	BTFIXUPSET_CALL(__flush_page_to_ram, leon_flush_cache_all, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(flush_sig_insns, leon_flush_cache_all, BTFIXUPCALL_NOP);
+	
+	poke_srmmu = poke_leonsparc;
+	
+	srmmu_cache_pagetables = 0;
+}
+
+
+
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
@@ -1975,11 +2097,20 @@
 	srmmu_modtype = SRMMU_INVAL_MOD;
 	hwbug_bitmask = 0;
 
-	mreg = srmmu_get_mmureg(); psr = get_psr();
-	mod_typ = (mreg & 0xf0000000) >> 28;
-	mod_rev = (mreg & 0x0f000000) >> 24;
+	psr = get_psr();
 	psr_typ = (psr >> 28) & 0xf;
 	psr_vers = (psr >> 24) & 0xf;
+#ifdef CONFIG_LEON
+	psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+#endif
+	if(psr_typ = 0xf) {
+		init_leon();
+		return;
+	}
+	mreg = srmmu_get_mmureg();
+	mod_typ = (mreg & 0xf0000000) >> 28;
+	mod_rev = (mreg & 0x0f000000) >> 24;
 
 	/* First, check for HyperSparc or Cypress. */
 	if(mod_typ = 1) {
diff -urN a/include/asm-sparc/leon.h b/include/asm-sparc/leon.h
--- a/include/asm-sparc/leon.h	1970-01-01 01:00:00.000000000 +0100
+++ b/include/asm-sparc/leon.h	2004-04-03 00:58:21.520621176 +0200
@@ -0,0 +1,217 @@
+/* Konrad Eisele<eiselekd@web.de>, 2003: include/asm/leon.h */
+
+#ifndef LEON_H_INCLUDE
+#define LEON_H_INCLUDE
+
+#include <linux/config.h>
+#include <asm/vaddrs.h>
+
+/* memory mapped leon control registers */
+#define LEON_PREGS	0x80000000
+#define LEON_MCFG1	0x00
+#define LEON_MCFG2	0x04
+#define LEON_ECTRL	0x08
+#define LEON_FADDR	0x0c
+#define LEON_MSTAT	0x10
+#define LEON_CCTRL	0x14
+#define LEON_PWDOWN	0x18
+#define LEON_WPROT1	0x1C
+#define LEON_WPROT2	0x20
+#define LEON_LCONF	0x24
+#define LEON_TCNT0	0x40
+#define LEON_TRLD0	0x44
+#define LEON_TCTRL0	0x48
+#define LEON_TCNT1	0x50
+#define LEON_TRLD1	0x54
+#define LEON_TCTRL1	0x58
+#define LEON_SCNT	0x60
+#define LEON_SRLD	0x64
+#define LEON_UART0	0x70
+#define LEON_UDATA0	0x70
+#define LEON_USTAT0	0x74
+#define LEON_UCTRL0	0x78
+#define LEON_USCAL0	0x7c
+#define LEON_UART1	0x80
+#define LEON_UDATA1	0x80
+#define LEON_USTAT1	0x84
+#define LEON_UCTRL1	0x88
+#define LEON_USCAL1	0x8c
+#define LEON_IMASK	0x90
+#define LEON_IPEND	0x94
+#define LEON_IFORCE	0x98
+#define LEON_ICLEAR	0x9c
+#define LEON_IOREG	0xA0
+#define LEON_IODIR	0xA4
+#define LEON_IOICONF	0xA8
+#define LEON_IPEND2	0xB0
+#define LEON_IMASK2	0xB4
+#define LEON_ISTAT2	0xB8
+#define LEON_ICLEAR2	0xBC
+
+/* ASI codes */
+#define ASI_LEON_PCI		0x04
+#define ASI_LEON_IFLUSH		0x05
+#define ASI_LEON_DFLUSH		0x06
+#define ASI_LEON_ITAG		0x0c
+#define ASI_LEON_IDATA		0x0d
+#define ASI_LEON_DTAG		0x0e
+#define ASI_LEON_DDATA		0x0f
+#define ASI_LEON_MMUFLUSH	0x18
+#define ASI_LEON_MMUREGS	0x19
+#define ASI_LEON_BYPASS		0x1c
+#define ASI_LEON_FLUSH_PAGE	0x10
+/*
+#define ASI_LEON_FLUSH_SEGMENT	0x11
+#define ASI_LEON_FLUSH_REGION	0x12
+*/
+#define ASI_LEON_FLUSH_CTX	0x13
+#define ASI_LEON_DCTX		0x14
+#define ASI_LEON_ICTX		0x15
+#define ASI_MMU_DIAG		0x1d
+
+/* mmu register access, ASI_LEON_MMUREGS */
+#define LEON_CNR_CTRL		0x000
+#define LEON_CNR_CTXP		0x100
+#define LEON_CNR_CTX		0x200
+#define LEON_CNR_F		0x300
+#define LEON_CNR_FADDR		0x400
+
+#define LEON_CNR_CTX_NCTX	256	/*number of MMU ctx*/
+
+#define LEON_CNR_CTRL_TLBDIS	0x80000000
+
+#define LEON_MMUTLB_ENT_MAX	64
+
+/*
+ * diagnostic access from mmutlb.vhd:
+ * 0: pte address
+ * 4: pte
+ * 8: additional flags
+ */
+#define LEON_DIAGF_LVL		0x3
+#define LEON_DIAGF_WR		0x8
+#define LEON_DIAGF_WR_SHIFT	3
+#define LEON_DIAGF_HIT		0x10
+#define LEON_DIAGF_HIT_SHIFT	4
+#define LEON_DIAGF_CTX		0x1fe0
+#define LEON_DIAGF_CTX_SHIFT	5
+#define LEON_DIAGF_VALID	0x2000
+#define LEON_DIAGF_VALID_SHIFT	13
+
+
+/*
+ *  Interrupt Sources
+ *
+ *  The interrupt source numbers directly map to the trap type and to 
+ *  the bits used in the Interrupt Clear, Interrupt Force, Interrupt Mask,
+ *  and the Interrupt Pending Registers.
+ */
+#define LEON_INTERRUPT_CORRECTABLE_MEMORY_ERROR	1
+#define LEON_INTERRUPT_UART_1_RX_TX		2
+#define LEON_INTERRUPT_UART_0_RX_TX		3
+#define LEON_INTERRUPT_EXTERNAL_0		4
+#define LEON_INTERRUPT_EXTERNAL_1		5
+#define LEON_INTERRUPT_EXTERNAL_2		6
+#define LEON_INTERRUPT_EXTERNAL_3		7
+#define LEON_INTERRUPT_TIMER1			8
+#define LEON_INTERRUPT_TIMER2			9
+#define LEON_INTERRUPT_EMPTY1			10
+#define LEON_INTERRUPT_EMPTY2			11
+#define LEON_INTERRUPT_OPEN_ETH			12
+#define LEON_INTERRUPT_EMPTY4			13
+#define LEON_INTERRUPT_EMPTY5			14
+#define LEON_INTERRUPT_EMPTY6			15
+
+/* irq masks */
+#define LEON_HARD_INT(x)	(1 << (x)) /* irq 0-15 */
+#define LEON_IRQMASK_R		0x0000fffe /* bit 15- 1 of lregs.irqmask */
+#define LEON_IRQPRIO_R		0xfffe0000 /* bit 31-17 of lregs.irqmask */
+
+/* leon uart register definitions */
+#define LEON_OFF_UDATA	0x0
+#define LEON_OFF_USTAT	0x4
+#define LEON_OFF_UCTRL	0x8
+#define LEON_OFF_USCAL	0xc
+
+#define LEON_UCTRL_RE	0x01
+#define LEON_UCTRL_TE	0x02
+#define LEON_UCTRL_RI	0x04
+#define LEON_UCTRL_TI	0x08
+#define LEON_UCTRL_PS	0x10
+#define LEON_UCTRL_PE	0x20
+#define LEON_UCTRL_FL	0x40
+#define LEON_UCTRL_LB	0x80
+
+#define LEON_USTAT_DR	0x01
+#define LEON_USTAT_TS	0x02
+#define LEON_USTAT_TH	0x04
+#define LEON_USTAT_BR	0x08
+#define LEON_USTAT_OV	0x10
+#define LEON_USTAT_PE	0x20
+#define LEON_USTAT_FE	0x40
+
+#define LEON_MCFG2_SRAMDIS		0x00002000
+#define LEON_MCFG2_SDRAMEN		0x00004000
+#define LEON_MCFG2_SRAMBANKSZ		0x00001e00	/* [12-9] */
+#define LEON_MCFG2_SRAMBANKSZ_SHIFT	9
+#define LEON_MCFG2_SDRAMBANKSZ		0x03800000	/* [25-23] */
+#define LEON_MCFG2_SDRAMBANKSZ_SHIFT	23
+
+#define LEON_TCNT0_MASK	0x7fffff
+
+#define LEON_USTAT_ERROR (LEON_USTAT_OV|LEON_USTAT_PE|LEON_USTAT_FE) /*no break yet*/
+
+#ifdef CONFIG_OPEN_ETH
+#define LEON_ETH_BASE_ADD ((unsigned long)LEON_VA_ETHERMAC)
+/* map leon on ethermac adress space at pa 0xb0000000 */
+#define LEON_VA_ETHERMAC     DVMA_VADDR 
+#endif
+
+#ifndef __ASSEMBLY__
+ 
+/* do a physical address bypass write, i.e. for 0x80000000 */
+static __inline__ void leon_store_reg(unsigned long paddr,unsigned long value)
+{
+	__asm__ __volatile__("sta %0, [%1] %2\n\t": :
+			     "r" (value), "r" (paddr),
+			     "i" (ASI_LEON_BYPASS) : "memory");
+}
+
+/* do a physical address bypass load, i.e. for 0x80000000 */
+static __inline__ unsigned long leon_load_reg(unsigned long paddr)
+{
+	unsigned long retval;
+	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
+			     "=r" (retval) :
+			     "r" (paddr), "i" (ASI_LEON_BYPASS));
+	return retval;
+}
+
+extern __inline__ void leon_srmmu_disabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r" (retval) : "r" (0), "i" (ASI_LEON_MMUREGS));
+	retval |= LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r" (retval), "r" (0), "i" (ASI_LEON_MMUREGS) : "memory");
+}
+
+extern __inline__ void leon_srmmu_enabletlb(void)
+{
+	unsigned int retval;
+	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r" (retval) : "r" (0), "i" (ASI_LEON_MMUREGS));
+	retval = retval & ~LEON_CNR_CTRL_TLBDIS;
+	__asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r" (retval), "r" (0), "i" (ASI_LEON_MMUREGS) : "memory");
+}
+
+#define LEON_BYPASS_LOAD_PA(x)		leon_load_reg ((unsigned long)(x))
+#define LEON_BYPASS_STORE_PA(x,v)	leon_store_reg((unsigned long)(x),(unsigned long)(v))
+#define LEON_REGLOAD_PA(x)		leon_load_reg ((unsigned long)(x)+LEON_PREGS)
+#define LEON_REGSTORE_PA(x,v)		leon_store_reg((unsigned long)(x)+LEON_PREGS,(unsigned long)(v))
+#define LEON_REGSTORE_OR_PA(x,v)	LEON_REGSTORE_PA(x,LEON_REGLOAD_PA(x)|(unsigned long)(v))
+#define LEON_REGSTORE_AND_PA(x,v)	LEON_REGSTORE_PA(x,LEON_REGLOAD_PA(x)&(unsigned long)(v))
+
+extern unsigned long srmmu_swprobe(unsigned long vaddr,unsigned long *paddr);
+extern void leon_inherit_prom_mappings(unsigned long start,unsigned long end);
+
+#endif /* !ASM */
+#endif
diff -urN a/arch/sparc/kernel/leon_irq.c b/arch/sparc/kernel/leon_irq.c
--- a/arch/sparc/kernel/leon_irq.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/sparc/kernel/leon_irq.c	2004-04-03 00:58:21.514622088 +0200
@@ -0,0 +1,164 @@
+/* Konrad Eisele <eiselekd@web.de>, 2003: arch/sparc/leon/kernel/irq.c */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/pgtsrmmu.h>
+#include <asm/leon.h>
+#include <asm/sbus.h> /* for struct sbus_bus, warning suppress */
+#include <asm/timer.h>
+
+/* scaled down to timer to 1Mhz, used in sparc/kernel/leon_irq.c */
+#define CLOCK_TIMER_SCALAR 25
+
+static inline unsigned long get_irqmask(unsigned int irq)
+{
+	unsigned long mask;
+	if (!irq || irq > 0xf) {
+		printk("leon_get_irqmask: false irq number\n");
+		mask = 0;
+	} else {
+		mask = LEON_HARD_INT(irq);
+	}
+	return mask;
+}
+
+void leon_disable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr) & LEON_IRQMASK_R;
+	save_and_cli(flags);
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) & ~(mask));
+	restore_flags(flags);
+}
+
+void leon_enable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr) & LEON_IRQMASK_R;
+	save_and_cli(flags);
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) | (mask));
+	restore_flags(flags);
+}
+
+/* We assume the caller is local cli()'d when these are called, or else
+ * very bizarre behavior will result. */
+void leon_disable_pil_irq(unsigned int pil)
+{
+	unsigned long mask = get_irqmask(pil);
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) & ~(mask));
+}
+
+void leon_enable_pil_irq(unsigned int pil)
+{
+	unsigned long mask = get_irqmask(pil);
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) | (mask));
+}
+
+int leondebug_irq_disable;
+int leon_debug_irqout;
+static int dummy_master_l10_counter;
+static int dummy_master_l10_limit;
+
+/* called by time_init():timer.c */
+void __init leon_init_timers (irqreturn_t (*counter_fn)(int, void *, struct pt_regs *))
+{
+	int irq;
+
+	leondebug_irq_disable = 0;
+	leon_debug_irqout = 0;
+
+	LEON_REGSTORE_PA(LEON_TCTRL0, 0);
+	LEON_REGSTORE_PA(LEON_TCNT0, 0);
+	LEON_REGSTORE_PA(LEON_TRLD0, (((1000000/HZ) - 1)));
+
+	printk("Todo: init master_l10_counter\r\n");
+	master_l10_counter = &dummy_master_l10_counter;
+	master_l10_limit = &dummy_master_l10_limit;
+	dummy_master_l10_counter = 0;
+	dummy_master_l10_limit = 0;
+	
+	irq = request_irq(LEON_INTERRUPT_TIMER1,
+			  counter_fn,
+			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  "timer", NULL);
+	if (irq) {
+		printk("leon_time_init: unable to attach IRQ%d\n",LEON_INTERRUPT_TIMER1);
+		prom_halt();
+	}	
+
+	/* enable, load reload into counter, set automatic reload */
+	LEON_REGSTORE_PA(LEON_TCTRL0, 0x7);
+}
+
+void leon_clear_clock_irq(void)
+{
+}
+
+void leon_clear_profile_irq(int cpu)
+{
+	BUG();
+}
+
+void leon_load_profile_irq(int cpu, unsigned int limit)
+{
+	BUG();
+}
+
+unsigned int leon_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint)
+{
+	BUG();
+	return 0;
+}
+
+static char *leon_irq_itoa(unsigned int irq)
+{
+	static char buff[16];
+	sprintf(buff, "%d", irq);
+	return buff;
+}
+
+#ifdef CONFIG_SMP
+static void leon_set_cpu_int(int cpu, int level)
+{
+	printk("Not implemented\n");
+	BUG();
+}
+
+static void leon_clear_ipi(int cpu, int level)
+{
+}
+
+static void leon_set_udt(int cpu)
+{
+}
+#endif
+
+void __init leon_init_IRQ(void)
+{
+	sparc_init_timers = leon_init_timers;
+
+	BTFIXUPSET_CALL(sbint_to_irq, leon_sbint_to_irq, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(enable_pil_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_pil_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(clear_profile_irq, leon_clear_profile_irq, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(__irq_itoa, leon_irq_itoa, BTFIXUPCALL_NORM);
+
+#ifdef CONFIG_SMP
+	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(set_irq_udt, leon_set_udt, BTFIXUPCALL_NOP);
+#endif
+
+}
diff -urN a/arch/sparc/mm/leon.c b/arch/sparc/mm/leon.c
--- a/arch/sparc/mm/leon.c	1970-01-01 01:00:00.000000000 +0100
+++ b/arch/sparc/mm/leon.c	2004-04-03 00:58:21.517621632 +0200
@@ -0,0 +1,99 @@
+/* Konrad Eisele <eiselekd@web.de>, 2003: arch/sparc/leon/mm/leon.c */
+ 
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+
+#define PFN(x) ((x) >> PAGE_SHIFT)
+extern unsigned long last_valid_pfn;
+
+/* max_mapnr not initialized yet */
+#define _pfn_valid(pfn)	((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+
+unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr) {
+      
+	unsigned long ctxtbl;
+	unsigned long pgd,pmd,ped;
+	unsigned long ptr;
+	unsigned long lvl, pte, paddrbase;
+	unsigned long ctx;
+	
+	paddrbase = 0;
+	
+	if (!(ctxtbl = srmmu_get_ctable_ptr()))
+		return 0;
+	if (!_pfn_valid(PFN(ctxtbl)))
+		return 0;
+
+	ctx = srmmu_get_context();
+
+	pgd = LEON_BYPASS_LOAD_PA(ctxtbl+(ctx*4));
+	
+	if (((pgd&SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		lvl = 3;
+		pte = pgd;
+		paddrbase = pgd & SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	if (((pgd&SRMMU_ET_MASK) != SRMMU_ET_PTD))
+		return 0;
+	
+	ptr = (pgd & SRMMU_PTD_PMASK) << 4;  
+	ptr += (((vaddr & 0xff000000)>>24)*4);
+	if (!_pfn_valid(PFN(ptr)))
+		return 0;
+	
+	pmd = LEON_BYPASS_LOAD_PA(ptr);
+	if (((pmd&SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		lvl = 2;    
+		pte = pmd;
+		paddrbase = pmd & SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	if (((pmd&SRMMU_ET_MASK) != SRMMU_ET_PTD))
+		return 0;
+	
+	ptr = (pmd & SRMMU_PTD_PMASK) << 4;  
+	ptr += (((vaddr & 0x00fc0000)>>18)*4);
+	if (!_pfn_valid(PFN(ptr)))
+		return 0;
+	
+	ped = LEON_BYPASS_LOAD_PA(ptr);
+	if (((ped&SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		lvl = 1;    
+		pte = ped;
+		paddrbase = ped & SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	if (((ped&SRMMU_ET_MASK) != SRMMU_ET_PTD))
+		return 0;
+	
+	ptr = (ped & SRMMU_PTD_PMASK) << 4;  
+	ptr += (((vaddr & 0x0003f000)>>12)*4);
+	if (!_pfn_valid(PFN(ptr)))
+		return 0;
+	
+	ptr = LEON_BYPASS_LOAD_PA(ptr);
+	if (((ptr&SRMMU_ET_MASK) = SRMMU_ET_PTE)) {
+		lvl = 0;
+		pte = ptr;
+		paddrbase = ptr & SRMMU_PTE_PMASK;
+		goto ready;
+	}
+	return 0;      
+
+ready:
+	if (paddr) {
+		switch (lvl) {
+			case 0: *paddr = (vaddr & 0x00000fff) | ((pte&~0xff)<<4); break;
+			case 1: *paddr = (vaddr & 0x0003ffff) | ((pte&~0xff)<<4); break;
+			case 2: *paddr = (vaddr & 0x00ffffff) | ((pte&~0xff)<<4); break;
+			default:
+			case 3: *paddr =  vaddr; break;
+		}
+	}
+	return paddrbase;
+}
+
+


-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
