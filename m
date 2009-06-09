From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 09 Jun 2009 11:22:04 +0000
Subject: [PATCH 3/7] Introduce the sparc-leon CPU type.
Message-Id: <4A2E45DC.8050802@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030605050807020409080900"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------030605050807020409080900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From 6452f2ae1e76df7593175c73bd5248dbcbf5d212 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:57:32 +0200
Subject: [PATCH 3/7] Introduce the sparc-leon CPU type. Add sparc_leon enum,
M_LEON|M_LEON3_SOC machine. Add compilation of leon.c
in mm and kernel if CONFIG_LEON is defined. Add sparc_leon
dependent initialization to switch statements + head.S.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
  arch/sparc/include/asm/machines.h  |    6 +++++-
  arch/sparc/include/asm/system_32.h |    1 +
  arch/sparc/kernel/Makefile         |    2 ++
  arch/sparc/kernel/cpu.c            |    5 +++++
  arch/sparc/kernel/head_32.S        |    8 ++++++++
  arch/sparc/kernel/idprom.c         |    2 ++
  arch/sparc/kernel/irq_32.c         |    5 +++++
  arch/sparc/kernel/setup_32.c       |    5 +++++
  arch/sparc/mm/Makefile             |    1 +
  arch/sparc/mm/init_32.c            |    1 +
  arch/sparc/mm/loadmmu.c            |    1 +
  11 files changed, 36 insertions(+), 1 deletions(-)

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
@@ -30,6 +30,7 @@ #define NUM_SUN_MACHINES   15

  #define SM_ARCH_MASK  0xf0
  #define SM_SUN4       0x20
+#define  M_LEON       0x30
  #define SM_SUN4C      0x50
  #define SM_SUN4M      0x70
  #define SM_SUN4M_OBP  0x80
@@ -41,6 +42,9 @@ #define SM_4_110      0x02    /* Sun 4/1
  #define SM_4_330      0x03    /* Sun 4/300 series */
  #define SM_4_470      0x04    /* Sun 4/400 series */

+/* Leon machines */
+#define M_LEON3_SOC   0x02    /* Leon3 SoC */
+
  /* Sun4c machines                Full Name              - PROM NAME */
  #define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
  #define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
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
index 54742e5..b2da23f 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -40,6 +40,8 @@ obj-y                   += prom_$(BITS).
  obj-y                   += of_device_$(BITS).o
  obj-$(CONFIG_SPARC64)   += prom_irqtrans.o

+obj-$(CONFIG_LEON)      += leon.o
+
  obj-$(CONFIG_SPARC64)   += reboot.o
  obj-$(CONFIG_SPARC64)   += sysfs.o
  obj-$(CONFIG_SPARC64)   += iommu.o
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index d85c3dc..07e9d71 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -312,7 +312,12 @@ void __cpuinit cpu_probe(void)

  	psr = get_psr();
  	put_psr(psr | PSR_EF);
+#ifdef CONFIG_LEON
+	fpu_vers = 7;
+#else
  	fpu_vers = ((get_fsr() >> 17) & 0x7);
+#endif
+
  	put_psr(psr);

  	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index f0b4b51..84f8138 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -814,6 +814,10 @@ got_prop:

  		cmp	%l1, ' '
  		be	1f
+#if defined(CONFIG_LEON)
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	1f
+#endif
  		 cmp	%l1, 'c'
  		be	1f
  		 cmp	%l1, 'm'
@@ -836,6 +840,10 @@ got_prop:
  		be	sun4m_init
  		 cmp	%l1, 'd'		! Let us see how the beast will die
  		be	sun4d_init
+#if defined(CONFIG_LEON)
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	sun4c_continue_boot
+#endif
  		 nop

  		/* Jump into mmu context zero. */
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 57922f6..6dc677a 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -31,6 +31,8 @@ static struct Sun_Machine_Models Sun_Mac
  { .name = "Sun 4/200 Series",        .id_machtype = (SM_SUN4 | SM_4_260) },
  { .name = "Sun 4/300 Series",        .id_machtype = (SM_SUN4 | SM_4_330) },
  { .name = "Sun 4/400 Series",        .id_machtype = (SM_SUN4 | SM_4_470) },
+/* Now Leon */
+{ "Leon3 System-on-a-Chip",          .id_machtype = (M_LEON | M_LEON3_SOC) },
  /* Now, Sun4c's */
  { .name = "Sun4c SparcStation 1",    .id_machtype = (SM_SUN4C | SM_4C_SS1) },
  { .name = "Sun4c SparcStation IPC",  .id_machtype = (SM_SUN4C | SM_4C_IPC) },
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index ad800b8..34d9cff 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -639,6 +639,7 @@ void __init init_IRQ(void)
  	extern void sun4c_init_IRQ( void );
  	extern void sun4m_init_IRQ( void );
  	extern void sun4d_init_IRQ( void );
+	extern void leon_init_IRQ(void);

  	switch(sparc_cpu_model) {
  	case sun4c:
@@ -661,6 +662,10 @@ #endif
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
index 998cadb..09c092d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -235,6 +235,8 @@ void __init setup_arch(char **cmdline_p)
  		sparc_cpu_model = sun4e;
  	if (!strcmp(&cputypval,"sun4u"))
  		sparc_cpu_model = sun4u;
+	if (!strcmp(&cputypval, "leon2"))
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
index 681abe0..14fcefe 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SPARC32)   += loadmmu.o
  obj-y                   += generic_$(BITS).o
  obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
  obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
+obj-$(CONFIG_LEON)      += leon.o

  # Only used by sparc64
  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 26bb391..b4ef3e4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -328,6 +328,7 @@ void __init paging_init(void)
  		break;
  	case sun4m:
  	case sun4d:
+	case sparc_leon:
  		srmmu_paging_init();
  		sparc_unmapped_base = 0x50000000;
  		BTFIXUPSET_SETHI(sparc_unmapped_base, 0x50000000);
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
1.4.2.1


--------------030605050807020409080900
Content-Type: text/plain;
 name="0003-Introduce-the-sparc-leon-CPU-type.-Add-sparc_leon-enum.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0003-Introduce-the-sparc-leon-CPU-type.-Add-sparc_leon-enum.";
 filename*1="txt"

From 6452f2ae1e76df7593175c73bd5248dbcbf5d212 Mon Sep 17 00:00:00 2001
From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 9 Jun 2009 12:57:32 +0200
Subject: [PATCH 3/7] Introduce the sparc-leon CPU type. Add sparc_leon enum,
M_LEON|M_LEON3_SOC machine. Add compilation of leon.c
in mm and kernel if CONFIG_LEON is defined. Add sparc_leon
dependent initialization to switch statements + head.S.

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/machines.h  |    6 +++++-
 arch/sparc/include/asm/system_32.h |    1 +
 arch/sparc/kernel/Makefile         |    2 ++
 arch/sparc/kernel/cpu.c            |    5 +++++
 arch/sparc/kernel/head_32.S        |    8 ++++++++
 arch/sparc/kernel/idprom.c         |    2 ++
 arch/sparc/kernel/irq_32.c         |    5 +++++
 arch/sparc/kernel/setup_32.c       |    5 +++++
 arch/sparc/mm/Makefile             |    1 +
 arch/sparc/mm/init_32.c            |    1 +
 arch/sparc/mm/loadmmu.c            |    1 +
 11 files changed, 36 insertions(+), 1 deletions(-)

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
@@ -30,6 +30,7 @@ #define NUM_SUN_MACHINES   15
 
 #define SM_ARCH_MASK  0xf0
 #define SM_SUN4       0x20
+#define  M_LEON       0x30
 #define SM_SUN4C      0x50
 #define SM_SUN4M      0x70
 #define SM_SUN4M_OBP  0x80
@@ -41,6 +42,9 @@ #define SM_4_110      0x02    /* Sun 4/1
 #define SM_4_330      0x03    /* Sun 4/300 series */
 #define SM_4_470      0x04    /* Sun 4/400 series */
 
+/* Leon machines */
+#define M_LEON3_SOC   0x02    /* Leon3 SoC */
+
 /* Sun4c machines                Full Name              - PROM NAME */
 #define SM_4C_SS1     0x01    /* Sun4c SparcStation 1   - Sun 4/60  */
 #define SM_4C_IPC     0x02    /* Sun4c SparcStation IPC - Sun 4/40  */
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
index 54742e5..b2da23f 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -40,6 +40,8 @@ obj-y                   += prom_$(BITS).
 obj-y                   += of_device_$(BITS).o
 obj-$(CONFIG_SPARC64)   += prom_irqtrans.o
 
+obj-$(CONFIG_LEON)      += leon.o
+
 obj-$(CONFIG_SPARC64)   += reboot.o
 obj-$(CONFIG_SPARC64)   += sysfs.o
 obj-$(CONFIG_SPARC64)   += iommu.o
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index d85c3dc..07e9d71 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -312,7 +312,12 @@ void __cpuinit cpu_probe(void)
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
+#ifdef CONFIG_LEON
+	fpu_vers = 7;
+#else
 	fpu_vers = ((get_fsr() >> 17) & 0x7);
+#endif
+
 	put_psr(psr);
 
 	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index f0b4b51..84f8138 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -814,6 +814,10 @@ got_prop:
 
 		cmp	%l1, ' '
 		be	1f
+#if defined(CONFIG_LEON)
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	1f
+#endif
 		 cmp	%l1, 'c'
 		be	1f
 		 cmp	%l1, 'm'
@@ -836,6 +840,10 @@ got_prop:
 		be	sun4m_init
 		 cmp	%l1, 'd'		! Let us see how the beast will die
 		be	sun4d_init
+#if defined(CONFIG_LEON)
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	sun4c_continue_boot
+#endif
 		 nop
 
 		/* Jump into mmu context zero. */
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 57922f6..6dc677a 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -31,6 +31,8 @@ static struct Sun_Machine_Models Sun_Mac
 { .name = "Sun 4/200 Series",        .id_machtype = (SM_SUN4 | SM_4_260) },
 { .name = "Sun 4/300 Series",        .id_machtype = (SM_SUN4 | SM_4_330) },
 { .name = "Sun 4/400 Series",        .id_machtype = (SM_SUN4 | SM_4_470) },
+/* Now Leon */
+{ "Leon3 System-on-a-Chip",          .id_machtype = (M_LEON | M_LEON3_SOC) },
 /* Now, Sun4c's */
 { .name = "Sun4c SparcStation 1",    .id_machtype = (SM_SUN4C | SM_4C_SS1) },
 { .name = "Sun4c SparcStation IPC",  .id_machtype = (SM_SUN4C | SM_4C_IPC) },
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index ad800b8..34d9cff 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -639,6 +639,7 @@ void __init init_IRQ(void)
 	extern void sun4c_init_IRQ( void );
 	extern void sun4m_init_IRQ( void );
 	extern void sun4d_init_IRQ( void );
+	extern void leon_init_IRQ(void);
 
 	switch(sparc_cpu_model) {
 	case sun4c:
@@ -661,6 +662,10 @@ #endif
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
index 998cadb..09c092d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -235,6 +235,8 @@ void __init setup_arch(char **cmdline_p)
 		sparc_cpu_model = sun4e;
 	if (!strcmp(&cputypval,"sun4u"))
 		sparc_cpu_model = sun4u;
+	if (!strcmp(&cputypval, "leon2"))
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
index 681abe0..14fcefe 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SPARC32)   += loadmmu.o
 obj-y                   += generic_$(BITS).o
 obj-$(CONFIG_SPARC32)   += extable.o btfixup.o srmmu.o iommu.o io-unit.o
 obj-$(CONFIG_SPARC32)   += hypersparc.o viking.o tsunami.o swift.o
+obj-$(CONFIG_LEON)      += leon.o
 
 # Only used by sparc64
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index 26bb391..b4ef3e4 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -328,6 +328,7 @@ void __init paging_init(void)
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		srmmu_paging_init();
 		sparc_unmapped_base = 0x50000000;
 		BTFIXUPSET_SETHI(sparc_unmapped_base, 0x50000000);
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
1.4.2.1


--------------030605050807020409080900--
