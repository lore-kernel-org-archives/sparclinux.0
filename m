From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 06:14:36 +0000
Subject: Re: [PATCH] sparc32: Move cache and TLB flushes over to method ops.
Message-Id: <20120514.021436.644561777451770710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.235611.828382132525916634.davem@davemloft.net>
In-Reply-To: <20120513.235611.828382132525916634.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 08:11:45 +0200

>> I think
>> for things like the hard_smp_processor_id() thing I'll use a
>> special ELF section of insn patchups as I do on sparc64.
> load_current looks like it requires some special treatment too.

No kidding :-)

Here is a patch that takes care off all of the CPU ID blackbox
stuff.  If you could quickly test this too that would be great.

Only the truly trivial btfixup stuff will remain.

--------------------
[PATCH] sparc32: Implement hard_smp_processor_id() via instruction patching.

This is the last non-trivial user of btfixup.

Like sparc64, use a special patch section to resolve the various
implementations of how to read the current CPU's ID when we don't
have current_thread_info()->cpu necessarily available.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/smp_32.h    |   43 +-----------------------------
 arch/sparc/include/asm/winmacro.h  |   49 +++++++++++++---------------------
 arch/sparc/kernel/entry.S          |   23 ++++++++++++++++
 arch/sparc/kernel/kernel.h         |    2 --
 arch/sparc/kernel/leon_smp.c       |   29 +-------------------
 arch/sparc/kernel/setup_32.c       |   51 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/sparc_ksyms_32.c |    5 ----
 arch/sparc/kernel/sun4d_smp.c      |   27 +++----------------
 arch/sparc/kernel/sun4m_smp.c      |   23 ----------------
 arch/sparc/kernel/trampoline_32.S  |   22 ++--------------
 10 files changed, 99 insertions(+), 175 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 01c51c7..f5b325e 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -59,12 +59,9 @@ void smp_bogo(struct seq_file *);
 void smp_info(struct seq_file *);
 
 BTFIXUPDEF_CALL(void, smp_cross_call, smpfunc_t, cpumask_t, unsigned long, unsigned long, unsigned long, unsigned long)
-BTFIXUPDEF_CALL(int, __hard_smp_processor_id, void)
 BTFIXUPDEF_CALL(void, smp_ipi_resched, int);
 BTFIXUPDEF_CALL(void, smp_ipi_single, int);
 BTFIXUPDEF_CALL(void, smp_ipi_mask_one, int);
-BTFIXUPDEF_BLACKBOX(hard_smp_processor_id)
-BTFIXUPDEF_BLACKBOX(load_current)
 
 #define smp_cross_call(func,mask,arg1,arg2,arg3,arg4) BTFIXUP_CALL(smp_cross_call)(func,mask,arg1,arg2,arg3,arg4)
 
@@ -117,45 +114,7 @@ extern inline int hard_smpleon_processor_id(void)
 	return cpuid;
 }
 
-#ifndef MODULE
-static inline int hard_smp_processor_id(void)
-{
-	int cpuid;
-
-	/* Black box - sun4m
-		__asm__ __volatile__("rd %%tbr, %0\n\t"
-				     "srl %0, 12, %0\n\t"
-				     "and %0, 3, %0\n\t" :
-				     "=&r" (cpuid));
-	             - sun4d
-		__asm__ __volatile__("lda [%g0] ASI_M_VIKING_TMP1, %0\n\t"
-				     "nop; nop" :
-				     "=&r" (cpuid));
-		     - leon
-		__asm__ __volatile__(	"rd %asr17, %0\n\t"
-					"srl %0, 0x1c, %0\n\t"
-					"nop\n\t" :
-					"=&r" (cpuid));
-	   See btfixup.h and btfixupprep.c to understand how a blackbox works.
-	 */
-	__asm__ __volatile__("sethi %%hi(___b_hard_smp_processor_id), %0\n\t"
-			     "sethi %%hi(boot_cpu_id), %0\n\t"
-			     "ldub [%0 + %%lo(boot_cpu_id)], %0\n\t" :
-			     "=&r" (cpuid));
-	return cpuid;
-}
-#else
-static inline int hard_smp_processor_id(void)
-{
-	int cpuid;
-
-	__asm__ __volatile__("mov %%o7, %%g1\n\t"
-			     "call ___f___hard_smp_processor_id\n\t"
-			     " nop\n\t"
-			     "mov %%g2, %0\n\t" : "=r"(cpuid) : : "g1", "g2");
-	return cpuid;
-}
-#endif
+extern int hard_smp_processor_id(void);
 
 #define raw_smp_processor_id()		(current_thread_info()->cpu)
 
diff --git a/arch/sparc/include/asm/winmacro.h b/arch/sparc/include/asm/winmacro.h
index a9be04b..9b7b217 100644
--- a/arch/sparc/include/asm/winmacro.h
+++ b/arch/sparc/include/asm/winmacro.h
@@ -103,37 +103,24 @@
         st       %scratch, [%cur_reg + TI_W_SAVED];
 
 #ifdef CONFIG_SMP
-/* Results of LOAD_CURRENT() after BTFIXUP for SUN4M, SUN4D & LEON (comments) */
-#define LOAD_CURRENT4M(dest_reg, idreg) \
-        rd       %tbr, %idreg; \
-	sethi    %hi(current_set), %dest_reg; \
-        srl      %idreg, 10, %idreg; \
-	or       %dest_reg, %lo(current_set), %dest_reg; \
-	and      %idreg, 0xc, %idreg; \
-	ld       [%idreg + %dest_reg], %dest_reg;
-
-#define LOAD_CURRENT4D(dest_reg, idreg) \
-	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg; \
-	sethi	%hi(C_LABEL(current_set)), %dest_reg; \
-	sll	%idreg, 2, %idreg; \
-	or	%dest_reg, %lo(C_LABEL(current_set)), %dest_reg; \
-	ld	[%idreg + %dest_reg], %dest_reg;
-
-#define LOAD_CURRENT_LEON(dest_reg, idreg)			\
-	rd	%asr17, %idreg;					\
-	sethi	%hi(current_set), %dest_reg;			\
-	srl	%idreg, 0x1c, %idreg;				\
-	or	%dest_reg, %lo(current_set), %dest_reg;		\
-	sll	%idreg, 0x2, %idreg;				\
-	ld	[%idreg + %dest_reg], %dest_reg;
-
-/* Blackbox - take care with this... - check smp4m and smp4d before changing this. */
-#define LOAD_CURRENT(dest_reg, idreg) 					\
-	sethi	 %hi(___b_load_current), %idreg;			\
-	sethi    %hi(current_set), %dest_reg; 			\
-	sethi    %hi(boot_cpu_id4), %idreg; 			\
-	or       %dest_reg, %lo(current_set), %dest_reg; 	\
-	ldub	 [%idreg + %lo(boot_cpu_id4)], %idreg;		\
+#define LOAD_CURRENT(dest_reg, idreg) 			\
+661:	rd	%tbr, %idreg;				\
+	srl	%idreg, 10, %idreg;			\
+	and	%idreg, 0xc, %idreg;			\
+	.section	.cpuid_patch, "ax";		\
+	/* Instruction location. */			\
+	.word		661b;				\
+	/* SUN4D implementation. */			\
+	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg;	\
+	sll	 %idreg, 2, %idreg;			\
+	nop;						\
+	/* LEON implementation. */			\
+	rd 	%asr17, %idreg;				\
+	srl	%idreg, 0x1c, %idreg;			\
+	sll	%idreg, 0x02, %idreg;			\
+	.previous;					\
+	sethi    %hi(current_set), %dest_reg; 		\
+	or       %dest_reg, %lo(current_set), %dest_reg;\
 	ld       [%idreg + %dest_reg], %dest_reg;
 #else
 #define LOAD_CURRENT(dest_reg, idreg) \
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index d7143ba..3215b6d 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -7,6 +7,7 @@
  * Copyright (C) 1997 Anton Blanchard (anton@progsoc.uts.edu.au)
  */
 
+#include <linux/linkage.h>
 #include <linux/errno.h>
 
 #include <asm/head.h>
@@ -1347,4 +1348,26 @@ flushw_all:
 	ret
 	 restore
 
+#ifdef CONFIG_SMP
+ENTRY(hard_smp_processor_id)
+1:	rd		%tbr, %g1
+	srl		%g1, 12, %o0
+	and		%o0, 3, %o0
+	.section	.cpuid_patch, "ax"
+	/* Instruction location. */
+	.word		661b
+	/* SUN4D implementation. */
+	lda		[%g0] ASI_M_VIKING_TMP1, %o0
+	nop
+	nop
+	/* LEON implementation. */
+	rd		%asr17, %o0
+	srl		%o0, 0x1c, %o0
+	nop
+	.previous
+	retl
+	 nop
+ENDPROC(hard_smp_processor_id)
+#endif
+
 /* End of entry.S */
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 8278df5..1c1a7d3 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -80,8 +80,6 @@ extern unsigned int patchme_maybe_smp_msg[];
 extern void floppy_hardint(void);
 
 /* trampoline_32.S */
-extern int __smp4m_processor_id(void);
-extern int __smp4d_processor_id(void);
 extern unsigned long sun4m_cpu_startup;
 extern unsigned long sun4d_cpu_startup;
 
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index f3e3630..faff792 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -73,7 +73,7 @@ static inline unsigned long do_swap(volatile unsigned long *ptr,
 
 void __cpuinit leon_callin(void)
 {
-	int cpuid = hard_smpleon_processor_id();
+	int cpuid = hard_smp_processor_id();
 
 	local_ops->cache_all();
 	local_ops->tlb_all();
@@ -491,39 +491,12 @@ void leon_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
-void __init leon_blackbox_id(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-	int rs1 = rd >> 11;
-
-	/* patch places where ___b_hard_smp_processor_id appears */
-	addr[0] = 0x81444000 | rd;	/* rd %asr17, reg */
-	addr[1] = 0x8130201c | rd | rs1;	/* srl reg, 0x1c, reg */
-	addr[2] = 0x01000000;	/* nop */
-}
-
-void __init leon_blackbox_current(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-	int rs1 = rd >> 11;
-
-	/* patch LOAD_CURRENT macro where ___b_load_current appears */
-	addr[0] = 0x81444000 | rd;	/* rd %asr17, reg */
-	addr[2] = 0x8130201c | rd | rs1;	/* srl reg, 0x1c, reg */
-	addr[4] = 0x81282002 | rd | rs1;	/* sll reg, 0x2, reg */
-
-}
-
 void __init leon_init_smp(void)
 {
 	/* Patch ipi15 trap table */
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_leon - linux_trap_ipi15_sun4m);
 
-	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, leon_blackbox_id);
-	BTFIXUPSET_BLACKBOX(load_current, leon_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, leon_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__hard_smp_processor_id, __leon_processor_id,
-			BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_resched, leon_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, leon_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, leon_ipi_mask_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 6f294f3..2f7cfb5 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -192,6 +192,52 @@ extern int root_mountflags;
 
 char reboot_command[COMMAND_LINE_SIZE];
 
+struct cpuid_patch_entry {
+	unsigned int	addr;
+	unsigned int	sun4d[3];
+	unsigned int	leon[3];
+};
+extern struct cpuid_patch_entry __cpuid_patch, __cpuid_patch_end;
+
+static void __init per_cpu_patch(void)
+{
+	struct cpuid_patch_entry *p;
+
+	if (sparc_cpu_model = sun4m) {
+		/* Nothing to do, this is what the unpatched code
+		 * targets.
+		 */
+		return;
+	}
+
+	p = &__cpuid_patch;
+	while (p < &__cpuid_patch_end) {
+		unsigned long addr = p->addr;
+		unsigned int *insns;
+
+		switch (sparc_cpu_model) {
+		case sun4d:
+			insns = &p->sun4d[0];
+			break;
+
+		case sparc_leon:
+			insns = &p->leon[0];
+			break;
+		default:
+			prom_printf("Unknown cpu type, halting.\n");
+			prom_halt();
+		}
+		*(unsigned int *) (addr + 0) = insns[0];
+		*(unsigned int *) (addr + 4) = insns[1];
+		*(unsigned int *) (addr + 8) = insns[2];
+	}
+#ifdef CONFIG_SMP
+	local_ops->cache_all();
+#else
+	sparc32_cachetlb_ops->cache_all();
+#endif
+}
+
 enum sparc_cpu sparc_cpu_model;
 EXPORT_SYMBOL(sparc_cpu_model);
 
@@ -295,6 +341,11 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	/* Now that we have the cache ops hooked up, we can patch
+	 * instructions.
+	 */
+	per_cpu_patch();
+
 	smp_setup_cpu_possible_map();
 }
 
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index 4ad7377..e521c54 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -28,10 +28,5 @@ EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__ret_efault);
 EXPORT_SYMBOL(empty_zero_page);
 
-/* Defined using magic */
-#ifdef CONFIG_SMP
-EXPORT_SYMBOL(BTFIXUP_CALL(__hard_smp_processor_id));
-#endif
-
 /* Exporting a symbol from /init/main.c */
 EXPORT_SYMBOL(saved_command_line);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index f17fd28..38ca0aa 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -52,7 +52,7 @@ static inline void show_leds(int cpuid)
 
 void __cpuinit smp4d_callin(void)
 {
-	int cpuid = hard_smp4d_processor_id();
+	int cpuid = hard_smp_processor_id();
 	unsigned long flags;
 
 	/* Show we are alive */
@@ -354,7 +354,7 @@ static void smp4d_cross_call(smpfunc_t func, cpumask_t mask, unsigned long arg1,
 /* Running cross calls. */
 void smp4d_cross_call_irq(void)
 {
-	int i = hard_smp4d_processor_id();
+	int i = hard_smp_processor_id();
 
 	ccall_info.processors_in[i] = 1;
 	ccall_info.func(ccall_info.arg1, ccall_info.arg2, ccall_info.arg3,
@@ -365,7 +365,7 @@ void smp4d_cross_call_irq(void)
 void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
-	int cpu = hard_smp4d_processor_id();
+	int cpu = hard_smp_processor_id();
 	struct clock_event_device *ce;
 	static int cpu_tick[NR_CPUS];
 	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
@@ -391,24 +391,6 @@ void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-void __init smp4d_blackbox_id(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-
-	addr[0] = 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
-	addr[1] = 0x01000000;			/* nop */
-	addr[2] = 0x01000000;			/* nop */
-}
-
-void __init smp4d_blackbox_current(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-
-	addr[0] = 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
-	addr[2] = 0x81282002 | rd | (rd >> 11);	/* sll reg, 2, reg */
-	addr[4] = 0x01000000;			/* nop */
-}
-
 void __init sun4d_init_smp(void)
 {
 	int i;
@@ -417,10 +399,7 @@ void __init sun4d_init_smp(void)
 	t_nmi[1] = t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);
 
 	/* And set btfixup... */
-	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4d_blackbox_id);
-	BTFIXUPSET_BLACKBOX(load_current, smp4d_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4d_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4d_processor_id, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_resched, smp4d_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, smp4d_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4d_ipi_mask_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index afcf674..ff74d33 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -281,32 +281,9 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
-static void __init smp4m_blackbox_id(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-	int rs1 = rd >> 11;
-
-	addr[0] = 0x81580000 | rd;		/* rd %tbr, reg */
-	addr[1] = 0x8130200c | rd | rs1;	/* srl reg, 0xc, reg */
-	addr[2] = 0x80082003 | rd | rs1;	/* and reg, 3, reg */
-}
-
-static void __init smp4m_blackbox_current(unsigned *addr)
-{
-	int rd = *addr & 0x3e000000;
-	int rs1 = rd >> 11;
-
-	addr[0] = 0x81580000 | rd;		/* rd %tbr, reg */
-	addr[2] = 0x8130200a | rd | rs1;	/* srl reg, 0xa, reg */
-	addr[4] = 0x8008200c | rd | rs1;	/* and reg, 0xc, reg */
-}
-
 void __init sun4m_init_smp(void)
 {
-	BTFIXUPSET_BLACKBOX(hard_smp_processor_id, smp4m_blackbox_id);
-	BTFIXUPSET_BLACKBOX(load_current, smp4m_blackbox_current);
 	BTFIXUPSET_CALL(smp_cross_call, smp4m_cross_call, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(__hard_smp_processor_id, __smp4m_processor_id, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_resched, smp4m_ipi_resched, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_single, smp4m_ipi_single, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(smp_ipi_mask_one, smp4m_ipi_mask_one, BTFIXUPCALL_NORM);
diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 691f484..7364ddc 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -15,8 +15,8 @@
 #include <asm/contregs.h>
 #include <asm/thread_info.h>
 
-	.globl sun4m_cpu_startup, __smp4m_processor_id, __leon_processor_id
-	.globl sun4d_cpu_startup, __smp4d_processor_id
+	.globl sun4m_cpu_startup
+	.globl sun4d_cpu_startup
 
 	__CPUINIT
 	.align 4
@@ -94,24 +94,6 @@ smp_do_cpu_idle:
 	call	cpu_panic
 	 nop
 
-__smp4m_processor_id:
-	rd	%tbr, %g2
-	srl	%g2, 12, %g2
-	and	%g2, 3, %g2
-	retl
-	 mov	%g1, %o7
-
-__smp4d_processor_id:
-	lda	[%g0] ASI_M_VIKING_TMP1, %g2
-	retl
-	 mov	%g1, %o7
-
-__leon_processor_id:
-	rd     %asr17,%g2
-        srl    %g2,28,%g2
-	retl
-	 mov	%g1, %o7
-
 /* CPUID in bootbus can be found at PA 0xff0140000 */
 #define SUN4D_BOOTBUS_CPUID	0xf0140000
 
-- 
1.7.10

