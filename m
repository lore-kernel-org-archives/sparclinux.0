From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 10 Jun 2008 22:28:38 +0000
Subject: [2.6 patch] sparc: remove CONFIG_SUN4
Message-Id: <20080610222838.GL11685@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

While doing some easy cleanups on the sparc code I noticed that the
CONFIG_SUN4 code seems to be worse than the rest - there were some
"I don't know how it should work, but the current code definitely cannot
work." places.

And while I have seen people running Linux on machines like a
SPARCstation 5 a few years ago I don't recall having seen sun4
machines, even less ones running Linux.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc/Kconfig            |   15 --
 arch/sparc/kernel/Makefile    |    1 
 arch/sparc/kernel/entry.S     |   54 ----------
 arch/sparc/kernel/head.S      |   28 -----
 arch/sparc/kernel/idprom.c    |    7 -
 arch/sparc/kernel/ioport.c    |   10 -
 arch/sparc/kernel/prom.c      |    1 
 arch/sparc/kernel/setup.c     |    6 -
 arch/sparc/kernel/sun4c_irq.c |   58 +++-------
 arch/sparc/kernel/sun4setup.c |   75 --------------
 arch/sparc/kernel/time.c      |  162 ------------------------------
 arch/sparc/mm/Makefile        |    9 -
 arch/sparc/mm/btfixup.c       |    4 
 arch/sparc/mm/nosrmmu.c       |   59 -----------
 arch/sparc/mm/sun4c.c         |  180 ++++++++--------------------------
 arch/sparc/prom/Makefile      |    2 
 arch/sparc/prom/bootstr.c     |    1 
 arch/sparc/prom/console.c     |    2 
 arch/sparc/prom/init.c        |   10 -
 arch/sparc/prom/memory.c      |   13 --
 arch/sparc/prom/sun4prom.c    |  161 ------------------------------
 drivers/ata/Kconfig           |    1 
 drivers/net/sunlance.c        |   42 -------
 drivers/sbus/dvma.c           |   33 ------
 include/asm-m68k/sbus.h       |    2 
 include/asm-sparc/asmmacro.h  |    5 
 include/asm-sparc/dma.h       |    5 
 include/asm-sparc/elf.h       |    5 
 include/asm-sparc/mostek.h    |   40 -------
 include/asm-sparc/oplib.h     |    1 
 include/asm-sparc/page.h      |    5 
 include/asm-sparc/pgtable.h   |    4 
 include/asm-sparc/sun4paddr.h |   56 ----------
 include/asm-sparc/system.h    |    6 -
 include/asm-sparc/timer.h     |    8 -
 include/asm-sparc/vac-ops.h   |    4 
 include/asm-sparc64/system.h  |    3 
 37 files changed, 72 insertions(+), 1006 deletions(-)

89fd652997fb5e017c31761de44353c95aacb024 diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 789724e..e56cb35 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -203,17 +203,6 @@ config SUN_PM
 	  Enable power management and CPU standby features on supported
 	  SPARC platforms.
 
-config SUN4
-	bool "Support for SUN4 machines (disables SUN4[CDM] support)"
-	depends on !SMP
-	default n
-	help
-	  Say Y here if, and only if, your machine is a sun4. Note that
-	  a kernel compiled with this option will run only on sun4.
-	  (And the current version will probably work only on sun4/330.)
-
-if !SUN4
-
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
 	help
@@ -226,8 +215,6 @@ config PCI_SYSCALL
 
 source "drivers/pci/Kconfig"
 
-endif
-
 config NO_DMA
 	def_bool !PCI
 
@@ -262,9 +249,7 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
-if !SUN4
 source "drivers/sbus/char/Kconfig"
-endif
 
 # This one must be before the filesystem configs. -DaveM
 
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 6e03a2a..affc477 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -18,7 +18,6 @@ obj-y    := entry.o wof.o wuf.o etrap.o rtrap.o traps.o $(IRQ_OBJS) \
 devres-y = ../../../kernel/irq/devres.o
 
 obj-$(CONFIG_PCI) += pcic.o
-obj-$(CONFIG_SUN4) += sun4setup.o
 obj-$(CONFIG_SMP) += trampoline.o smp.o sun4m_smp.o sun4d_smp.o
 obj-$(CONFIG_SUN_AUXIO) += auxio.o
 obj-$(CONFIG_PCI) += ebus.o
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 55d3be1..2ce9acd 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -19,11 +19,7 @@
 #include <asm/vaddrs.h>
 #include <asm/memreg.h>
 #include <asm/page.h>
-#ifdef CONFIG_SUN4
-#include <asm/pgtsun4.h>
-#else
 #include <asm/pgtsun4c.h>
-#endif
 #include <asm/winmacro.h>
 #include <asm/signal.h>
 #include <asm/obio.h>
@@ -774,11 +770,7 @@ vac_linesize_patch_32:		subcc	%l7, 32, %l7
  * Ugly, but we cant use hardware flushing on the sun4 and we'd require
  * two instructions (Anton)
  */
-#ifdef CONFIG_SUN4
-vac_hwflush_patch1_on:		nop
-#else
 vac_hwflush_patch1_on:		addcc	%l7, -PAGE_SIZE, %l7
-#endif
 
 vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
 
@@ -797,42 +789,10 @@ vac_hwflush_patch2_on:		sta	%g0, [%l3 + %l7] ASI_HWFLUSHSEG
 ! %l7 = 1 for textfault
 ! We want error in %l5, vaddr in %l6
 sun4c_fault:
-#ifdef CONFIG_SUN4
-	sethi	%hi(sun4c_memerr_reg), %l4
-	ld	[%l4+%lo(sun4c_memerr_reg)], %l4  ! memerr ctrl reg addr
-	ld	[%l4], %l6		! memerr ctrl reg
-	ld	[%l4 + 4], %l5		! memerr vaddr reg
-	andcc	%l6, 0x80, %g0		! check for error type
-	st	%g0, [%l4 + 4]		! clear the error
-	be	0f			! normal error
-	 sethi	%hi(AC_BUS_ERROR), %l4	! bus err reg addr
-
-	call	prom_halt	! something weird happened
-					! what exactly did happen?
-					! what should we do here?
-
-0:	or	%l4, %lo(AC_BUS_ERROR), %l4	! bus err reg addr
-	lduba	[%l4] ASI_CONTROL, %l6	! bus err reg
-
-	cmp    %l7, 1			! text fault?
-	be	1f			! yes
-	 nop
-
-	ld     [%l1], %l4		! load instruction that caused fault
-	srl	%l4, 21, %l4
-	andcc	%l4, 1, %g0		! store instruction?
-
-	be	1f			! no
-	 sethi	%hi(SUN4C_SYNC_BADWRITE), %l4 ! yep
-					! %lo(SUN4C_SYNC_BADWRITE) = 0
-	or	%l4, %l6, %l6		! set write bit to emulate sun4c
-1:
-#else
 	sethi	%hi(AC_SYNC_ERR), %l4
 	add	%l4, 0x4, %l6			! AC_SYNC_VA in %l6
 	lda	[%l6] ASI_CONTROL, %l5		! Address
 	lda	[%l4] ASI_CONTROL, %l6		! Error, retained for a bit
-#endif
 
 	andn	%l5, 0xfff, %l5			! Encode all info into l7
 	srl	%l6, 14, %l4
@@ -879,12 +839,7 @@ sun4c_fault:
 	or      %l4, %lo(swapper_pg_dir), %l4
 	sll     %l6, 2, %l6
 	ld      [%l4 + %l6], %l4
-#ifdef CONFIG_SUN4
-	sethi	%hi(PAGE_MASK), %l6
-	andcc	%l4, %l6, %g0
-#else
 	andcc   %l4, PAGE_MASK, %g0
-#endif
 	be      sun4c_fault_fromuser
 	 lduXa  [%l5] ASI_SEGMAP, %l4
 
@@ -936,11 +891,7 @@ invalid_segment_patch1:
 	ld	[%l6 + 0x08], %l3	! tmp = entry->vaddr
 
 	! Flush segment from the cache.
-#ifdef CONFIG_SUN4
-	sethi	%hi((128 * 1024)), %l7
-#else
 	sethi	%hi((64 * 1024)), %l7
-#endif
 9:
 vac_hwflush_patch1:
 vac_linesize_patch:
@@ -1028,12 +979,7 @@ invalid_segment_patch2:
 	or	%l4, %lo(swapper_pg_dir), %l4
 	sll	%l3, 2, %l3
 	ld	[%l4 + %l3], %l4
-#ifndef CONFIG_SUN4
 	and	%l4, PAGE_MASK, %l4
-#else
-	sethi	%hi(PAGE_MASK), %l6
-	and	%l4, %l6, %l4
-#endif
 
 	srl	%l5, (PAGE_SHIFT - 2), %l6
 	and	%l6, ((SUN4C_PTRS_PER_PTE - 1) << 2), %l6
diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
index 50d9a16..2d325fd 100644
--- a/arch/sparc/kernel/head.S
+++ b/arch/sparc/kernel/head.S
@@ -63,15 +63,9 @@ cputypvar_sun4m:
 
 	.align 4
 
-#ifndef CONFIG_SUN4
 sun4_notsup:
-	.asciz	"Sparc-Linux sun4 needs a specially compiled kernel, turn CONFIG_SUN4 on.\n\n"
+	.asciz	"Sparc-Linux sun4 support does no longer exist.\n\n"
 	.align 4
-#else
-sun4cdm_notsup:
-	.asciz	"Kernel compiled with CONFIG_SUN4 cannot run on SUN4C/SUN4M/SUN4D\nTurn CONFIG_SUN4 off.\n\n"
-	.align 4
-#endif
 
 sun4e_notsup:
         .asciz  "Sparc-Linux sun4e support does not exist\n\n"
@@ -780,15 +774,6 @@ execute_in_high_mem:
 		 nop
 
 found_version:
-#ifdef CONFIG_SUN4
-/* For people who try sun4 kernels, even if Configure.help advises them. */
-		ld	[%g7 + 0x68], %o1
-		set	sun4cdm_notsup, %o0
-		call	%o1
-		 nop
-		b	halt_me
-		 nop
-#endif
 /* Get the machine type via the mysterious romvec node operations. */
 
 		add	%g7, 0x1c, %l1		
@@ -1150,15 +1135,6 @@ sun4c_continue_boot:
 		 nop
 
 sun4_init:
-#ifdef CONFIG_SUN4
-/* There, happy now Adrian? */
-		set	cputypval, %o2		! Let everyone know we
-		set	' ', %o0			! are a "sun4 " architecture
-		stb	%o0, [%o2 + 0x4]		
-
-		b got_prop 
-		 nop
-#else
 		sethi   %hi(SUN4_PROM_VECTOR+0x84), %o1
 		ld      [%o1 + %lo(SUN4_PROM_VECTOR+0x84)], %o1
 		set     sun4_notsup, %o0
@@ -1170,7 +1146,7 @@ sun4_init:
 		 nop
 1:		ba      1b                      ! Cannot exit into KMON
 		 nop
-#endif
+
 no_sun4e_here:
 		ld	[%g7 + 0x68], %o1
 		set	sun4e_notsup, %o0
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index fc511f3..223a658 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -12,10 +12,6 @@
 #include <asm/oplib.h>
 #include <asm/idprom.h>
 #include <asm/machines.h>  /* Fun with Sun released architectures. */
-#ifdef CONFIG_SUN4
-#include <asm/sun4paddr.h>
-extern void sun4setup(void);
-#endif
 
 struct idprom *idprom;
 static struct idprom idprom_buffer;
@@ -101,7 +97,4 @@ void __init idprom_init(void)
 		    idprom->id_ethaddr[0], idprom->id_ethaddr[1],
 		    idprom->id_ethaddr[2], idprom->id_ethaddr[3],
 		    idprom->id_ethaddr[4], idprom->id_ethaddr[5]);
-#ifdef CONFIG_SUN4
-	sun4setup();
-#endif
 }
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 4879609..e3ffd8d 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -510,7 +510,6 @@ void __init sbus_arch_bus_ranges_init(struct device_node *pn, struct sbus_bus *s
 
 void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 {
-#ifndef CONFIG_SUN4
 	struct device_node *parent = dp->parent;
 
 	if (sparc_cpu_model != sun4d &&
@@ -527,7 +526,6 @@ void __init sbus_setup_iommu(struct sbus_bus *sbus, struct device_node *dp)
 
 		iounit_init(dp->node, parent->node, sbus);
 	}
-#endif
 }
 
 void __init sbus_setup_arch_props(struct sbus_bus *sbus, struct device_node *dp)
@@ -544,15 +542,7 @@ int __init sbus_arch_preinit(void)
 {
 	register_proc_sparc_ioport();
 
-#ifdef CONFIG_SUN4
-	{
-		extern void sun4_dvma_init(void);
-		sun4_dvma_init();
-	}
-	return 1;
-#else
 	return 0;
-#endif
 }
 
 void __init sbus_arch_postinit(void)
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index cd4fb79..d49c42d 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -436,7 +436,6 @@ static void __init of_console_init(void)
 
 	switch (prom_vers) {
 	case PROM_V0:
-	case PROM_SUN4:
 		skip = 0;
 		switch (*romvec->pv_stdout) {
 		case PROMDEV_SCREEN:
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index 9e451b2..7158d56 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -224,12 +224,6 @@ void __init setup_arch(char **cmdline_p)
 	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
 	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
 
-#ifdef CONFIG_SUN4
-	if (sparc_cpu_model != sun4) {
-		prom_printf("This kernel is for Sun4 architecture only.\n");
-		prom_halt();
-	}
-#endif
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4:
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 340fc39..a1baea3 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -31,7 +31,6 @@
 #include <asm/traps.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/sun4paddr.h>
 #include <asm/idprom.h>
 #include <asm/machines.h>
 #include <asm/sbus.h>
@@ -141,22 +140,10 @@ static void sun4c_enable_irq(unsigned int irq_nr)
 
 volatile struct sun4c_timer_info *sun4c_timers;
 
-#ifdef CONFIG_SUN4
-/* This is an ugly hack to work around the
-   current timer code, and make it work with 
-   the sun4/260 intersil 
-   */
-volatile struct sun4c_timer_info sun4_timer;
-#endif
-
 static void sun4c_clear_clock_irq(void)
 {
 	volatile unsigned int clear_intr;
-#ifdef CONFIG_SUN4
-	if (idprom->id_machtype = (SM_SUN4 | SM_4_260)) 
-	  clear_intr = sun4_timer.timer_limit10;
-	else
-#endif
+
 	clear_intr = sun4c_timers->timer_limit10;
 }
 
@@ -177,11 +164,6 @@ static void __init sun4c_init_timers(irq_handler_t counter_fn)
 	/* Map the Timer chip, this is implemented in hardware inside
 	 * the cache chip on the sun4c.
 	 */
-#ifdef CONFIG_SUN4
-	if (idprom->id_machtype = (SM_SUN4 | SM_4_260))
-		sun4c_timers = &sun4_timer;
-	else
-#endif
 	sun4c_timers = ioremap(SUN_TIMER_PHYSADDR,
 	    sizeof(struct sun4c_timer_info));
 
@@ -217,28 +199,22 @@ void __init sun4c_init_IRQ(void)
 {
 	struct linux_prom_registers int_regs[2];
 	int ie_node;
-
-	if (ARCH_SUN4) {
-		interrupt_enable = (char *)
-		    ioremap(sun4_ie_physaddr, PAGE_SIZE);
-	} else {
-		struct resource phyres;
-
-		ie_node = prom_searchsiblings (prom_getchild(prom_root_node),
-				       	"interrupt-enable");
-		if(ie_node = 0)
-			panic("Cannot find /interrupt-enable node");
-
-		/* Depending on the "address" property is bad news... */
-		interrupt_enable = NULL;
-		if (prom_getproperty(ie_node, "reg", (char *) int_regs,
-				     sizeof(int_regs)) != -1) {
-			memset(&phyres, 0, sizeof(struct resource));
-			phyres.flags = int_regs[0].which_io;
-			phyres.start = int_regs[0].phys_addr;
-			interrupt_enable = (char *) sbus_ioremap(&phyres, 0,
-			    int_regs[0].reg_size, "sun4c_intr");
-		}
+	struct resource phyres;
+
+	ie_node = prom_searchsiblings(prom_getchild(prom_root_node),
+			       	"interrupt-enable");
+	if (ie_node = 0)
+		panic("Cannot find /interrupt-enable node");
+
+	/* Depending on the "address" property is bad news... */
+	interrupt_enable = NULL;
+	if (prom_getproperty(ie_node, "reg", (char *) int_regs,
+			     sizeof(int_regs)) != -1) {
+		memset(&phyres, 0, sizeof(struct resource));
+		phyres.flags = int_regs[0].which_io;
+		phyres.start = int_regs[0].phys_addr;
+		interrupt_enable = (char *) sbus_ioremap(&phyres, 0,
+		    int_regs[0].reg_size, "sun4c_intr");
 	}
 	if (!interrupt_enable)
 		panic("Cannot map interrupt_enable");
diff --git a/arch/sparc/kernel/sun4setup.c b/arch/sparc/kernel/sun4setup.c
deleted file mode 100644
index 229a52f..0000000
--- a/arch/sparc/kernel/sun4setup.c
+++ /dev/null
@@ -1,75 +0,0 @@
-/* sun4setup.c: Setup the hardware address of various items in the sun4
- * 		architecture. Called from idprom_init
- *
- * Copyright (C) 1998 Chris G. Davis (cdavis@cois.on.ca)
- */
-
-#include <asm/page.h>
-#include <asm/oplib.h>
-#include <asm/idprom.h>
-#include <asm/sun4paddr.h>
-#include <asm/machines.h>
-
-int sun4_memreg_physaddr;
-int sun4_ie_physaddr;
-int sun4_clock_physaddr;
-int sun4_timer_physaddr;
-int sun4_eth_physaddr;
-int sun4_si_physaddr;
-int sun4_bwtwo_physaddr;
-int sun4_zs0_physaddr;
-int sun4_zs1_physaddr;
-int sun4_dma_physaddr;
-int sun4_esp_physaddr;
-int sun4_ie_physaddr; 
-
-void __init sun4setup(void)
-{
-	printk("Sun4 Hardware Setup v1.0 18/May/98 Chris Davis (cdavis@cois.on.ca). ");
-	/*
-	  setup standard sun4 info
-	  */
-	sun4_ie_physaddr=SUN4_IE_PHYSADDR;
-
-	/*
-	  setup model specific info
-	  */
-	switch(idprom->id_machtype) {
-		case (SM_SUN4 | SM_4_260 ):
-			printk("Setup for a SUN4/260\n");
-			sun4_memreg_physaddr=SUN4_200_MEMREG_PHYSADDR;
-			sun4_clock_physaddr=SUN4_200_CLOCK_PHYSADDR;
-			sun4_timer_physaddr=SUN4_UNUSED_PHYSADDR;
-			sun4_eth_physaddr=SUN4_200_ETH_PHYSADDR;
-			sun4_si_physaddr=SUN4_200_SI_PHYSADDR;
-			sun4_bwtwo_physaddr=SUN4_200_BWTWO_PHYSADDR;
-			sun4_dma_physaddr=SUN4_UNUSED_PHYSADDR;
-			sun4_esp_physaddr=SUN4_UNUSED_PHYSADDR;
-			break;
-		case (SM_SUN4 | SM_4_330 ):
-			printk("Setup for a SUN4/330\n");
-			sun4_memreg_physaddr=SUN4_300_MEMREG_PHYSADDR;
-			sun4_clock_physaddr=SUN4_300_CLOCK_PHYSADDR;
-			sun4_timer_physaddr=SUN4_300_TIMER_PHYSADDR;
-			sun4_eth_physaddr=SUN4_300_ETH_PHYSADDR;
-			sun4_si_physaddr=SUN4_UNUSED_PHYSADDR;
-			sun4_bwtwo_physaddr=SUN4_300_BWTWO_PHYSADDR;
-			sun4_dma_physaddr=SUN4_300_DMA_PHYSADDR;
-			sun4_esp_physaddr=SUN4_300_ESP_PHYSADDR;
-			break;
-		case (SM_SUN4 | SM_4_470 ):
-			printk("Setup for a SUN4/470\n");
-			sun4_memreg_physaddr=SUN4_400_MEMREG_PHYSADDR;
-			sun4_clock_physaddr=SUN4_400_CLOCK_PHYSADDR;
-			sun4_timer_physaddr=SUN4_400_TIMER_PHYSADDR;
-			sun4_eth_physaddr=SUN4_400_ETH_PHYSADDR;
-			sun4_si_physaddr=SUN4_UNUSED_PHYSADDR;
-			sun4_bwtwo_physaddr=SUN4_400_BWTWO_PHYSADDR;
-			sun4_dma_physaddr=SUN4_400_DMA_PHYSADDR;
-			sun4_esp_physaddr=SUN4_400_ESP_PHYSADDR;
-			break;
-		default:
-			;
-	}
-}
-
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index ab3dd0b..bfe0af6 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -37,7 +37,6 @@
 #include <asm/io.h>
 #include <asm/idprom.h>
 #include <asm/machines.h>
-#include <asm/sun4paddr.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
 #include <asm/of_device.h>
@@ -53,27 +52,6 @@ static struct mostek48t08 __iomem *mstk48t08_regs = NULL;
 static int set_rtc_mmss(unsigned long);
 static int sbus_do_settimeofday(struct timespec *tv);
 
-#ifdef CONFIG_SUN4
-struct intersil *intersil_clock;
-#define intersil_cmd(intersil_reg, intsil_cmd) intersil_reg->int_cmd_reg = \
-	(intsil_cmd)
-
-#define intersil_intr(intersil_reg, intsil_cmd) intersil_reg->int_intr_reg = \
-	(intsil_cmd)
-
-#define intersil_start(intersil_reg) intersil_cmd(intersil_reg, \
-	( INTERSIL_START | INTERSIL_32K | INTERSIL_NORMAL | INTERSIL_24H |\
-	  INTERSIL_INTR_ENABLE))
-
-#define intersil_stop(intersil_reg) intersil_cmd(intersil_reg, \
-	( INTERSIL_STOP | INTERSIL_32K | INTERSIL_NORMAL | INTERSIL_24H |\
-	  INTERSIL_INTR_ENABLE))
-
-#define intersil_read_intr(intersil_reg, towhere) towhere = \
-	intersil_reg->int_intr_reg
-
-#endif
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	extern char __copy_user_begin[], __copy_user_end[];
@@ -116,15 +94,7 @@ static irqreturn_t timer_interrupt(int dummy, void *dev_id)
 
 	/* Protect counter clear so that do_gettimeoffset works */
 	write_seqlock(&xtime_lock);
-#ifdef CONFIG_SUN4
-	if((idprom->id_machtype = (SM_SUN4 | SM_4_260)) ||
-	   (idprom->id_machtype = (SM_SUN4 | SM_4_110))) {
-		int temp;
-        	intersil_read_intr(intersil_clock, temp);
-		/* re-enable the irq */
-		enable_pil_irq(10);
-	}
-#endif
+
 	clear_clock_irq();
 
 	do_timer(1);
@@ -249,55 +219,6 @@ static void __devinit mostek_set_system_time(void)
 	spin_unlock_irq(&mostek_lock);
 }
 
-/* Probe for the real time clock chip on Sun4 */
-static inline void sun4_clock_probe(void)
-{
-#ifdef CONFIG_SUN4
-	int temp;
-	struct resource r;
-
-	memset(&r, 0, sizeof(r));
-	if( idprom->id_machtype = (SM_SUN4 | SM_4_330) ) {
-		sp_clock_typ = MSTK48T02;
-		r.start = sun4_clock_physaddr;
-		mstk48t02_regs = sbus_ioremap(&r, 0,
-				       sizeof(struct mostek48t02), NULL);
-		mstk48t08_regs = NULL;  /* To catch weirdness */
-		intersil_clock = NULL;  /* just in case */
-
-		/* Kick start the clock if it is completely stopped. */
-		if (mostek_read(mstk48t02_regs + MOSTEK_SEC) & MSTK_STOP)
-			kick_start_clock();
-	} else if( idprom->id_machtype = (SM_SUN4 | SM_4_260)) {
-		/* intersil setup code */
-		printk("Clock: INTERSIL at %8x ",sun4_clock_physaddr);
-		sp_clock_typ = INTERSIL;
-		r.start = sun4_clock_physaddr;
-		intersil_clock = (struct intersil *) 
-		    sbus_ioremap(&r, 0, sizeof(*intersil_clock), "intersil");
-		mstk48t02_regs = 0;  /* just be sure */
-		mstk48t08_regs = NULL;  /* ditto */
-		/* initialise the clock */
-
-		intersil_intr(intersil_clock,INTERSIL_INT_100HZ);
-
-		intersil_start(intersil_clock);
-
-		intersil_read_intr(intersil_clock, temp);
-                while (!(temp & 0x80))
-                        intersil_read_intr(intersil_clock, temp);
-
-                intersil_read_intr(intersil_clock, temp);
-                while (!(temp & 0x80))
-                        intersil_read_intr(intersil_clock, temp);
-
-		intersil_stop(intersil_clock);
-
-	}
-#endif
-}
-
-#ifndef CONFIG_SUN4
 static int __devinit clock_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct device_node *dp = op->node;
@@ -364,7 +285,6 @@ static int __init clock_init(void)
  * need to see the clock registers.
  */
 fs_initcall(clock_init);
-#endif /* !CONFIG_SUN4 */
 
 static void __init sbus_time_init(void)
 {
@@ -372,51 +292,8 @@ static void __init sbus_time_init(void)
 	BTFIXUPSET_CALL(bus_do_settimeofday, sbus_do_settimeofday, BTFIXUPCALL_NORM);
 	btfixup();
 
-	if (ARCH_SUN4)
-		sun4_clock_probe();
-
 	sparc_init_timers(timer_interrupt);
 	
-#ifdef CONFIG_SUN4
-	if(idprom->id_machtype = (SM_SUN4 | SM_4_330)) {
-		mostek_set_system_time();
-	} else if(idprom->id_machtype = (SM_SUN4 | SM_4_260) ) {
-		/* initialise the intersil on sun4 */
-		unsigned int year, mon, day, hour, min, sec;
-		int temp;
-		struct intersil *iregs;
-
-		iregs=intersil_clock;
-		if(!iregs) {
-			prom_printf("Something wrong, clock regs not mapped yet.\n");
-			prom_halt();
-		}
-
-		intersil_intr(intersil_clock,INTERSIL_INT_100HZ);
-		disable_pil_irq(10);
-		intersil_stop(iregs);
-		intersil_read_intr(intersil_clock, temp);
-
-		temp = iregs->clk.int_csec;
-
-		sec = iregs->clk.int_sec;
-		min = iregs->clk.int_min;
-		hour = iregs->clk.int_hour;
-		day = iregs->clk.int_day;
-		mon = iregs->clk.int_month;
-		year = MSTK_CVT_YEAR(iregs->clk.int_year);
-
-		enable_pil_irq(10);
-		intersil_start(iregs);
-
-		xtime.tv_sec = mktime(year, mon, day, hour, min, sec);
-		xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
-	        set_normalized_timespec(&wall_to_monotonic,
- 	                               -xtime.tv_sec, -xtime.tv_nsec);
-		printk("%u/%u/%u %u:%u:%u\n",day,mon,year,hour,min,sec);
-	}
-#endif
-
 	/* Now that OBP ticker has been silenced, it is safe to enable IRQ. */
 	local_irq_enable();
 }
@@ -531,43 +408,6 @@ static int set_rtc_mmss(unsigned long nowtime)
 	int real_seconds, real_minutes, mostek_minutes;
 	struct mostek48t02 *regs = (struct mostek48t02 *)mstk48t02_regs;
 	unsigned long flags;
-#ifdef CONFIG_SUN4
-	struct intersil *iregs = intersil_clock;
-	int temp;
-#endif
-
-	/* Not having a register set can lead to trouble. */
-	if (!regs) {
-#ifdef CONFIG_SUN4
-		if(!iregs)
-		return -1;
-	 	else {
-			temp = iregs->clk.int_csec;
-
-			mostek_minutes = iregs->clk.int_min;
-
-			real_seconds = nowtime % 60;
-			real_minutes = nowtime / 60;
-			if (((abs(real_minutes - mostek_minutes) + 15)/30) & 1)
-				real_minutes += 30;	/* correct for half hour time zone */
-			real_minutes %= 60;
-
-			if (abs(real_minutes - mostek_minutes) < 30) {
-				intersil_stop(iregs);
-				iregs->clk.int_sec=real_seconds;
-				iregs->clk.int_min=real_minutes;
-				intersil_start(iregs);
-			} else {
-				printk(KERN_WARNING
-			       "set_rtc_mmss: can't update from %d to %d\n",
-				       mostek_minutes, real_minutes);
-				return -1;
-			}
-			
-			return 0;
-		}
-#endif
-	}
 
 	spin_lock_irqsave(&mostek_lock, flags);
 	/* Read the current RTC minutes. */
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 109c8b2..31a3b99 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -3,13 +3,8 @@
 
 EXTRA_AFLAGS := -ansi
 
-obj-y    := fault.o init.o loadmmu.o generic.o extable.o btfixup.o
-
-ifeq ($(CONFIG_SUN4),y)
-obj-y	 += nosrmmu.o
-else
-obj-y	 += srmmu.o iommu.o io-unit.o hypersparc.o viking.o tsunami.o swift.o
-endif
+obj-y    := fault.o init.o loadmmu.o generic.o extable.o btfixup.o \
+	    srmmu.o iommu.o io-unit.o hypersparc.o viking.o tsunami.o swift.o
 
 ifdef CONFIG_HIGHMEM
 obj-y	+= highmem.o
diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
index a312d12..aaa22a9 100644
--- a/arch/sparc/mm/btfixup.c
+++ b/arch/sparc/mm/btfixup.c
@@ -20,11 +20,7 @@
 
 extern char *srmmu_name;
 static char version[] __initdata = "Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for ";
-#ifdef CONFIG_SUN4
-static char str_sun4c[] __initdata = "sun4\n";
-#else
 static char str_sun4c[] __initdata = "sun4c\n";
-#endif
 static char str_srmmu[] __initdata = "srmmu[%s]/";
 static char str_iommu[] __initdata = "iommu\n";
 static char str_iounit[] __initdata = "io-unit\n";
diff --git a/arch/sparc/mm/nosrmmu.c b/arch/sparc/mm/nosrmmu.c
deleted file mode 100644
index 3701f70..0000000
--- a/arch/sparc/mm/nosrmmu.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- * nosrmmu.c: This file is a bunch of dummies for sun4 compiles, 
- *         so that it does not need srmmu and avoid ifdefs.
- *
- * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <asm/mbus.h>
-#include <asm/sbus.h>
-
-static char shouldnothappen[] __initdata = "SUN4 kernel can only run on SUN4\n";
-
-enum mbus_module srmmu_modtype;
-void *srmmu_nocache_pool;
-
-int vac_cache_size = 0;
-
-static void __init should_not_happen(void)
-{
-	prom_printf(shouldnothappen);
-	prom_halt();
-}
-
-void __init srmmu_frob_mem_map(unsigned long start_mem)
-{
-	should_not_happen();
-}
-
-unsigned long __init srmmu_paging_init(unsigned long start_mem, unsigned long end_mem)
-{
-	should_not_happen();
-	return 0;
-}
-
-void __init ld_mmu_srmmu(void)
-{
-	should_not_happen();
-}
-
-void srmmu_mapioaddr(unsigned long physaddr, unsigned long virt_addr, int bus_type, int rdonly)
-{
-}
-
-void srmmu_unmapioaddr(unsigned long virt_addr)
-{
-}
-
-__u32 iounit_map_dma_init(struct sbus_bus *sbus, int size)
-{
-	return 0;
-}
-
-__u32 iounit_map_dma_page(__u32 vaddr, void *addr, struct sbus_bus *sbus)
-{
-	return 0;
-}
diff --git a/arch/sparc/mm/sun4c.c b/arch/sparc/mm/sun4c.c
index 2375fe9..9c538de 100644
--- a/arch/sparc/mm/sun4c.c
+++ b/arch/sparc/mm/sun4c.c
@@ -31,7 +31,6 @@
 #include <asm/oplib.h>
 #include <asm/openprom.h>
 #include <asm/mmu_context.h>
-#include <asm/sun4paddr.h>
 #include <asm/highmem.h>
 #include <asm/btfixup.h>
 #include <asm/cacheflush.h>
@@ -52,15 +51,11 @@ extern int num_segmaps, num_contexts;
 
 extern unsigned long page_kernel;
 
-#ifdef CONFIG_SUN4
-#define SUN4C_VAC_SIZE sun4c_vacinfo.num_bytes
-#else
 /* That's it, we prom_halt() on sun4c if the cache size is something other than 65536.
  * So let's save some cycles and just use that everywhere except for that bootup
  * sanity check.
  */
 #define SUN4C_VAC_SIZE 65536
-#endif
 
 #define SUN4C_KERNEL_BUCKETS 32
 
@@ -285,71 +280,32 @@ void __init sun4c_probe_vac(void)
 {
 	sun4c_disable_vac();
 
-	if (ARCH_SUN4) {
-		switch (idprom->id_machtype) {
-
-		case (SM_SUN4|SM_4_110):
-			sun4c_vacinfo.type = VAC_NONE;
-			sun4c_vacinfo.num_bytes = 0;
-			sun4c_vacinfo.linesize = 0;
-			sun4c_vacinfo.do_hwflushes = 0;
-			prom_printf("No VAC. Get some bucks and buy a real computer.");
-			prom_halt();
-			break;
-
-		case (SM_SUN4|SM_4_260):
-			sun4c_vacinfo.type = VAC_WRITE_BACK;
-			sun4c_vacinfo.num_bytes = 128 * 1024;
-			sun4c_vacinfo.linesize = 16;
-			sun4c_vacinfo.do_hwflushes = 0;
-			break;
+	sun4c_vacinfo.type = VAC_WRITE_THROUGH;
 
-		case (SM_SUN4|SM_4_330):
-			sun4c_vacinfo.type = VAC_WRITE_THROUGH;
-			sun4c_vacinfo.num_bytes = 128 * 1024;
-			sun4c_vacinfo.linesize = 16;
-			sun4c_vacinfo.do_hwflushes = 0;
-			break;
-
-		case (SM_SUN4|SM_4_470):
-			sun4c_vacinfo.type = VAC_WRITE_BACK;
-			sun4c_vacinfo.num_bytes = 128 * 1024;
-			sun4c_vacinfo.linesize = 32;
-			sun4c_vacinfo.do_hwflushes = 0;
-			break;
-
-		default:
-			prom_printf("Cannot initialize VAC - weird sun4 model idprom->id_machtype = %d", idprom->id_machtype);
-			prom_halt();
-		};
+	if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS1)) ||
+	    (idprom->id_machtype = (SM_SUN4C | SM_4C_SS1PLUS))) {
+		/* PROM on SS1 lacks this info, to be super safe we
+		 * hard code it here since this arch is cast in stone.
+		 */
+		sun4c_vacinfo.num_bytes = 65536;
+		sun4c_vacinfo.linesize = 16;
 	} else {
-		sun4c_vacinfo.type = VAC_WRITE_THROUGH;
+		sun4c_vacinfo.num_bytes +		 prom_getintdefault(prom_root_node, "vac-size", 65536);
+		sun4c_vacinfo.linesize +		 prom_getintdefault(prom_root_node, "vac-linesize", 16);
+	}
+	sun4c_vacinfo.do_hwflushes +	 prom_getintdefault(prom_root_node, "vac-hwflush", 0);
 
-		if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS1)) ||
-		    (idprom->id_machtype = (SM_SUN4C | SM_4C_SS1PLUS))) {
-			/* PROM on SS1 lacks this info, to be super safe we
-			 * hard code it here since this arch is cast in stone.
-			 */
-			sun4c_vacinfo.num_bytes = 65536;
-			sun4c_vacinfo.linesize = 16;
-		} else {
-			sun4c_vacinfo.num_bytes -			 prom_getintdefault(prom_root_node, "vac-size", 65536);
-			sun4c_vacinfo.linesize -			 prom_getintdefault(prom_root_node, "vac-linesize", 16);
-		}
+	if (sun4c_vacinfo.do_hwflushes = 0)
 		sun4c_vacinfo.do_hwflushes -		 prom_getintdefault(prom_root_node, "vac-hwflush", 0);
-
-		if (sun4c_vacinfo.do_hwflushes = 0)
-			sun4c_vacinfo.do_hwflushes -			 prom_getintdefault(prom_root_node, "vac_hwflush", 0);
+		 prom_getintdefault(prom_root_node, "vac_hwflush", 0);
 
-		if (sun4c_vacinfo.num_bytes != 65536) {
-			prom_printf("WEIRD Sun4C VAC cache size, "
-				    "tell sparclinux@vger.kernel.org");
-			prom_halt();
-		}
+	if (sun4c_vacinfo.num_bytes != 65536) {
+		prom_printf("WEIRD Sun4C VAC cache size, "
+			    "tell sparclinux@vger.kernel.org");
+		prom_halt();
 	}
 
 	sun4c_vacinfo.num_lines @@ -447,49 +403,18 @@ static void __init patch_kernel_fault_handler(void)
 
 static void __init sun4c_probe_mmu(void)
 {
-	if (ARCH_SUN4) {
-		switch (idprom->id_machtype) {
-		case (SM_SUN4|SM_4_110):
-			prom_printf("No support for 4100 yet\n");
-			prom_halt();
-			num_segmaps = 256;
-			num_contexts = 8;
-			break;
-
-		case (SM_SUN4|SM_4_260):
-			/* should be 512 segmaps. when it get fixed */
-			num_segmaps = 256;
-			num_contexts = 16;
-			break;
-
-		case (SM_SUN4|SM_4_330):
-			num_segmaps = 256;
-			num_contexts = 16;
-			break;
-
-		case (SM_SUN4|SM_4_470):
-			/* should be 1024 segmaps. when it get fixed */
-			num_segmaps = 256;
-			num_contexts = 64;
-			break;
-		default:
-			prom_printf("Invalid SUN4 model\n");
-			prom_halt();
-		};
+	if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS1)) ||
+	    (idprom->id_machtype = (SM_SUN4C | SM_4C_SS1PLUS))) {
+		/* Hardcode these just to be safe, PROM on SS1 does
+		* not have this info available in the root node.
+		*/
+		num_segmaps = 128;
+		num_contexts = 8;
 	} else {
-		if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS1)) ||
-		    (idprom->id_machtype = (SM_SUN4C | SM_4C_SS1PLUS))) {
-			/* Hardcode these just to be safe, PROM on SS1 does
-		 	* not have this info available in the root node.
-		 	*/
-			num_segmaps = 128;
-			num_contexts = 8;
-		} else {
-			num_segmaps -			    prom_getintdefault(prom_root_node, "mmu-npmg", 128);
-			num_contexts -			    prom_getintdefault(prom_root_node, "mmu-nctx", 0x8);
-		}
+		num_segmaps +		    prom_getintdefault(prom_root_node, "mmu-npmg", 128);
+		num_contexts +		    prom_getintdefault(prom_root_node, "mmu-nctx", 0x8);
 	}
 	patch_kernel_fault_handler();
 }
@@ -501,18 +426,14 @@ void __init sun4c_probe_memerr_reg(void)
 	int node;
 	struct linux_prom_registers regs[1];
 
-	if (ARCH_SUN4) {
-		sun4c_memerr_reg = ioremap(sun4_memreg_physaddr, PAGE_SIZE);
-	} else {
-		node = prom_getchild(prom_root_node);
-		node = prom_searchsiblings(prom_root_node, "memory-error");
-		if (!node)
-			return;
-		if (prom_getproperty(node, "reg", (char *)regs, sizeof(regs)) <= 0)
-			return;
-		/* hmm I think regs[0].which_io is zero here anyways */
-		sun4c_memerr_reg = ioremap(regs[0].phys_addr, regs[0].reg_size);
-	}
+	node = prom_getchild(prom_root_node);
+	node = prom_searchsiblings(prom_root_node, "memory-error");
+	if (!node)
+		return;
+	if (prom_getproperty(node, "reg", (char *)regs, sizeof(regs)) <= 0)
+		return;
+	/* hmm I think regs[0].which_io is zero here anyways */
+	sun4c_memerr_reg = ioremap(regs[0].phys_addr, regs[0].reg_size);
 }
 
 static inline void sun4c_init_ss2_cache_bug(void)
@@ -521,7 +442,6 @@ static inline void sun4c_init_ss2_cache_bug(void)
 
 	if ((idprom->id_machtype = (SM_SUN4C | SM_4C_SS2)) ||
 	    (idprom->id_machtype = (SM_SUN4C | SM_4C_IPX)) ||
-	    (idprom->id_machtype = (SM_SUN4 | SM_4_330)) ||
 	    (idprom->id_machtype = (SM_SUN4C | SM_4C_ELC))) {
 		/* Whee.. */
 		printk("SS2 cache bug detected, uncaching trap table page\n");
@@ -624,11 +544,7 @@ static inline void sun4c_init_map_kernelprom(unsigned long kernel_end)
 {
 	unsigned long vaddr;
 	unsigned char pseg, ctx;
-#ifdef CONFIG_SUN4
-	/* sun4/110 and 260 have no kadb. */
-	if ((idprom->id_machtype != (SM_SUN4 | SM_4_260)) && 
-	    (idprom->id_machtype != (SM_SUN4 | SM_4_110))) {
-#endif
+
 	for (vaddr = KADB_DEBUGGER_BEGVM;
 	     vaddr < LINUX_OPPROM_ENDVM;
 	     vaddr += SUN4C_REAL_PGDIR_SIZE) {
@@ -640,9 +556,7 @@ static inline void sun4c_init_map_kernelprom(unsigned long kernel_end)
 			fix_permissions(vaddr, _SUN4C_PAGE_PRIV, 0);
 		}
 	}
-#ifdef CONFIG_SUN4
-	}
-#endif
+
 	for (vaddr = KERNBASE; vaddr < kernel_end; vaddr += SUN4C_REAL_PGDIR_SIZE) {
 		pseg = sun4c_get_segmap(vaddr);
 		mmu_entry_pool[pseg].locked = 1;
@@ -1048,14 +962,10 @@ static struct thread_info *sun4c_alloc_thread_info(void)
 	 * so we must flush the cache to guarantee consistency.
 	 */
 	sun4c_flush_page(pages);
-#ifndef CONFIG_SUN4	
 	sun4c_flush_page(pages + PAGE_SIZE);
-#endif
 
 	sun4c_put_pte(addr, BUCKET_PTE(pages));
-#ifndef CONFIG_SUN4	
 	sun4c_put_pte(addr + PAGE_SIZE, BUCKET_PTE(pages + PAGE_SIZE));
-#endif
 
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	memset((void *)addr, 0, PAGE_SIZE << THREAD_INFO_ORDER);
@@ -1072,13 +982,11 @@ static void sun4c_free_thread_info(struct thread_info *ti)
 
 	/* We are deleting a mapping, so the flush here is mandatory. */
 	sun4c_flush_page(tiaddr);
-#ifndef CONFIG_SUN4	
 	sun4c_flush_page(tiaddr + PAGE_SIZE);
-#endif
+
 	sun4c_put_pte(tiaddr, 0);
-#ifndef CONFIG_SUN4	
 	sun4c_put_pte(tiaddr + PAGE_SIZE, 0);
-#endif
+
 	sun4c_bucket[entry] = BUCKET_EMPTY;
 	if (entry < sun4c_lowbucket_avail)
 		sun4c_lowbucket_avail = entry;
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 7f5eacf..8f7e185 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -4,5 +4,3 @@
 
 lib-y := bootstr.o devmap.o devops.o init.o memory.o misc.o mp.o \
 	 palloc.o ranges.o segment.o console.o printf.o tree.o
-
-lib-$(CONFIG_SUN4) += sun4prom.o
diff --git a/arch/sparc/prom/bootstr.c b/arch/sparc/prom/bootstr.c
index 5a35c76..9c0cac7 100644
--- a/arch/sparc/prom/bootstr.c
+++ b/arch/sparc/prom/bootstr.c
@@ -28,7 +28,6 @@ prom_getbootargs(void)
 
 	switch(prom_vers) {
 	case PROM_V0:
-	case PROM_SUN4:
 		cp = barg_buf;
 		/* Start from 1 and go over fd(0,0,0)kernel */
 		for(iter = 1; iter < 8; iter++) {
diff --git a/arch/sparc/prom/console.c b/arch/sparc/prom/console.c
index 790057a..e138042 100644
--- a/arch/sparc/prom/console.c
+++ b/arch/sparc/prom/console.c
@@ -30,7 +30,6 @@ prom_nbgetchar(void)
 	spin_lock_irqsave(&prom_lock, flags);
 	switch(prom_vers) {
 	case PROM_V0:
-	case PROM_SUN4:
 		i = (*(romvec->pv_nbgetchar))();
 		break;
 	case PROM_V2:
@@ -63,7 +62,6 @@ prom_nbputchar(char c)
 	spin_lock_irqsave(&prom_lock, flags);
 	switch(prom_vers) {
 	case PROM_V0:
-	case PROM_SUN4:
 		i = (*(romvec->pv_nbputchar))(c);
 		break;
 	case PROM_V2:
diff --git a/arch/sparc/prom/init.c b/arch/sparc/prom/init.c
index 729f870..1149a5d 100644
--- a/arch/sparc/prom/init.c
+++ b/arch/sparc/prom/init.c
@@ -34,10 +34,6 @@ extern void prom_ranges_init(void);
 
 void __init prom_init(struct linux_romvec *rp)
 {
-#ifdef CONFIG_SUN4
-	extern struct linux_romvec *sun4_prom_init(void);
-	rp = sun4_prom_init();
-#endif
 	romvec = rp;
 
 	switch(romvec->pv_romvers) {
@@ -50,9 +46,6 @@ void __init prom_init(struct linux_romvec *rp)
 	case 3:
 		prom_vers = PROM_V3;
 		break;
-	case 40:
-		prom_vers = PROM_SUN4;
-		break;
 	default:
 		prom_printf("PROMLIB: Bad PROM version %d\n",
 			    romvec->pv_romvers);
@@ -76,11 +69,8 @@ void __init prom_init(struct linux_romvec *rp)
 
 	prom_ranges_init();
 
-#ifndef CONFIG_SUN4
-	/* SUN4 prints this in sun4_prom_init */
 	printk("PROMLIB: Sun Boot Prom Version %d Revision %d\n",
 	       romvec->pv_romvers, prom_rev);
-#endif
 
 	/* Initialization successful. */
 	return;
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 947f047..ff6f3a1 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -46,15 +46,6 @@ static int __init prom_meminit_v2(void)
 	return num_ents;
 }
 
-static int __init prom_meminit_sun4(void)
-{
-#ifdef CONFIG_SUN4
-	sp_banks[0].base_addr = 0;
-	sp_banks[0].num_bytes = *(sun4_romvec->memoryavail);
-#endif
-	return 1;
-}
-
 static int sp_banks_cmp(const void *a, const void *b)
 {
 	const struct sparc_phys_banks *x = a, *y = b;
@@ -81,10 +72,6 @@ void __init prom_meminit(void)
 		num_ents = prom_meminit_v2();
 		break;
 
-	case PROM_SUN4:
-		num_ents = prom_meminit_sun4();
-		break;
-
 	default:
 		break;
 	}
diff --git a/arch/sparc/prom/sun4prom.c b/arch/sparc/prom/sun4prom.c
deleted file mode 100644
index 00390a2..0000000
--- a/arch/sparc/prom/sun4prom.c
+++ /dev/null
@@ -1,161 +0,0 @@
-/*
- * Copyright (C) 1996 The Australian National University.
- * Copyright (C) 1996 Fujitsu Laboratories Limited
- * Copyright (C) 1997 Michael A. Griffith (grif@acm.org)
- * Copyright (C) 1997 Sun Weenie (ko@ko.reno.nv.us)
- * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * 
- * This software may be distributed under the terms of the Gnu
- * Public License version 2 or later
- *
- * fake a really simple Sun prom for the SUN4
- */
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <asm/oplib.h>
-#include <asm/idprom.h> 
-#include <asm/machines.h> 
-#include <asm/sun4prom.h>
-#include <asm/asi.h>
-#include <asm/contregs.h>
-#include <linux/init.h>
-
-static struct linux_romvec sun4romvec;
-static struct idprom sun4_idprom;
-
-struct property {
-	char *name;
-	char *value;
-	int length;
-};
-
-struct node {
-	int level;
-	struct property *properties;
-};
-
-struct property null_properties = { NULL, NULL, -1 };
-
-struct property root_properties[] = {
-	{"device_type", "cpu", 4},
-	{"idprom", (char *)&sun4_idprom, sizeof(struct idprom)},
-	{NULL, NULL, -1}
-};
-
-struct node nodes[] = {
-	{ 0, &null_properties }, 
-	{ 0, root_properties },
-	{ -1,&null_properties }
-};
-
-
-static int no_nextnode(int node)
-{
-	if (nodes[node].level = nodes[node+1].level)
-		return node+1;
-	return -1;
-}
-
-static int no_child(int node)
-{
-	if (nodes[node].level = nodes[node+1].level-1)
-		return node+1;
-	return -1;
-}
-
-static struct property *find_property(int node,char *name)
-{
-	struct property *prop = &nodes[node].properties[0];
-	while (prop && prop->name) {
-		if (strcmp(prop->name,name) = 0) return prop;
-		prop++;
-	}
-	return NULL;
-}
-
-static int no_proplen(int node,char *name)
-{
-	struct property *prop = find_property(node,name);
-	if (prop) return prop->length;
-	return -1;
-}
-
-static int no_getprop(int node,char *name,char *value)
-{
-	struct property *prop = find_property(node,name);
-	if (prop) {
-		memcpy(value,prop->value,prop->length);
-		return 1;
-	}
-	return -1;
-}
-
-static int no_setprop(int node,char *name,char *value,int len)
-{
-	return -1;
-}
-
-static char *no_nextprop(int node,char *name)
-{
-	struct property *prop = find_property(node,name);
-	if (prop) return prop[1].name;
-	return NULL;
-}
-
-static struct linux_nodeops sun4_nodeops = {
-	no_nextnode,
-	no_child,
-	no_proplen,
-	no_getprop,
-	no_setprop,
-	no_nextprop
-};
-	
-static int synch_hook;
-
-struct linux_romvec * __init sun4_prom_init(void)
-{
-	int i;
-	unsigned char x;
-	char *p;
-                                
-	p = (char *)&sun4_idprom;
-	for (i = 0; i < sizeof(sun4_idprom); i++) {
-		__asm__ __volatile__ ("lduba [%1] %2, %0" : "=r" (x) :
-				      "r" (AC_IDPROM + i), "i" (ASI_CONTROL));
-		*p++ = x;
-	}
-
-	memset(&sun4romvec,0,sizeof(sun4romvec));
-
-	sun4_romvec = (linux_sun4_romvec *) SUN4_PROM_VECTOR;
-
-	sun4romvec.pv_romvers = 40;
-	sun4romvec.pv_nodeops = &sun4_nodeops;
-	sun4romvec.pv_reboot = sun4_romvec->reboot;
-	sun4romvec.pv_abort = sun4_romvec->abortentry;
-	sun4romvec.pv_halt = sun4_romvec->exittomon;
-	sun4romvec.pv_synchook = (void (**)(void))&synch_hook;
-	sun4romvec.pv_setctxt = sun4_romvec->setcxsegmap;
-	sun4romvec.pv_v0bootargs = sun4_romvec->bootParam;
-	sun4romvec.pv_nbgetchar = sun4_romvec->mayget;
-	sun4romvec.pv_nbputchar = sun4_romvec->mayput;
-	sun4romvec.pv_stdin = sun4_romvec->insource;
-	sun4romvec.pv_stdout = sun4_romvec->outsink;
-	
-	/*
-	 * We turn on the LEDs to let folks without monitors or
-	 * terminals know we booted.   Nothing too fancy now.  They
-	 * are all on, except for LED 5, which blinks.   When we
-	 * have more time, we can teach the penguin to say "By your
-	 * command" or "Activating turbo boost, Michael". :-)
-	 */
-	sun4_romvec->setLEDs(NULL);
-	
-	printk("PROMLIB: Old Sun4 boot PROM monitor %s, romvec version %d\n",
-		sun4_romvec->monid,
-		sun4_romvec->romvecversion);
-
-	return &sun4romvec;
-}
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9bf2986..c487636 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -7,7 +7,6 @@ menuconfig ATA
 	depends on HAS_IOMEM
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
-	depends on !SUN4 || BROKEN
 	select SCSI
 	---help---
 	  If you want to use a ATA hard disk, ATA tape drive, ATA CD-ROM or
diff --git a/drivers/net/sunlance.c b/drivers/net/sunlance.c
index 4e994f8..3854cc2 100644
--- a/drivers/net/sunlance.c
+++ b/drivers/net/sunlance.c
@@ -1498,43 +1498,6 @@ static struct sbus_dma * __devinit find_ledma(struct sbus_dev *sdev)
 	return NULL;
 }
 
-#ifdef CONFIG_SUN4
-
-#include <asm/sun4paddr.h>
-#include <asm/machines.h>
-
-/* Find all the lance cards on the system and initialize them */
-static struct sbus_dev sun4_sdev;
-static int __devinit sparc_lance_init(void)
-{
-	if ((idprom->id_machtype = (SM_SUN4|SM_4_330)) ||
-	    (idprom->id_machtype = (SM_SUN4|SM_4_470))) {
-		memset(&sun4_sdev, 0, sizeof(struct sbus_dev));
-		sun4_sdev.reg_addrs[0].phys_addr = sun4_eth_physaddr;
-		sun4_sdev.irqs[0] = 6;
-		return sparc_lance_probe_one(&sun4_sdev, NULL, NULL);
-	}
-	return -ENODEV;
-}
-
-static int __exit sunlance_sun4_remove(void)
-{
-	struct lance_private *lp = dev_get_drvdata(&sun4_sdev.ofdev.dev);
-	struct net_device *net_dev = lp->dev;
-
-	unregister_netdev(net_dev);
-
-	lance_free_hwresources(lp);
-
-	free_netdev(net_dev);
-
-	dev_set_drvdata(&sun4_sdev.ofdev.dev, NULL);
-
-	return 0;
-}
-
-#else /* !CONFIG_SUN4 */
-
 static int __devinit sunlance_sbus_probe(struct of_device *dev, const struct of_device_id *match)
 {
 	struct sbus_dev *sdev = to_sbus_device(&dev->dev);
@@ -1595,15 +1558,10 @@ static int __init sparc_lance_init(void)
 {
 	return of_register_driver(&sunlance_sbus_driver, &sbus_bus_type);
 }
-#endif /* !CONFIG_SUN4 */
 
 static void __exit sparc_lance_exit(void)
 {
-#ifdef CONFIG_SUN4
-	sunlance_sun4_remove();
-#else
 	of_unregister_driver(&sunlance_sbus_driver);
-#endif
 }
 
 module_init(sparc_lance_init);
diff --git a/drivers/sbus/dvma.c b/drivers/sbus/dvma.c
index ab0d2de..4fc8988 100644
--- a/drivers/sbus/dvma.c
+++ b/drivers/sbus/dvma.c
@@ -101,36 +101,3 @@ void __init dvma_init(struct sbus_bus *sbus)
 		init_one_dvma(dma, num_dma++);
 	}
 }
-
-#ifdef CONFIG_SUN4
-
-#include <asm/sun4paddr.h>
-
-void __init sun4_dvma_init(void)
-{
-	struct sbus_dma *dma;
-	struct resource r;
-
-	if(sun4_dma_physaddr) {
-		dma = kmalloc(sizeof(struct sbus_dma), GFP_ATOMIC);
-
-		/* No SBUS */
-		dma->sdev = NULL;
-
-		/* Only one DMA device */
-		dma_chain = dma;
-
-		memset(&r, 0, sizeof(r));
-		r.start = sun4_dma_physaddr;
-		dma->regs = sbus_ioremap(&r, 0, PAGE_SIZE, "dma");
-
-		/* No prom node */
-		dma->node = 0x0;
-
-		init_one_dvma(dma, 0);
-	} else {
-	  	dma_chain = NULL;
-	}
-}
-
-#endif
diff --git a/include/asm-m68k/sbus.h b/include/asm-m68k/sbus.h
index c8e685a..bfe3ba1 100644
--- a/include/asm-m68k/sbus.h
+++ b/include/asm-m68k/sbus.h
@@ -12,8 +12,6 @@ struct sbus_dev {
 	} reg_addrs[1];
 };
 
-#define ARCH_SUN4  0
-
 /* sbus IO functions stolen from include/asm-sparc/io.h for the serial driver */
 /* No SBUS on the Sun3, kludge -- sam */
 
diff --git a/include/asm-sparc/asmmacro.h b/include/asm-sparc/asmmacro.h
index a619a4d..a995bf8 100644
--- a/include/asm-sparc/asmmacro.h
+++ b/include/asm-sparc/asmmacro.h
@@ -34,12 +34,7 @@
 /* sun4 probably wants half word accesses to ASI_SEGMAP, while sun4c+
    likes byte accesses. These are to avoid ifdef mania. */
 
-#ifdef CONFIG_SUN4
-#define lduXa	lduha
-#define stXa	stha
-#else
 #define lduXa	lduba
 #define stXa	stba
-#endif
 
 #endif /* !(_SPARC_ASMMACRO_H) */
diff --git a/include/asm-sparc/dma.h b/include/asm-sparc/dma.h
index 959d6c8..a537129 100644
--- a/include/asm-sparc/dma.h
+++ b/include/asm-sparc/dma.h
@@ -86,13 +86,10 @@ struct sbus_dma {
 extern struct sbus_dma *dma_chain;
 
 /* Broken hardware... */
-#ifdef CONFIG_SUN4
 /* Have to sort this out. Does rev0 work fine on sun4[cmd] without isbroken?
  * Or is rev0 present only on sun4 boxes? -jj */
-#define DMA_ISBROKEN(dma)    ((dma)->revision = dvmarev0 || (dma)->revision = dvmarev1)
-#else
 #define DMA_ISBROKEN(dma)    ((dma)->revision = dvmarev1)
-#endif
+
 #define DMA_ISESC1(dma)      ((dma)->revision = dvmaesc1)
 
 /* Main routines in dma.c */
diff --git a/include/asm-sparc/elf.h b/include/asm-sparc/elf.h
index d043f80..528789a 100644
--- a/include/asm-sparc/elf.h
+++ b/include/asm-sparc/elf.h
@@ -105,11 +105,8 @@ typedef struct {
 #define ELF_DATA	ELFDATA2MSB
 
 #define USE_ELF_CORE_DUMP
-#ifndef CONFIG_SUN4
+
 #define ELF_EXEC_PAGESIZE	4096
-#else
-#define ELF_EXEC_PAGESIZE	8192
-#endif
 
 
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
diff --git a/include/asm-sparc/mostek.h b/include/asm-sparc/mostek.h
index c35c916..cb503ab 100644
--- a/include/asm-sparc/mostek.h
+++ b/include/asm-sparc/mostek.h
@@ -128,44 +128,6 @@ struct mostek48t08 {
 	struct mostek48t02 regs;     /* Here is what we are interested in.   */
 };
 
-#ifdef CONFIG_SUN4
-enum sparc_clock_type {	MSTK48T02, MSTK48T08, \
-INTERSIL, MSTK_INVALID };
-#else
-enum sparc_clock_type {	MSTK48T02, MSTK48T08, \
-MSTK_INVALID };
-#endif
-
-#ifdef CONFIG_SUN4
-/* intersil on a sun 4/260 code  data from harris doc */
-struct intersil_dt {
-        volatile unsigned char int_csec;
-        volatile unsigned char int_hour;
-        volatile unsigned char int_min;
-        volatile unsigned char int_sec;
-        volatile unsigned char int_month;
-        volatile unsigned char int_day;
-        volatile unsigned char int_year;
-        volatile unsigned char int_dow;
-};
-
-struct intersil {
-	struct intersil_dt clk;
-	struct intersil_dt cmp;
-	volatile unsigned char int_intr_reg;
-	volatile unsigned char int_cmd_reg;
-};
-
-#define INTERSIL_STOP        0x0
-#define INTERSIL_START       0x8
-#define INTERSIL_INTR_DISABLE   0x0
-#define INTERSIL_INTR_ENABLE   0x10
-#define INTERSIL_32K		0x0
-#define INTERSIL_NORMAL		0x0
-#define INTERSIL_24H		0x4 
-#define INTERSIL_INT_100HZ	0x2
-
-/* end of intersil info */
-#endif
+enum sparc_clock_type {	MSTK48T02, MSTK48T08, MSTK_INVALID };
 
 #endif /* !(_SPARC_MOSTEK_H) */
diff --git a/include/asm-sparc/oplib.h b/include/asm-sparc/oplib.h
index 00f487e..7531e17 100644
--- a/include/asm-sparc/oplib.h
+++ b/include/asm-sparc/oplib.h
@@ -21,7 +21,6 @@ enum prom_major_version {
 	PROM_V2,      /* sun4c and early sun4m V2 prom */
 	PROM_V3,      /* sun4m and later, up to sun4d/sun4e machines V3 */
 	PROM_P1275,   /* IEEE compliant ISA based Sun PROM, only sun4u */
-	PROM_SUN4,    /* Old sun4 proms are totally different, but we'll shoehorn it to make it fit */
 };
 
 extern enum prom_major_version prom_vers;
diff --git a/include/asm-sparc/page.h b/include/asm-sparc/page.h
index 14de518..d5f4607 100644
--- a/include/asm-sparc/page.h
+++ b/include/asm-sparc/page.h
@@ -8,11 +8,8 @@
 #ifndef _SPARC_PAGE_H
 #define _SPARC_PAGE_H
 
-#ifdef CONFIG_SUN4
-#define PAGE_SHIFT   13
-#else
 #define PAGE_SHIFT   12
-#endif
+
 #ifndef __ASSEMBLY__
 /* I have my suspicions... -DaveM */
 #define PAGE_SIZE    (1UL << PAGE_SHIFT)
diff --git a/include/asm-sparc/pgtable.h b/include/asm-sparc/pgtable.h
index 6051229..b5f2754 100644
--- a/include/asm-sparc/pgtable.h
+++ b/include/asm-sparc/pgtable.h
@@ -13,11 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/swap.h>
 #include <asm/types.h>
-#ifdef CONFIG_SUN4
-#include <asm/pgtsun4.h>
-#else
 #include <asm/pgtsun4c.h>
-#endif
 #include <asm/pgtsrmmu.h>
 #include <asm/vac-ops.h>
 #include <asm/oplib.h>
diff --git a/include/asm-sparc/sun4paddr.h b/include/asm-sparc/sun4paddr.h
deleted file mode 100644
index d52985f..0000000
--- a/include/asm-sparc/sun4paddr.h
+++ /dev/null
@@ -1,56 +0,0 @@
-/*
- * sun4paddr.h:  Various physical addresses on sun4 machines
- *
- * Copyright (C) 1997 Anton Blanchard (anton@progsoc.uts.edu.au)
- * Copyright (C) 1998 Chris Davis (cdavis@cois.on.ca)
- * 
- * Now supports more sun4's
- */
-
-#ifndef _SPARC_SUN4PADDR_H
-#define _SPARC_SUN4PADDR_H
-
-#define SUN4_IE_PHYSADDR		0xf5000000
-#define SUN4_UNUSED_PHYSADDR		0
-
-/* these work for me */
-#define SUN4_200_MEMREG_PHYSADDR	0xf4000000
-#define SUN4_200_CLOCK_PHYSADDR		0xf3000000
-#define SUN4_200_BWTWO_PHYSADDR		0xfd000000
-#define SUN4_200_ETH_PHYSADDR		0xf6000000
-#define SUN4_200_SI_PHYSADDR		0xff200000
-
-/* these were here before */
-#define SUN4_300_MEMREG_PHYSADDR	0xf4000000
-#define SUN4_300_CLOCK_PHYSADDR		0xf2000000
-#define SUN4_300_TIMER_PHYSADDR		0xef000000
-#define SUN4_300_ETH_PHYSADDR		0xf9000000
-#define SUN4_300_BWTWO_PHYSADDR		0xfb400000
-#define SUN4_300_DMA_PHYSADDR		0xfa001000
-#define SUN4_300_ESP_PHYSADDR		0xfa000000
-
-/* Are these right? */
-#define SUN4_400_MEMREG_PHYSADDR	0xf4000000
-#define SUN4_400_CLOCK_PHYSADDR		0xf2000000
-#define SUN4_400_TIMER_PHYSADDR		0xef000000
-#define SUN4_400_ETH_PHYSADDR		0xf9000000
-#define SUN4_400_BWTWO_PHYSADDR		0xfb400000
-#define SUN4_400_DMA_PHYSADDR		0xfa001000
-#define SUN4_400_ESP_PHYSADDR		0xfa000000
-
-/* 
-	these are the actual values set and used in the code. Unused items set 
-	to SUN_UNUSED_PHYSADDR 
- */
-
-extern int sun4_memreg_physaddr; /* memory register (ecc?) */
-extern int sun4_clock_physaddr;  /* system clock */
-extern int sun4_timer_physaddr;  /* timer, where applicable */
-extern int sun4_eth_physaddr;    /* onboard ethernet (ie/le) */
-extern int sun4_si_physaddr;     /* sun3 scsi adapter */
-extern int sun4_bwtwo_physaddr;  /* onboard bw2 */
-extern int sun4_dma_physaddr;    /* scsi dma */
-extern int sun4_esp_physaddr;    /* esp scsi */
-extern int sun4_ie_physaddr;     /* interrupt enable */
-
-#endif /* !(_SPARC_SUN4PADDR_H) */
diff --git a/include/asm-sparc/system.h b/include/asm-sparc/system.h
index b4b0244..c010a39 100644
--- a/include/asm-sparc/system.h
+++ b/include/asm-sparc/system.h
@@ -34,13 +34,7 @@ enum sparc_cpu {
 
 extern enum sparc_cpu sparc_cpu_model;
 
-#ifndef CONFIG_SUN4
 #define ARCH_SUN4C_SUN4 (sparc_cpu_model=sun4c)
-#define ARCH_SUN4 0
-#else
-#define ARCH_SUN4C_SUN4 1
-#define ARCH_SUN4 1
-#endif
 
 #define SUN4M_NCPUS            4              /* Architectural limit of sun4m. */
 
diff --git a/include/asm-sparc/timer.h b/include/asm-sparc/timer.h
index 361e538..44f7d21 100644
--- a/include/asm-sparc/timer.h
+++ b/include/asm-sparc/timer.h
@@ -9,7 +9,6 @@
 #define _SPARC_TIMER_H
 
 #include <asm/system.h>  /* For SUN4M_NCPUS */
-#include <asm/sun4paddr.h>
 #include <asm/btfixup.h>
 
 /* Timer structures. The interrupt timer has two properties which
@@ -34,12 +33,7 @@ struct sun4c_timer_info {
   __volatile__ unsigned int timer_limit14;
 };
 
-#define SUN4C_TIMER_PHYSADDR   0xf3000000
-#ifdef CONFIG_SUN4
-#define SUN_TIMER_PHYSADDR SUN4_300_TIMER_PHYSADDR
-#else
-#define SUN_TIMER_PHYSADDR SUN4C_TIMER_PHYSADDR
-#endif
+#define SUN_TIMER_PHYSADDR 0xf3000000
 
 /* A sun4m has two blocks of registers which are probably of the same
  * structure. LSI Logic's L64851 is told to _decrement_ from the limit
diff --git a/include/asm-sparc/vac-ops.h b/include/asm-sparc/vac-ops.h
index d105276..17b45c3 100644
--- a/include/asm-sparc/vac-ops.h
+++ b/include/asm-sparc/vac-ops.h
@@ -76,11 +76,7 @@
  * cacheable bit in the pte's of all such pages.
  */
 
-#ifdef CONFIG_SUN4
-#define S4CVAC_BADBITS     0x0001e000
-#else
 #define S4CVAC_BADBITS    0x0000f000
-#endif
 
 /* The following is true if vaddr1 and vaddr2 would cause
  * a 'bad alias'.
diff --git a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
index 6897ac3..4a6c998 100644
--- a/include/asm-sparc64/system.h
+++ b/include/asm-sparc64/system.h
@@ -26,9 +26,8 @@ enum sparc_cpu {
                   
 #define sparc_cpu_model sun4u
 
-/* This cannot ever be a sun4c nor sun4 :) That's just history. */
+/* This cannot ever be a sun4c :) That's just history. */
 #define ARCH_SUN4C_SUN4 0
-#define ARCH_SUN4 0
 
 extern char reboot_command[];
 

