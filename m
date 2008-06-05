From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:26:16 +0000
Subject: [RFC: 2.6 patch] sparc/kernel/: possible cleanups
Message-Id: <20080605182547.GG1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global code static:
  - apc.c: apc_swift_idle()
  - ebus.c: ebus_blacklist_irq()
  - ebus.c: fill_ebus_child()
  - ebus.c: fill_ebus_device()
  - entry.S: syscall_is_too_hard
  - etra: tsetup_sun4c_stackchk
  - head.S: cputyp
  - head.S: prom_vector_p
  - idprom.c: Sun_Machines[]
  - ioport.c: _sparc_find_resource()
  - ioport.c: create_proc_read_entry()
  - irq.c: struct sparc_irq[]
  - rtrap.S: sun4c_rett_stackchk
  - setup.c: prom_sync_me()
  - setup.c: boot_flags
  - sun4c_irq.c: sun4c_sbint_to_irq()
  - sun4d_irq.c: sbus_tid[]
  - sun4d_irq.c: struct sbus_actions
  - sun4d_irq.c: sun4d_sbint_to_irq()
  - sun4m_irq.c: sun4m_sbint_to_irq()
  - sun4m_irq.c: sun4m_get_irqmask()
  - sun4m_irq.c: sun4m_timers
  - sun4m_smp.c: smp4m_cross_call()
  - sun4m_smp.c: smp4m_blackbox_id()
  - sun4m_smp.c: smp4m_blackbox_current()
  - time.c: sp_clock_typ
  - time.c: sbus_time_init()
  - traps.c: instruction_dump()
  - wof.S: spwin_sun4c_stackchk
  - wuf.S: sun4c_fwin_stackchk
- #if 0 the following unused code:
  - process.c: sparc_backtrace_lock
  - process.c: __show_backtrace()
  - process.c: show_backtrace()
  - process.c: smp_show_backtrace_all_cpus()
- remove the following unused code:
  - entry.S: __handle_exception
  - smp.c: smp_num_cpus
  - smp.c: smp_activated
  - smp.c: __cpu_number_map[]
  - smp.c: __cpu_logical_map[]
  - smp.c: bitops_spinlock
  - traps.c: trap_curbuf
  - traps.c: trapbuf[]
  - traps.c: linux_smp_still_initting
  - traps.c: thiscpus_tbr
  - traps.c: thiscpus_mid

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc/kernel/apc.c       |    2 +-
 arch/sparc/kernel/ebus.c      |    9 +++++----
 arch/sparc/kernel/entry.S     |    4 +---
 arch/sparc/kernel/etrap.S     |    1 -
 arch/sparc/kernel/head.S      |    2 --
 arch/sparc/kernel/idprom.c    |    2 +-
 arch/sparc/kernel/ioport.c    |   13 +++++++------
 arch/sparc/kernel/irq.c       |    2 +-
 arch/sparc/kernel/process.c   |    3 ++-
 arch/sparc/kernel/rtrap.S     |    2 --
 arch/sparc/kernel/setup.c     |    4 ++--
 arch/sparc/kernel/smp.c       |    7 -------
 arch/sparc/kernel/sun4c_irq.c |    3 ++-
 arch/sparc/kernel/sun4d_irq.c |    7 ++++---
 arch/sparc/kernel/sun4m_irq.c |    7 ++++---
 arch/sparc/kernel/sun4m_smp.c |    9 +++++----
 arch/sparc/kernel/time.c      |    4 ++--
 arch/sparc/kernel/traps.c     |    9 +--------
 arch/sparc/kernel/wof.S       |    1 -
 arch/sparc/kernel/wuf.S       |    1 -
 include/asm-sparc/machines.h  |    2 --
 include/asm-sparc/mostek.h    |    2 --
 include/asm-sparc/timer.h     |    2 --
 23 files changed, 38 insertions(+), 60 deletions(-)

998ec463cdd4e5edc7a788a2a3da7f7a767f0505 diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index d06a405..3935283 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -55,7 +55,7 @@ __setup("apc=", apc_setup);
  * CPU idle callback function
  * See .../arch/sparc/kernel/process.c
  */
-void apc_swift_idle(void)
+static void apc_swift_idle(void)
 {
 #ifdef APC_DEBUG_LED
 	set_auxio(0x00, AUXIO_LED); 
diff --git a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
index 92c6fc0..9729423 100644
--- a/arch/sparc/kernel/ebus.c
+++ b/arch/sparc/kernel/ebus.c
@@ -69,7 +69,7 @@ static inline unsigned long ebus_alloc(size_t size)
 
 /*
  */
-int __init ebus_blacklist_irq(const char *name)
+static int __init ebus_blacklist_irq(const char *name)
 {
 	struct ebus_device_irq *dp;
 
@@ -83,8 +83,8 @@ int __init ebus_blacklist_irq(const char *name)
 	return 0;
 }
 
-void __init fill_ebus_child(struct device_node *dp,
-			    struct linux_ebus_child *dev)
+static void __init fill_ebus_child(struct device_node *dp,
+				   struct linux_ebus_child *dev)
 {
 	const int *regs;
 	const int *irqs;
@@ -144,7 +144,8 @@ void __init fill_ebus_child(struct device_node *dp,
 	}
 }
 
-void __init fill_ebus_device(struct device_node *dp, struct linux_ebus_device *dev)
+static void __init fill_ebus_device(struct device_node *dp,
+				    struct linux_ebus_device *dev)
 {
 	const struct linux_prom_registers *regs;
 	struct linux_ebus_child *child;
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 4bcfe54..55d3be1 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1317,7 +1317,6 @@ linux_sparc_syscall:
 	bne	linux_fast_syscall
 	 /* Just do first insn from SAVE_ALL in the delay slot */
 
-	.globl	syscall_is_too_hard
 syscall_is_too_hard:
 	SAVE_ALL_HEAD
 	 rd	%wim, %l3
@@ -1544,8 +1543,7 @@ kgdb_trap_low:
 #endif
 
 	.align	4
-	.globl	__handle_exception, flush_patch_exception
-__handle_exception:
+	.globl	flush_patch_exception
 flush_patch_exception:
 	FLUSH_ALL_KERNEL_WINDOWS;
 	ldd	[%o0], %o6
diff --git a/arch/sparc/kernel/etrap.S b/arch/sparc/kernel/etrap.S
index f37d961..e806fcd 100644
--- a/arch/sparc/kernel/etrap.S
+++ b/arch/sparc/kernel/etrap.S
@@ -228,7 +228,6 @@ tsetup_mmu_patchme:
 	 */
 #define glob_tmp     g1
 
-	.globl	tsetup_sun4c_stackchk
 tsetup_sun4c_stackchk:
 	/* Done by caller: andcc %sp, 0x7, %g0 */
 	bne	trap_setup_user_stack_is_bolixed
diff --git a/arch/sparc/kernel/head.S b/arch/sparc/kernel/head.S
index 3bfd608..50d9a16 100644
--- a/arch/sparc/kernel/head.S
+++ b/arch/sparc/kernel/head.S
@@ -32,7 +32,6 @@
  */
 
 	.align 4
-        .globl  cputyp
 cputyp:
         .word   1
 
@@ -1280,7 +1279,6 @@ halt_me:
  * gets initialized in c-code so all routines can use it.
  */
 
-	.globl	prom_vector_p
 prom_vector_p:
 		.word 0
 
diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 7220562..fc511f3 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -24,7 +24,7 @@ static struct idprom idprom_buffer;
  * of the Sparc CPU and have a meaningful IDPROM machtype value that we
  * know about.  See asm-sparc/machines.h for empirical constants.
  */
-struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
+static struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES] = {
 /* First, Sun4's */
 { "Sun 4/100 Series", (SM_SUN4 | SM_4_110) },
 { "Sun 4/200 Series", (SM_SUN4 | SM_4_260) },
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7b17522..4879609 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -49,13 +49,16 @@
 
 #define mmu_inval_dma_area(p, l)	/* Anton pulled it out for 2.4.0-xx */
 
-struct resource *_sparc_find_resource(struct resource *r, unsigned long);
+static struct resource *_sparc_find_resource(struct resource *r,
+					     unsigned long);
 
 static void __iomem *_sparc_ioremap(struct resource *res, u32 bus, u32 pa, int sz);
 static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
     unsigned long size, char *name);
 static void _sparc_free_io(struct resource *res);
 
+static void register_proc_sparc_ioport(void);
+
 /* This points to the next to use virtual memory for DVMA mappings */
 static struct resource _sparc_dvma = {
 	.name = "sparc_dvma", .start = DVMA_VADDR, .end = DVMA_END - 1
@@ -539,8 +542,6 @@ void __init sbus_setup_arch_props(struct sbus_bus *sbus, struct device_node *dp)
 
 int __init sbus_arch_preinit(void)
 {
-	extern void register_proc_sparc_ioport(void);
-
 	register_proc_sparc_ioport();
 
 #ifdef CONFIG_SUN4
@@ -853,8 +854,8 @@ _sparc_io_get_info(char *buf, char **start, off_t fpos, int length, int *eof,
  * XXX Too slow. Can have 8192 DVMA pages on sun4m in the worst case.
  * This probably warrants some sort of hashing.
  */
-struct resource *
-_sparc_find_resource(struct resource *root, unsigned long hit)
+static struct resource *_sparc_find_resource(struct resource *root,
+					     unsigned long hit)
 {
         struct resource *tmp;
 
@@ -865,7 +866,7 @@ _sparc_find_resource(struct resource *root, unsigned long hit)
 	return NULL;
 }
 
-void register_proc_sparc_ioport(void)
+static void register_proc_sparc_ioport(void)
 {
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("io_map",0,NULL,_sparc_io_get_info,&sparc_iomap);
diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
index 087390b..93e1d1c 100644
--- a/arch/sparc/kernel/irq.c
+++ b/arch/sparc/kernel/irq.c
@@ -154,7 +154,7 @@ void (*sparc_init_timers)(irq_handler_t )  struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 int static_irq_count;
 
-struct {
+static struct {
 	struct irqaction *action;
 	int flags;
 } sparc_irq[NR_IRQS];
diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index da48d24..e18a5da 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -177,6 +177,8 @@ void machine_power_off(void)
 	machine_halt();
 }
 
+#if 0
+
 static DEFINE_SPINLOCK(sparc_backtrace_lock);
 
 void __show_backtrace(unsigned long fp)
@@ -228,7 +230,6 @@ void smp_show_backtrace_all_cpus(void)
 }
 #endif
 
-#if 0
 void show_stackframe(struct sparc_stackf *sf)
 {
 	unsigned long size;
diff --git a/arch/sparc/kernel/rtrap.S b/arch/sparc/kernel/rtrap.S
index ce30082..891f460 100644
--- a/arch/sparc/kernel/rtrap.S
+++ b/arch/sparc/kernel/rtrap.S
@@ -224,8 +224,6 @@ ret_trap_user_stack_is_bolixed:
 	b	signal_p
 	 ld	[%curptr + TI_FLAGS], %g2
 
-
-	.globl	sun4c_rett_stackchk
 sun4c_rett_stackchk:
 	be	1f
 	 and	%fp, 0xfff, %g1		! delay slot
diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index a0ea0bc..9e451b2 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -67,7 +67,7 @@ struct screen_info screen_info = {
 extern unsigned long trapbase;
 
 /* Pretty sick eh? */
-void prom_sync_me(void)
+static void prom_sync_me(void)
 {
 	unsigned long prom_tbr, flags;
 
@@ -97,7 +97,7 @@ void prom_sync_me(void)
 	return;
 }
 
-unsigned int boot_flags __initdata = 0;
+static unsigned int boot_flags __initdata = 0;
 #define BOOTME_DEBUG  0x1
 
 /* Exported for mm/init.c:paging_init. */
diff --git a/arch/sparc/kernel/smp.c b/arch/sparc/kernel/smp.c
index 6724ab9..1619ec1 100644
--- a/arch/sparc/kernel/smp.c
+++ b/arch/sparc/kernel/smp.c
@@ -35,13 +35,9 @@
 
 #include "irq.h"
 
-int smp_num_cpus = 1;
 volatile unsigned long cpu_callin_map[NR_CPUS] __initdata = {0,};
 unsigned char boot_cpu_id = 0;
 unsigned char boot_cpu_id4 = 0; /* boot_cpu_id << 2 */
-int smp_activated = 0;
-volatile int __cpu_number_map[NR_CPUS];
-volatile int __cpu_logical_map[NR_CPUS];
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
@@ -55,9 +51,6 @@ cpumask_t smp_commenced_mask = CPU_MASK_NONE;
  * instruction which is much better...
  */
 
-/* Used to make bitops atomic */
-unsigned char bitops_spinlock = 0;
-
 void __cpuinit smp_store_cpu_info(int id)
 {
 	int cpu_node;
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index c6ac9fc..340fc39 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -68,7 +68,8 @@ unsigned char *interrupt_enable = NULL;
 
 static int sun4c_pil_map[] = { 0, 1, 2, 3, 5, 7, 8, 9 };
 
-unsigned int sun4c_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint)
+static unsigned int sun4c_sbint_to_irq(struct sbus_dev *sdev,
+				       unsigned int sbint)
 {
 	if (sbint >= sizeof(sun4c_pil_map)) {
 		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 8ac5661..1290b59 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -52,13 +52,13 @@ extern struct irqaction static_irqaction[MAX_STATIC_ALLOC];
 extern int static_irq_count;
 unsigned char cpu_leds[32];
 #ifdef CONFIG_SMP
-unsigned char sbus_tid[32];
+static unsigned char sbus_tid[32];
 #endif
 
 static struct irqaction *irq_action[NR_IRQS];
 extern spinlock_t irq_action_lock;
 
-struct sbus_action {
+static struct sbus_action {
 	struct irqaction *action;
 	/* For SMP this needs to be extended */
 } *sbus_actions;
@@ -267,7 +267,8 @@ unsigned int sun4d_build_irq(struct sbus_dev *sdev, int irq)
 		return irq;
 }
 
-unsigned int sun4d_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint)
+static unsigned int sun4d_sbint_to_irq(struct sbus_dev *sdev,
+				       unsigned int sbint)
 {
 	if (sbint >= sizeof(sbus_to_pil)) {
 		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index b92d6d2..7814987 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -154,7 +154,8 @@ static unsigned long irq_mask[] = {
 
 static int sun4m_pil_map[] = { 0, 2, 3, 5, 7, 9, 11, 13 };
 
-unsigned int sun4m_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint) 
+static unsigned int sun4m_sbint_to_irq(struct sbus_dev *sdev,
+				       unsigned int sbint) 
 {
 	if (sbint >= sizeof(sun4m_pil_map)) {
 		printk(KERN_ERR "%s: bogus SBINT %d\n", sdev->prom_name, sbint);
@@ -163,7 +164,7 @@ unsigned int sun4m_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint)
 	return sun4m_pil_map[sbint] | 0x30;
 }
 
-inline unsigned long sun4m_get_irqmask(unsigned int irq)
+static unsigned long sun4m_get_irqmask(unsigned int irq)
 {
 	unsigned long mask;
     
@@ -281,7 +282,7 @@ static void sun4m_set_udt(int cpu)
 #define TIMER_IRQ  	(OBIO_INTR | 10)
 #define PROFILE_IRQ	(OBIO_INTR | 14)
 
-struct sun4m_timer_regs *sun4m_timers;
+static struct sun4m_timer_regs *sun4m_timers;
 unsigned int lvl14_resolution = (((1000000/HZ) + 1) << 10);
 
 static void sun4m_clear_clock_irq(void)
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index ffb875a..406ac1a 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -244,8 +244,9 @@ static struct smp_funcall {
 static DEFINE_SPINLOCK(cross_call_lock);
 
 /* Cross calls must be serialized, at least currently. */
-void smp4m_cross_call(smpfunc_t func, unsigned long arg1, unsigned long arg2,
-		    unsigned long arg3, unsigned long arg4, unsigned long arg5)
+static void smp4m_cross_call(smpfunc_t func, unsigned long arg1,
+			     unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
 {
 		register int ncpus = SUN4M_NCPUS;
 		unsigned long flags;
@@ -344,7 +345,7 @@ static void __init smp_setup_percpu_timer(void)
 		enable_pil_irq(14);
 }
 
-void __init smp4m_blackbox_id(unsigned *addr)
+static void __init smp4m_blackbox_id(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
 	int rs1 = rd >> 11;
@@ -354,7 +355,7 @@ void __init smp4m_blackbox_id(unsigned *addr)
 	addr[2] = 0x80082003 | rd | rs1;	/* and reg, 3, reg */
 }
 
-void __init smp4m_blackbox_current(unsigned *addr)
+static void __init smp4m_blackbox_current(unsigned *addr)
 {
 	int rd = *addr & 0x3e000000;
 	int rs1 = rd >> 11;
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index 53caacb..ab3dd0b 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -46,7 +46,7 @@
 #include "irq.h"
 
 DEFINE_SPINLOCK(rtc_lock);
-enum sparc_clock_type sp_clock_typ;
+static enum sparc_clock_type sp_clock_typ;
 DEFINE_SPINLOCK(mostek_lock);
 void __iomem *mstk48t02_regs = NULL;
 static struct mostek48t08 __iomem *mstk48t08_regs = NULL;
@@ -366,7 +366,7 @@ static int __init clock_init(void)
 fs_initcall(clock_init);
 #endif /* !CONFIG_SUN4 */
 
-void __init sbus_time_init(void)
+static void __init sbus_time_init(void)
 {
 
 	BTFIXUPSET_CALL(bus_do_settimeofday, sbus_do_settimeofday, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/traps.c b/arch/sparc/kernel/traps.c
index 978e9d8..ac8ee6a 100644
--- a/arch/sparc/kernel/traps.c
+++ b/arch/sparc/kernel/traps.c
@@ -33,9 +33,6 @@ struct trap_trace_entry {
 	unsigned long type;
 };
 
-int trap_curbuf = 0;
-struct trap_trace_entry trapbuf[1024];
-
 void syscall_trace_entry(struct pt_regs *regs)
 {
 	printk("%s[%d]: ", current->comm, task_pid_nr(current));
@@ -72,7 +69,7 @@ void sun4d_nmi(struct pt_regs *regs)
 	prom_halt();
 }
 
-void instruction_dump (unsigned long *pc)
+static void instruction_dump(unsigned long *pc)
 {
 	int i;
 	
@@ -479,10 +476,6 @@ void do_BUG(const char *file, int line)
 
 extern void sparc_cpu_startup(void);
 
-int linux_smp_still_initting;
-unsigned int thiscpus_tbr;
-int thiscpus_mid;
-
 void trap_init(void)
 {
 	extern void thread_info_offsets_are_bolixed_pete(void);
diff --git a/arch/sparc/kernel/wof.S b/arch/sparc/kernel/wof.S
index 4bce38d..3bbcd8d 100644
--- a/arch/sparc/kernel/wof.S
+++ b/arch/sparc/kernel/wof.S
@@ -306,7 +306,6 @@ spwin_bad_ustack_from_kernel:
  * As noted above %curptr cannot be touched by this routine at all.
  */
 
-	.globl	spwin_sun4c_stackchk
 spwin_sun4c_stackchk:
 	/* LOCATION: Window to be saved on the stack */
 
diff --git a/arch/sparc/kernel/wuf.S b/arch/sparc/kernel/wuf.S
index 82e5145..779ff75 100644
--- a/arch/sparc/kernel/wuf.S
+++ b/arch/sparc/kernel/wuf.S
@@ -243,7 +243,6 @@ fwin_user_finish_up:
 	 */
 
 	.align	4
-	.globl	sun4c_fwin_stackchk
 sun4c_fwin_stackchk:
 	/* LOCATION: Window 'W' */
 
diff --git a/include/asm-sparc/machines.h b/include/asm-sparc/machines.h
index d6c6bf8..c28c2f2 100644
--- a/include/asm-sparc/machines.h
+++ b/include/asm-sparc/machines.h
@@ -17,8 +17,6 @@ struct Sun_Machine_Models {
  */
 #define NUM_SUN_MACHINES   15
 
-extern struct Sun_Machine_Models Sun_Machines[NUM_SUN_MACHINES];
-
 /* The machine type in the idprom area looks like this:
  *
  * ---------------
diff --git a/include/asm-sparc/mostek.h b/include/asm-sparc/mostek.h
index 29aad11..c35c916 100644
--- a/include/asm-sparc/mostek.h
+++ b/include/asm-sparc/mostek.h
@@ -128,8 +128,6 @@ struct mostek48t08 {
 	struct mostek48t02 regs;     /* Here is what we are interested in.   */
 };
 
-extern enum sparc_clock_type sp_clock_typ;
-
 #ifdef CONFIG_SUN4
 enum sparc_clock_type {	MSTK48T02, MSTK48T08, \
 INTERSIL, MSTK_INVALID };
diff --git a/include/asm-sparc/timer.h b/include/asm-sparc/timer.h
index d909565..361e538 100644
--- a/include/asm-sparc/timer.h
+++ b/include/asm-sparc/timer.h
@@ -84,8 +84,6 @@ struct sun4m_timer_regs {
 	volatile unsigned int cfg;     /* equals zero at boot time... */
 };
 
-extern struct sun4m_timer_regs *sun4m_timers;
-
 #define SUN4D_PRM_CNT_L       0x80000000
 #define SUN4D_PRM_CNT_LVALUE  0x7FFFFC00
 

