From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 04:28:36 +0000
Subject: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041221042836.GZ771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Chris Newport and Thomas Bogendoerfer have been working to get the
sun4d port functional again. This patch updates 2.6.10-rc3 to a current
snapshot of their work. It does the following 3 things:

(1) add sun4d hook to sbus_bus_ranges_init()
(2) fix up pgd_offset() call in sun4d iommu code
(3) fix up sun4d's definition of current

Signed-off-by: Chris Newport <crn@netunix.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Acked-by: William Irwin <wli@holomorphy.com>

Index: sparc32-2.6.10-rc3/drivers/sbus/sbus.c
=================================--- sparc32-2.6.10-rc3.orig/drivers/sbus/sbus.c	2004-10-07 04:01:41.000000000 -0700
+++ sparc32-2.6.10-rc3/drivers/sbus/sbus.c	2004-12-20 19:25:00.395237946 -0800
@@ -217,6 +217,8 @@
  * prom_sbus_ranges_init(), with all sun4d stuff cut away.
  * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
  */
+/* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
+
 static void __init sbus_bus_ranges_init(int parent_node, struct sbus_bus *sbus)
 {
 	int len;
@@ -229,6 +231,18 @@
 		return;
 	}
 	sbus->num_sbus_ranges = len / sizeof(struct linux_prom_ranges);
+	if (sparc_cpu_model = sun4d) {
+		struct linux_prom_ranges iounit_ranges[PROMREG_MAX];
+		int num_iounit_ranges;
+
+	len = prom_getproperty(parent_node, "ranges",
+				(char *) iounit_ranges,
+				sizeof (iounit_ranges));
+		if (len != -1) {
+			num_iounit_ranges = (len/sizeof(struct linux_prom_ranges));
+			prom_adjust_ranges (sbus->sbus_ranges, sbus->num_sbus_ranges, iounit_ranges, num_iounit_ranges);
+		}
+	}
 }
 
 static void __init __apply_ranges_to_regs(struct linux_prom_ranges *ranges,
Index: sparc32-2.6.10-rc3/arch/sparc/mm/io-unit.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/mm/io-unit.c	2004-12-16 06:19:27.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/mm/io-unit.c	2004-12-20 19:25:00.388239010 -0800
@@ -196,7 +196,7 @@
 			pte_t *ptep;
 			long i;
 
-			pgdp = pgd_offset(init_task.mm, addr);
+			pgdp = pgd_offset(&init_mm, addr);
 			pmdp = pmd_offset(pgdp, addr);
 			ptep = pte_offset_map(pmdp, addr);
 
Index: sparc32-2.6.10-rc3/arch/sparc/kernel/sun4d_smp.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/kernel/sun4d_smp.c	2004-11-17 02:25:41.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/kernel/sun4d_smp.c	2004-12-20 19:25:00.385239466 -0800
@@ -122,8 +122,7 @@
 		
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
-			     "sta %%g6, [%%g0] %1\n\t"
-			     : : "r" (&current_set[cpuid]), "i" (ASI_M_VIKING_TMP2)
+			     : : "r" (&current_set[cpuid])
 			     : "memory" /* paranoid */);
 
 	cpu_leds[cpuid] = 0x9;
@@ -460,25 +459,18 @@
 
 void __init smp4d_blackbox_current(unsigned *addr)
 {
-	/* We have a nice Linux current register :) */
-	int rd = addr[1] & 0x3e000000;
+	int rd = *addr & 0x3e000000;
 	
-	addr[0] = 0x10800006;			/* b .+24 */
-	addr[1] = 0xc0800820 | rd;		/* lda [%g0] ASI_M_VIKING_TMP2, reg */
+	addr[0] = 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
+	addr[2] = 0x81282002 | rd | (rd >> 11);	/* sll reg, 2, reg */
+	addr[4] = 0x01000000;			/* nop */
 }
 
 void __init sun4d_init_smp(void)
 {
 	int i;
-	extern unsigned int patchme_store_new_current[];
 	extern unsigned int t_nmi[], linux_trap_ipi15_sun4d[], linux_trap_ipi15_sun4m[];
 
-	/* Store current into Linux current register :) */
-	__asm__ __volatile__("sta %%g6, [%%g0] %0" : : "i"(ASI_M_VIKING_TMP2));
-	
-	/* Patch switch_to */
-	patchme_store_new_current[0] = (patchme_store_new_current[0] & 0x3e000000) | 0xc0a00820;
-	
 	/* Patch ipi15 trap table */
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
 	
Index: sparc32-2.6.10-rc3/include/asm-sparc/winmacro.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/winmacro.h	2004-06-15 22:19:17.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/winmacro.h	2004-12-20 19:25:00.399237338 -0800
@@ -112,9 +112,12 @@
 	and      %idreg, 0xc, %idreg; \
 	ld       [%idreg + %dest_reg], %dest_reg;
 
-/* Sliiick. We have a Linux current register :) -jj */
-#define LOAD_CURRENT4D(dest_reg) \
-	lda	 [%g0] ASI_M_VIKING_TMP2, %dest_reg;
+#define LOAD_CURRENT4D(dest_reg, idreg) \
+	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg; \
+	sethi	%hi(C_LABEL(current_set)), %dest_reg; \
+	sll	%idreg, 2, %idreg; \
+	or	%dest_reg, %lo(C_LABEL(current_set)), %dest_reg; \
+	ld	[%idreg + %dest_reg], %dest_reg;
 
 /* Blackbox - take care with this... - check smp4m and smp4d before changing this. */
 #define LOAD_CURRENT(dest_reg, idreg) 					\
Index: sparc32-2.6.10-rc3/arch/sparc/prom/ranges.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/prom/ranges.c	2004-06-15 22:19:22.000000000 -0700
+++ sparc32-2.6.10-rc3/arch/sparc/prom/ranges.c	2004-12-20 19:25:00.391238554 -0800
@@ -34,7 +34,7 @@
 	}
 }
 
-static void
+/* static */ void
 prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 		   struct linux_prom_ranges *ranges2, int nranges2)
 {
Index: sparc32-2.6.10-rc3/include/asm-sparc/asi.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/asi.h	2004-06-15 22:19:22.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/asi.h	2004-12-20 19:25:00.397237642 -0800
@@ -104,7 +104,8 @@
 #define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */
 
 #define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
-#define ASI_M_VIKING_TMP2  0x41	  /* Emulation temporary 2 on Viking */
+/* only available on SuperSparc I */
+/* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */
 
 #define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
 
