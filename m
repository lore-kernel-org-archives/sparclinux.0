From: Chris Newport <crn@netunix.com>
Date: Wed, 18 Aug 2004 21:41:29 +0000
Subject: Repost - Sun4d patches.
Message-Id: <Pine.LNX.4.53.0408182237110.391@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Oops - the patches were truncated in my previous post
This should be complete.

====


<#0> ok cat mydiffs
diff -ru linux-2.4.27-orig/arch/sparc/kernel/sun4d_smp.c linux-2.4.27/arch/sparc/kernel/sun4d_smp.c
--- linux-2.4.27-orig/arch/sparc/kernel/sun4d_smp.c	2003-11-28 18:26:19.000000000 +0000
+++ linux-2.4.27/arch/sparc/kernel/sun4d_smp.c	2004-08-18 11:29:07.000000000 +0100
@@ -132,8 +132,7 @@

 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
-			     "sta %%g6, [%%g0] %1\n\t"
-			     : : "r" (&current_set[cpuid]), "i" (ASI_M_VIKING_TMP2)
+			     : : "r" (&current_set[cpuid])
 			     : "memory" /* paranoid */);

 	cpu_leds[cpuid] = 0x9;
@@ -494,25 +493,18 @@

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

diff -ru linux-2.4.27-orig/arch/sparc/mm/io-unit.c linux-2.4.27/arch/sparc/mm/io-unit.c
--- linux-2.4.27-orig/arch/sparc/mm/io-unit.c	2002-11-28 23:53:12.000000000 +0000
+++ linux-2.4.27/arch/sparc/mm/io-unit.c	2004-08-18 11:32:29.000000000 +0100
@@ -188,7 +188,7 @@
 			pte_t *ptep;
 			long i;

-			pgdp = pgd_offset(init_task.mm, addr);
+			pgdp = pgd_offset(&init_mm, addr);
 			pmdp = pmd_offset(pgdp, addr);
 			ptep = pte_offset(pmdp, addr);

diff -ru linux-2.4.27-orig/arch/sparc/prom/ranges.c linux-2.4.27/arch/sparc/prom/ranges.c
--- linux-2.4.27-orig/arch/sparc/prom/ranges.c	2002-02-25 19:37:56.000000000 +0000
+++ linux-2.4.27/arch/sparc/prom/ranges.c	2004-08-18 11:33:59.000000000 +0100
@@ -34,7 +34,7 @@
 	}
 }

-static void
+/* static */ void
 prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 		   struct linux_prom_ranges *ranges2, int nranges2)
 {
diff -ru linux-2.4.27-orig/drivers/sbus/sbus.c linux-2.4.27/drivers/sbus/sbus.c
--- linux-2.4.27-orig/drivers/sbus/sbus.c	2003-08-25 12:44:42.000000000 +0100
+++ linux-2.4.27/drivers/sbus/sbus.c	2004-08-18 11:35:46.000000000 +0100
@@ -215,6 +215,8 @@
  * prom_sbus_ranges_init(), with all sun4d stuff cut away.
  * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
  */
+/* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
+
 static void __init sbus_bus_ranges_init(int parent_node, struct sbus_bus *sbus)
 {
 	int len;
@@ -227,6 +229,18 @@
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
diff -ru linux-2.4.27-orig/include/asm-sparc/asi.h linux-2.4.27/include/asm-sparc/asi.h
--- linux-2.4.27-orig/include/asm-sparc/asi.h	1998-04-15 01:44:23.000000000 +0100
+++ linux-2.4.27/include/asm-sparc/asi.h	2004-08-18 11:37:14.000000000 +0100
@@ -104,7 +104,8 @@
 #define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */

 #define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
-#define ASI_M_VIKING_TMP2  0x41	  /* Emulation temporary 2 on Viking */
+/* only available on SuperSparc I */
+/* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */

 #define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */

diff -ru linux-2.4.27-orig/include/asm-sparc/winmacro.h linux-2.4.27/include/asm-sparc/winmacro.h
--- linux-2.4.27-orig/include/asm-sparc/winmacro.h	2003-06-13 15:51:38.000000000 +0100
+++ linux-2.4.27/include/asm-sparc/winmacro.h	2004-08-18 11:38:24.000000000 +0100
@@ -113,9 +113,12 @@
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

===== end patches

