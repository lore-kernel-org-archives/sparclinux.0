From: konrad@gaisler.com
Date: Mon, 17 Aug 2009 10:13:31 +0000
Subject: [PATCH 3/5] sparc,leon: Introduce the sparc-leon CPU type.
Message-Id: <1250504013-652-3-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

Add sparc_leon enum, M_LEON|M_LEON3_SOC machine. Add compilation of
leon.c in mm and kernel
if CONFIG_SPARC_LEON is defined. Add sparc_leon dependent
initialization to switch statements + head.S.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
Reviewed-by:   Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/machines.h  |    6 +++++-
 arch/sparc/include/asm/pgtsrmmu.h  |    4 ++++
 arch/sparc/include/asm/prom.h      |    3 +++
 arch/sparc/include/asm/system_32.h |    1 +
 arch/sparc/kernel/Makefile         |    2 ++
 arch/sparc/kernel/cpu.c            |    5 +++++
 arch/sparc/kernel/head_32.S        |    5 +++++
 arch/sparc/kernel/idprom.c         |    2 ++
 arch/sparc/kernel/irq_32.c         |    5 +++++
 arch/sparc/kernel/setup_32.c       |    5 +++++
 arch/sparc/mm/Makefile             |    1 +
 arch/sparc/mm/init_32.c            |    4 ++++
 arch/sparc/mm/loadmmu.c            |    1 +
 13 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/machines.h b/arch/sparc/include/asm/machines.h
index c28c2f2..cd9c099 100644
--- a/arch/sparc/include/asm/machines.h
+++ b/arch/sparc/include/asm/machines.h
@@ -15,7 +15,7 @@ struct Sun_Machine_Models {
 /* Current number of machines we know about that has an IDPROM
  * machtype entry including one entry for the 0x80 OBP machines.
  */
-#define NUM_SUN_MACHINES   15
+#define NUM_SUN_MACHINES   16
 
 /* The machine type in the idprom area looks like this:
  *
@@ -30,6 +30,7 @@ struct Sun_Machine_Models {
 
 #define SM_ARCH_MASK  0xf0
 #define SM_SUN4       0x20
+#define  M_LEON       0x30
 #define SM_SUN4C      0x50
 #define SM_SUN4M      0x70
 #define SM_SUN4M_OBP  0x80
@@ -41,6 +42,9 @@ struct Sun_Machine_Models {
 #define SM_4_330      0x03    /* Sun 4/300 series */
 #define SM_4_470      0x04    /* Sun 4/400 series */
 
+/* Leon machines */
+#define M_LEON3_SOC   0x02    /* Leon3 SoC */
+
 /* Sun4c machines                Full Name              - PROM NAME */
 #define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
 #define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 808555f..1407c07 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -267,6 +267,7 @@ static inline void srmmu_flush_tlb_page(unsigned long page)
 
 }
 
+#ifndef CONFIG_SPARC_LEON
 static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 {
 	unsigned long retval;
@@ -278,6 +279,9 @@ static inline unsigned long srmmu_hwprobe(unsigned long vaddr)
 
 	return retval;
 }
+#else
+#define srmmu_hwprobe(addr) (srmmu_swprobe(addr, 0) & SRMMU_PTE_PMASK)
+#endif
 
 static inline int
 srmmu_get_pte (unsigned long addr)
diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index be8d7aa..82a190d 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -118,5 +118,8 @@ extern struct device_node *of_console_device;
 extern char *of_console_path;
 extern char *of_console_options;
 
+extern void (*prom_build_more)(struct device_node *dp, struct device_node ***nextp);
+extern char *build_full_name(struct device_node *dp);
+
 #endif /* __KERNEL__ */
 #endif /* _SPARC_PROM_H */
diff --git a/arch/sparc/include/asm/system_32.h b/arch/sparc/include/asm/system_32.h
index 751c8c1..890036b 100644
--- a/arch/sparc/include/asm/system_32.h
+++ b/arch/sparc/include/asm/system_32.h
@@ -32,6 +32,7 @@ enum sparc_cpu {
   sun4u       = 0x05, /* V8 ploos ploos */
   sun_unknown = 0x06,
   ap1000      = 0x07, /* almost a sun4m */
+  sparc_leon  = 0x08, /* Leon SoC */
 };
 
 /* Really, userland should not be looking at any of this... */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 475ce46..b004175 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -41,6 +41,8 @@ obj-y                   += of_device_common.o
 obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
+obj-$(CONFIG_SPARC_LEON)+= leon_kernel.o
+
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
 obj-$(CONFIG_SPARC64)   += iommu.o
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index d85c3dc..1446df9 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -312,7 +312,12 @@ void __cpuinit cpu_probe(void)
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
+#ifdef CONFIG_SPARC_LEON
+	fpu_vers = 7;
+#else
 	fpu_vers = ((get_fsr() >> 17) & 0x7);
+#endif
+
 	put_psr(psr);
 
 	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 6b4d8ac..439d82a 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -809,6 +809,11 @@ found_version:
 		 nop
 
 got_prop:
+#ifdef CONFIG_SPARC_LEON
+	        /* no cpu-type check is needed, it is a SPARC-LEON */
+		ba sun4c_continue_boot
+		 nop
+#endif
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 57922f6..52a15fe 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -31,6 +31,8 @@ static struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
 { .name = "Sun 4/200 Series",        .id_machtype = (SM_SUN4 | SM_4_260) },
 { .name = "Sun 4/300 Series",        .id_machtype = (SM_SUN4 | SM_4_330) },
 { .name = "Sun 4/400 Series",        .id_machtype = (SM_SUN4 | SM_4_470) },
+/* Now Leon */
+{ .name = "Leon3 System-on-a-Chip",  .id_machtype = (M_LEON | M_LEON3_SOC) },
 /* Now, Sun4c's */
 { .name = "Sun4c SparcStation 1",    .id_machtype = (SM_SUN4C | SM_4C_SS1) },
 { .name = "Sun4c SparcStation IPC",  .id_machtype = (SM_SUN4C | SM_4C_IPC) },
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index ad800b8..e1af437 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -45,6 +45,7 @@
 #include <asm/pcic.h>
 #include <asm/cacheflush.h>
 #include <asm/irq_regs.h>
+#include <asm/leon.h>
 
 #include "kernel.h"
 #include "irq.h"
@@ -661,6 +662,10 @@ void __init init_IRQ(void)
 		sun4d_init_IRQ();
 		break;
 
+	case sparc_leon:
+		leon_init_IRQ();
+		break;
+
 	default:
 		prom_printf("Cannot initialize IRQs on this Sun machine...");
 		break;
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 998cadb..16a47ff 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -235,6 +235,8 @@ void __init setup_arch(char **cmdline_p)
 		sparc_cpu_model = sun4e;
 	if (!strcmp(&cputypval,"sun4u"))
 		sparc_cpu_model = sun4u;
+	if (!strncmp(&cputypval, "leon" , 4))
+		sparc_cpu_model = sparc_leon;
 
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
@@ -256,6 +258,9 @@ void __init setup_arch(char **cmdline_p)
 	case sun4u:
 		printk("SUN4U\n");
 		break;
+	case sparc_leon:
+		printk("LEON\n");
+		break;
 	default:
 		printk("UNKNOWN!\n");
 		break;
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 681abe0..79836a7 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SPARC32)   += loadmmu.o
 obj-y                   += generic_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
+obj-$(CONFIG_SPARC_LEON)+= leon_mm.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 26bb391..54114ad 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -34,6 +34,7 @@
 #include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
 #include <asm/tlb.h>
 #include <asm/prom.h>
+#include <asm/leon.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -326,6 +327,9 @@ void __init paging_init(void)
 		sparc_unmapped_base = 0xe0000000;
 		BTFIXUPSET_SETHI(sparc_unmapped_base, 0xe0000000);
 		break;
+	case sparc_leon:
+		leon_init();
+		/* fall through */
 	case sun4m:
 	case sun4d:
 		srmmu_paging_init();
diff --git a/arch/sparc/mm/loadmmu.c b/arch/sparc/mm/loadmmu.c
index 652be05..82ec8f6 100644
--- a/arch/sparc/mm/loadmmu.c
+++ b/arch/sparc/mm/loadmmu.c
@@ -33,6 +33,7 @@ void __init load_mmu(void)
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		ld_mmu_srmmu();
 		break;
 	default:
-- 
1.6.3.2

