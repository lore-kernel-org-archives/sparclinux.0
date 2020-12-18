From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:46 +0000
Subject: [PATCH v1 12/13] sparc32: drop check for sparc_model
Message-Id: <20201218184347.2180772-13-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

sparc32 is always LEON, so no need to check for the model.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/cpu_type.h   | 18 -------
 arch/sparc/include/asm/io_32.h      |  4 +-
 arch/sparc/include/asm/pgtable_32.h | 24 ---------
 arch/sparc/kernel/devices.c         |  7 +--
 arch/sparc/kernel/ioport.c          |  6 +--
 arch/sparc/kernel/leon_pmc.c        | 14 +++--
 arch/sparc/kernel/setup_32.c        | 79 +----------------------------
 7 files changed, 12 insertions(+), 140 deletions(-)

diff --git a/arch/sparc/include/asm/cpu_type.h b/arch/sparc/include/asm/cpu_type.h
index 2b59799859d1..3e0154c3f41d 100644
--- a/arch/sparc/include/asm/cpu_type.h
+++ b/arch/sparc/include/asm/cpu_type.h
@@ -2,28 +2,10 @@
 #ifndef __ASM_CPU_TYPE_H
 #define __ASM_CPU_TYPE_H
 
-/*
- * Sparc (general) CPU types
- */
-enum sparc_cpu {
-  sun4m       = 0x00,
-  sun4d       = 0x01,
-  sun4e       = 0x02,
-  sun4u       = 0x03, /* V8 ploos ploos */
-  sun_unknown = 0x04,
-  ap1000      = 0x05, /* almost a sun4m */
-  sparc_leon  = 0x06, /* Leon SoC */
-};
-
 #ifdef CONFIG_SPARC32
-extern enum sparc_cpu sparc_cpu_model;
 
 #define SUN4M_NCPUS            4              /* Architectural limit of sun4m. */
 
-#else
-
-#define sparc_cpu_model sun4u
-
 #endif
 
 #endif /* __ASM_CPU_TYPE_H */
diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 549f0a72280d..83abe709d120 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -138,11 +138,11 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
 static inline int sbus_can_dma_64bit(void)
 {
-	return 0; /* actually, sparc_cpu_model=sun4d */
+	return 0;
 }
 static inline int sbus_can_burst64(void)
 {
-	return 0; /* actually, sparc_cpu_model=sun4d */
+	return 0;
 }
 struct device;
 void sbus_set_sbus64(struct device *, int);
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 632cdb959542..9c4da6ed81ef 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -356,30 +356,6 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-static inline unsigned long
-__get_phys (unsigned long addr)
-{
-	switch (sparc_cpu_model){
-	case sun4m:
-	case sun4d:
-		return ((srmmu_get_pte (addr) & 0xffffff00) << 4);
-	default:
-		return 0;
-	}
-}
-
-static inline int
-__get_iospace (unsigned long addr)
-{
-	switch (sparc_cpu_model){
-	case sun4m:
-	case sun4d:
-		return (srmmu_get_pte (addr) >> 28);
-	default:
-		return -1;
-	}
-}
-
 extern unsigned long *sparc_valid_addr_bitmap;
 
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index b3c2d51b22c4..2963e89611a3 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -26,8 +26,6 @@
 
 static char *cpu_mid_prop(void)
 {
-	if (sparc_cpu_model = sun4d)
-		return "cpu-id";
 	return "mid";
 }
 
@@ -40,8 +38,6 @@ static int check_cpu_node(phandle nd, int *cur_inst,
 			*prom_node = nd;
 		if (mid) {
 			*mid = prom_getintdefault(nd, cpu_mid_prop(), 0);
-			if (sparc_cpu_model = sun4m)
-				*mid &= 3;
 		}
 		return 0;
 	}
@@ -92,8 +88,7 @@ static int cpu_mid_compare(phandle nd, int instance, void *_arg)
 	int this_mid;
 
 	this_mid = prom_getintdefault(nd, cpu_mid_prop(), 0);
-	if (this_mid = desired_mid
-	    || (sparc_cpu_model = sun4m && (this_mid & 3) = desired_mid))
+	if (this_mid = desired_mid)
 		return 0;
 	return -ENODEV;
 }
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 8e1d72a16759..50fb0a8431aa 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -57,10 +57,8 @@
  */
 static inline void dma_make_coherent(unsigned long pa, unsigned long len)
 {
-	if (sparc_cpu_model = sparc_leon) {
-		if (!sparc_leon3_snooping_enabled())
-			leon_flush_dcache_all();
-	}
+	if (!sparc_leon3_snooping_enabled())
+		leon_flush_dcache_all();
 }
 
 static void __iomem *_sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz);
diff --git a/arch/sparc/kernel/leon_pmc.c b/arch/sparc/kernel/leon_pmc.c
index 396f46bca52e..625924dd0e5b 100644
--- a/arch/sparc/kernel/leon_pmc.c
+++ b/arch/sparc/kernel/leon_pmc.c
@@ -75,15 +75,13 @@ static void pmc_leon_idle(void)
 /* Install LEON Power Down function */
 static int __init leon_pmc_install(void)
 {
-	if (sparc_cpu_model = sparc_leon) {
-		/* Assign power management IDLE handler */
-		if (pmc_leon_need_fixup())
-			sparc_idle = pmc_leon_idle_fixup;
-		else
-			sparc_idle = pmc_leon_idle;
+	/* Assign power management IDLE handler */
+	if (pmc_leon_need_fixup())
+		sparc_idle = pmc_leon_idle_fixup;
+	else
+		sparc_idle = pmc_leon_idle;
 
-		printk(KERN_INFO "leon: power management initialized\n");
-	}
+	printk(KERN_INFO "leon: power management initialized\n");
 
 	return 0;
 }
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index b6fd87928c73..91c0c043a95d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -202,30 +202,12 @@ static void __init per_cpu_patch(void)
 {
 	struct cpuid_patch_entry *p;
 
-	if (sparc_cpu_model = sun4m) {
-		/* Nothing to do, this is what the unpatched code
-		 * targets.
-		 */
-		return;
-	}
-
 	p = &__cpuid_patch;
 	while (p < &__cpuid_patch_end) {
 		unsigned long addr = p->addr;
 		unsigned int *insns;
 
-		switch (sparc_cpu_model) {
-		case sun4d:
-			insns = &p->sun4d[0];
-			break;
-
-		case sparc_leon:
-			insns = &p->leon[0];
-			break;
-		default:
-			prom_printf("Unknown cpu type, halting.\n");
-			prom_halt();
-		}
+		insns = &p->leon[0];
 		*(unsigned int *) (addr + 0) = insns[0];
 		flushi(addr + 0);
 		*(unsigned int *) (addr + 4) = insns[1];
@@ -237,31 +219,9 @@ static void __init per_cpu_patch(void)
 	}
 }
 
-struct leon_1insn_patch_entry {
-	unsigned int addr;
-	unsigned int insn;
-};
-
-enum sparc_cpu sparc_cpu_model;
-EXPORT_SYMBOL(sparc_cpu_model);
-
 static __init void leon_patch(void)
 {
-	struct leon_1insn_patch_entry *start = (void *)__leon_1insn_patch;
-	struct leon_1insn_patch_entry *end = (void *)__leon_1insn_patch_end;
-
 	/* Default instruction is leon - no patching */
-	if (sparc_cpu_model = sparc_leon)
-		return;
-
-	while (start < end) {
-		unsigned long addr = start->addr;
-
-		*(unsigned int *)(addr) = start->insn;
-		flushi(addr);
-
-		start++;
-	}
 }
 
 struct tt_entry *sparc_ttable;
@@ -273,22 +233,6 @@ static struct pt_regs fake_swapper_regs;
 void __init sparc32_start_kernel(struct linux_romvec *rp)
 {
 	prom_init(rp);
-
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
 	leon_patch();
 	start_kernel();
 }
@@ -309,27 +253,6 @@ void __init setup_arch(char **cmdline_p)
 
 	register_console(&prom_early_console);
 
-	switch(sparc_cpu_model) {
-	case sun4m:
-		pr_info("ARCH: SUN4M\n");
-		break;
-	case sun4d:
-		pr_info("ARCH: SUN4D\n");
-		break;
-	case sun4e:
-		pr_info("ARCH: SUN4E\n");
-		break;
-	case sun4u:
-		pr_info("ARCH: SUN4U\n");
-		break;
-	case sparc_leon:
-		pr_info("ARCH: LEON\n");
-		break;
-	default:
-		pr_info("ARCH: UNKNOWN!\n");
-		break;
-	}
-
 	idprom_init();
 	load_mmu();
 
-- 
2.27.0
