From: David Miller <davem@davemloft.net>
Date: Fri, 02 Nov 2007 04:55:44 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071101.215544.225680847.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 01 Nov 2007 15:01:13 -0700 (PDT)

> I'm working on a kernel patch for 2.6.23 that will allow you to get
> some useful debugging information in situations like this.
>
> I'll try to get you that patch by the end of tonight.

As promised, here is the patch below.

To trigger the debugging log, simple give the console
a "Alt-SysRQ" then a "g".

On a serial console you can do this by giving a single
BREAK then a "g".

If you're having trouble triggering the sysrq on the
console, try instead:

bash# echo "g" >/proc/sysrq-trigger

Here is some sample output from my Niagara-2 system while
running a benchmark.  The current CPU is denoted by the
leading "*" character.

[81940.250994] SysRq : Show Global CPU Regs
[81940.251800] * CPU[  0]: TSTATE[00000000e2001602] TPC[000000000055813c] TNPC[0000000000558140] TASK[dd:2940]
[81940.252206]              TPC[NGbzero_loop+0x1c/0x38]
[81940.252422]   CPU[  1]: TSTATE[0000004411001607] TPC[000000000055c9bc] TNPC[000000000055c9c0] TASK[dd:2926]
[81940.252739]              TPC[atomic_sub_ret+0x4/0x30]
[81940.252936]   CPU[  2]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2899]
[81940.253238]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.253451]   CPU[  3]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2929]
[81940.253776]              TPC[NGbzero_loop+0x10/0x38]
[81940.253993]   CPU[  4]: TSTATE[00000000e2001602] TPC[0000000000558124] TNPC[0000000000558128] TASK[dd:2947]
[81940.254325]              TPC[NGbzero_loop+0x4/0x38]
[81940.254497]   CPU[  5]: TSTATE[0000004411001606] TPC[0000000000495f94] TNPC[0000000000495f98] TASK[dd:2908]
[81940.254893]              TPC[do_generic_mapping_read+0xbc/0x428]
[81940.255203]   CPU[  6]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2920]
[81940.255699]              TPC[NG2copy_to_user+0x468/0x680]
[81940.256104]   CPU[  7]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2935]
[81940.256574]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.256972]   CPU[  8]: TSTATE[00000000e2001602] TPC[0000000000558124] TNPC[0000000000558128] TASK[dd:2903]
[81940.257399]              TPC[NGbzero_loop+0x4/0x38]
[81940.257899]   CPU[  9]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2904]
[81940.258240]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.258482]   CPU[ 10]: TSTATE[00000000e2001602] TPC[0000000000558138] TNPC[000000000055813c] TASK[dd:2902]
[81940.258808]              TPC[NGbzero_loop+0x18/0x38]
[81940.258999]   CPU[ 11]: TSTATE[00000000e2001602] TPC[0000000000558120] TNPC[0000000000558124] TASK[dd:2941]
[81940.259319]              TPC[NGbzero_loop+0x0/0x38]
[81940.259487]   CPU[ 12]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2919]
[81940.259801]              TPC[NGbzero_loop+0x10/0x38]
[81940.260012]   CPU[ 13]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2950]
[81940.260350]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.260564]   CPU[ 14]: TSTATE[00000000e2001602] TPC[0000000000558134] TNPC[0000000000558138] TASK[dd:2936]
[81940.260937]              TPC[NGbzero_loop+0x14/0x38]
[81940.261150]   CPU[ 15]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2905]
[81940.261457]              TPC[NG2copy_to_user+0x468/0x680]
[81940.261677]   CPU[ 16]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2923]
[81940.261973]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.262167]   CPU[ 17]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2897]
[81940.262462]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.262643]   CPU[ 18]: TSTATE[00000000e2001602] TPC[0000000000558128] TNPC[000000000055812c] TASK[dd:2909]
[81940.262987]              TPC[NGbzero_loop+0x8/0x38]
[81940.263180]   CPU[ 19]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2913]
[81940.263500]              TPC[NG2copy_to_user+0x468/0x680]
[81940.263901]   CPU[ 20]: TSTATE[00000000e2001602] TPC[0000000000558128] TNPC[000000000055812c] TASK[dd:2890]
[81940.264403]              TPC[NGbzero_loop+0x8/0x38]
[81940.264679]   CPU[ 21]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2906]
[81940.265152]              TPC[NG2copy_to_user+0x468/0x680]
[81940.265535]   CPU[ 22]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2918]
[81940.266075]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.266448]   CPU[ 23]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2900]
[81940.266942]              TPC[NG2copy_to_user+0x468/0x680]
[81940.267328]   CPU[ 24]: TSTATE[0000000011001602] TPC[000000000049a618] TNPC[000000000049a61c] TASK[dd:2938]
[81940.267710]              TPC[get_page_from_freelist+0x260/0x478]
[81940.268029]   CPU[ 25]: TSTATE[0000004411001607] TPC[00000000005533cc] TNPC[00000000005533d0] TASK[dd:2922]
[81940.268248]              TPC[radix_tree_lookup+0x24/0x98]
[81940.268404]   CPU[ 26]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2915]
[81940.268494]              TPC[NG2copy_to_user+0x468/0x680]
[81940.268636]   CPU[ 27]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2921]
[81940.268715]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.268869]   CPU[ 28]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2945]
[81940.268984]              TPC[NGbzero_loop+0x10/0x38]
[81940.269131]   CPU[ 29]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2887]
[81940.269216]              TPC[NGbzero_loop+0x10/0x38]
[81940.269362]   CPU[ 30]: TSTATE[0000004411001602] TPC[000000000055cbd0] TNPC[000000000055cbd4] TASK[dd:2910]
[81940.269464]              TPC[clear_bit+0x24/0x38]
[81940.269598]   CPU[ 31]: TSTATE[00000044f0000a00] TPC[00000000f7effb48] TNPC[00000000f7effb4c] TASK[dd:2933]
[81940.269684]   CPU[ 32]: TSTATE[0000004411001602] TPC[000000000055cb98] TNPC[000000000055cb9c] TASK[dd:2927]
[81940.269849]              TPC[set_bit+0x24/0x38]
[81940.269902]   CPU[ 33]: TSTATE[00000000e2001602] TPC[0000000000558128] TNPC[000000000055812c] TASK[dd:2939]
[81940.270077]              TPC[NGbzero_loop+0x8/0x38]
[81940.270123]   CPU[ 34]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2911]
[81940.270283]              TPC[NG2copy_to_user+0x468/0x680]
[81940.270350]   CPU[ 35]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2888]
[81940.270525]              TPC[NG2copy_to_user+0x468/0x680]
[81940.270592]   CPU[ 36]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2928]
[81940.270761]              TPC[NG2copy_to_user+0x468/0x680]
[81940.270821]   CPU[ 37]: TSTATE[0000000011001607] TPC[000000000055fedc] TNPC[000000000055fee0] TASK[dd:2907]
[81940.270995]              TPC[NG2copy_to_user+0x45c/0x680]
[81940.271053]   CPU[ 38]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2946]
[81940.271221]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.271294]   CPU[ 39]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2934]
[81940.271467]              TPC[NG2copy_to_user+0x468/0x680]
[81940.271532]   CPU[ 40]: TSTATE[0000004411001607] TPC[000000000055ff00] TNPC[000000000055ff04] TASK[dd:2937]
[81940.271705]              TPC[NG2copy_to_user+0x480/0x680]
[81940.271761]   CPU[ 41]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2891]
[81940.271934]              TPC[NGbzero_loop+0x10/0x38]
[81940.271994]   CPU[ 42]: TSTATE[00000000e2001602] TPC[0000000000558138] TNPC[000000000055813c] TASK[dd:2930]
[81940.272173]              TPC[NGbzero_loop+0x18/0x38]
[81940.272355]   CPU[ 43]: TSTATE[0000004411001604] TPC[0000000000504850] TNPC[0000000000504854] TASK[dd:2942]
[81940.272481]              TPC[ext3_get_blocks_handle+0x68/0xc14]
[81940.272632]   CPU[ 44]: TSTATE[00000000e2001602] TPC[000000000055813c] TNPC[0000000000558140] TASK[dd:2894]
[81940.272726]              TPC[NGbzero_loop+0x1c/0x38]
[81940.272788]   CPU[ 45]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2898]
[81940.272872]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.272943]   CPU[ 46]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2892]
[81940.273035]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.273103]   CPU[ 47]: TSTATE[00000000e2001602] TPC[0000000000558138] TNPC[000000000055813c] TASK[dd:2893]
[81940.273172]              TPC[NGbzero_loop+0x18/0x38]
[81940.273228]   CPU[ 48]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2895]
[81940.280846]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.285194]   CPU[ 49]: TSTATE[0000009911001602] TPC[000000000055cbd0] TNPC[000000000055cbd4] TASK[dd:2896]
[81940.285412]              TPC[clear_bit+0x24/0x38]
[81940.295064]   CPU[ 50]: TSTATE[00000000e2001602] TPC[0000000000558130] TNPC[0000000000558134] TASK[dd:2943]
[81940.295436]              TPC[NGbzero_loop+0x10/0x38]
[81940.302407]   CPU[ 51]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2924]
[81940.305050]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.305272]   CPU[ 52]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2949]
[81940.308306]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.309938]   CPU[ 53]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2889]
[81940.310249]              TPC[NG2copy_to_user+0x468/0x680]
[81940.311719]   CPU[ 54]: TSTATE[0000000011001607] TPC[000000000055fee8] TNPC[000000000055feec] TASK[dd:2916]
[81940.321627]              TPC[NG2copy_to_user+0x468/0x680]
[81940.321844]   CPU[ 55]: TSTATE[0000004411001602] TPC[000000000055cbd0] TNPC[000000000055cbd4] TASK[dd:2932]
[81940.326879]              TPC[clear_bit+0x24/0x38]
[81940.326951]   CPU[ 56]: TSTATE[0000000011001607] TPC[000000000055feec] TNPC[000000000055fef0] TASK[dd:2901]
[81940.330430]              TPC[NG2copy_to_user+0x46c/0x680]
[81940.341949]   CPU[ 57]: TSTATE[00000000e2001602] TPC[0000000000558134] TNPC[0000000000558138] TASK[dd:2944]
[81940.342119]              TPC[NGbzero_loop+0x14/0x38]
[81940.379431]   CPU[ 58]: TSTATE[00000000e2001602] TPC[0000000000558128] TNPC[000000000055812c] TASK[dd:2912]
[81940.392125]              TPC[NGbzero_loop+0x8/0x38]
[81940.392186]   CPU[ 59]: TSTATE[0000000011001607] TPC[000000000055fee0] TNPC[000000000055fee4] TASK[dd:2925]
[81940.420952]              TPC[NG2copy_to_user+0x460/0x680]
[81940.421186]   CPU[ 60]: TSTATE[0000004411001602] TPC[00000000006a2f58] TNPC[00000000006a2f5c] TASK[dd:2948]
[81940.478590]              TPC[_write_lock_irq+0x18/0x30]
[81940.480714]   CPU[ 61]: TSTATE[0000000011001602] TPC[000000000049a618] TNPC[000000000049a61c] TASK[dd:2914]
[81940.481059]              TPC[get_page_from_freelist+0x260/0x478]
[81940.482588]   CPU[ 62]: TSTATE[00000000e2001602] TPC[0000000000558134] TNPC[0000000000558138] TASK[dd:2917]
[81940.489263]              TPC[NGbzero_loop+0x14/0x38]
[81940.489480]   CPU[ 63]: TSTATE[0000000011001607] TPC[000000000055fedc] TNPC[000000000055fee0] TASK[dd:2931]
[81940.506233]              TPC[NG2copy_to_user+0x45c/0x680]

So when you get a stuck process or whatever, trigger this and
send the output :-)

Enjoy.

diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index ca7cdfd..67bf91d 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -1,7 +1,6 @@
-/*  $Id: process.c,v 1.131 2002/02/09 19:49:30 davem Exp $
- *  arch/sparc64/kernel/process.c
+/*  arch/sparc64/kernel/process.c
  *
- *  Copyright (C) 1995, 1996 David S. Miller (davem@caip.rutgers.edu)
+ *  Copyright (C) 1995, 1996, 2007 David S. Miller (davem@davemloft.net)
  *  Copyright (C) 1996       Eddie C. Dost   (ecd@skynet.be)
  *  Copyright (C) 1997, 1998 Jakub Jelinek   (jj@sunsite.mff.cuni.cz)
  */
@@ -31,6 +30,7 @@
 #include <linux/tick.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
+#include <linux/sysrq.h>
 
 #include <asm/oplib.h>
 #include <asm/uaccess.h>
@@ -48,6 +48,7 @@
 #include <asm/unistd.h>
 #include <asm/hypervisor.h>
 #include <asm/sstate.h>
+#include <asm/irq_regs.h>
 
 /* #define VERBOSE_SHOWREGS */
 
@@ -388,6 +389,76 @@ void show_regs32(struct pt_regs32 *regs)
 	       regs->u_regs[15]);
 }
 
+#ifdef CONFIG_MAGIC_SYSRQ
+struct global_reg_snapshot {
+	unsigned long		tstate;
+	unsigned long		tpc;
+	unsigned long		tnpc;
+	struct thread_info	*thread;
+} global_reg_snapshot[NR_CPUS];
+static DEFINE_SPINLOCK(global_reg_snapshot_lock);
+
+static void sysrq_handle_globreg(int key, struct tty_struct *tty)
+{
+	struct pt_regs *regs = get_irq_regs();
+#ifdef CONFIG_KALLSYMS
+	char buffer[KSYM_SYMBOL_LEN];
+#endif
+	unsigned long flags;
+	int cpu;
+
+	spin_lock_irqsave(&global_reg_snapshot_lock, flags);
+	cpu = raw_smp_processor_id();
+	if (regs) {
+		global_reg_snapshot[cpu].tstate = regs->tstate;
+		global_reg_snapshot[cpu].tpc = regs->tpc;
+		global_reg_snapshot[cpu].tnpc = regs->tnpc;
+	} else {
+		global_reg_snapshot[cpu].tstate = 0;
+		global_reg_snapshot[cpu].tpc = 0;
+		global_reg_snapshot[cpu].tnpc = 0;
+	}
+	global_reg_snapshot[cpu].thread = current_thread_info();
+
+	smp_fetch_global_regs();
+
+	for_each_online_cpu(cpu) {
+		struct global_reg_snapshot *gp = &global_reg_snapshot[cpu];
+		struct thread_info *tp = gp->thread;
+
+		printk("%c CPU[%3d]: TSTATE[%016lx] TPC[%016lx] TNPC[%016lx] TASK[%s:%d]\n",
+		       (cpu = raw_smp_processor_id() ? '*' : ' '), cpu,
+		       gp->tstate, gp->tpc, gp->tnpc,
+		       ((tp  && tp->task) ? tp->task->comm : "NULL"),
+		       ((tp  && tp->task) ? tp->task->pid : -1));
+#ifdef CONFIG_KALLSYMS
+		if ((gp->tstate & TSTATE_PRIV) && (gp->tpc != 0UL)) {
+			sprint_symbol(buffer, gp->tpc);
+			printk("             TPC[%s]\n", buffer);
+		}
+#endif
+	}
+
+	memset(global_reg_snapshot, 0, sizeof(global_reg_snapshot));
+
+	spin_unlock_irqrestore(&global_reg_snapshot_lock, flags);
+}
+
+static struct sysrq_key_op sparc_globalreg_op = {
+	.handler	= sysrq_handle_globreg,
+	.help_msg	= "Globalregs",
+	.action_msg	= "Show Global CPU Regs",
+};
+
+static int __init sparc_globreg_init(void)
+{
+	return register_sysrq_key('g', &sparc_globalreg_op);
+}
+
+core_initcall(sparc_globreg_init);
+
+#endif
+
 unsigned long thread_saved_pc(struct task_struct *tsk)
 {
 	struct thread_info *ti = task_thread_info(tsk);
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index c73b7a4..cbedf27 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -894,6 +894,7 @@ extern unsigned long xcall_flush_tlb_mm;
 extern unsigned long xcall_flush_tlb_pending;
 extern unsigned long xcall_flush_tlb_kernel_range;
 extern unsigned long xcall_report_regs;
+extern unsigned long xcall_fetch_glob_regs;
 extern unsigned long xcall_receive_signal;
 extern unsigned long xcall_new_mmu_context_version;
 
@@ -1064,6 +1065,11 @@ void smp_report_regs(void)
 	smp_cross_call(&xcall_report_regs, 0, 0, 0);
 }
 
+void smp_fetch_global_regs(void)
+{
+	smp_cross_call(&xcall_fetch_glob_regs, 0, 0, 0);
+}
+
 /* We know that the window frames of the user have been flushed
  * to the stack before we get here because all callers of us
  * are flush_tlb_*() routines, and these run after flush_cache_*()
diff --git a/arch/sparc64/mm/ultra.S b/arch/sparc64/mm/ultra.S
index 737c269..7a079ed 100644
--- a/arch/sparc64/mm/ultra.S
+++ b/arch/sparc64/mm/ultra.S
@@ -1,7 +1,6 @@
-/* $Id: ultra.S,v 1.72 2002/02/09 19:49:31 davem Exp $
- * ultra.S: Don't expand these all over the place...
+/* ultra.S: Don't expand these all over the place...
  *
- * Copyright (C) 1997, 2000 David S. Miller (davem@redhat.com)
+ * Copyright (C) 1997, 2000, 2007 David S. Miller (davem@davemloft.net)
  */
 
 #include <asm/asi.h>
@@ -15,6 +14,7 @@
 #include <asm/thread_info.h>
 #include <asm/cacheflush.h>
 #include <asm/hypervisor.h>
+#include <asm/cpudata.h>
 
 	/* Basically, most of the Spitfire vs. Cheetah madness
 	 * has to do with the fact that Cheetah does not support
@@ -523,6 +523,27 @@ xcall_report_regs:
 	b		rtrap_xcall
 	 ldx		[%sp + PTREGS_OFF + PT_V9_TSTATE], %l1
 
+	.globl		xcall_fetch_glob_regs
+xcall_fetch_glob_regs:
+	sethi		%hi(global_reg_snapshot), %g1
+	or		%g1, %lo(global_reg_snapshot), %g1
+	__GET_CPUID(%g2)
+	sllx		%g2, 5, %g3
+	add		%g1, %g3, %g1
+	rdpr		%tstate, %g7
+	stx		%g7, [%g1 + 0x00]
+	rdpr		%tpc, %g7
+	stx		%g7, [%g1 + 0x08]
+	rdpr		%tnpc, %g7
+	stx		%g7, [%g1 + 0x10]
+	sethi		%hi(trap_block), %g7
+	or		%g7, %lo(trap_block), %g7
+	sllx		%g2, TRAP_BLOCK_SZ_SHIFT, %g2
+	add		%g7, %g2, %g7
+	ldx		[%g7 + TRAP_PER_CPU_THREAD], %g3
+	stx		%g3, [%g1 + 0x18]
+	retry
+
 #ifdef DCACHE_ALIASING_POSSIBLE
 	.align		32
 	.globl		xcall_flush_dcache_page_cheetah
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index 39cc318..7f871a5 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -335,6 +335,7 @@ static struct sysrq_key_op *sysrq_key_table[36] = {
 	&sysrq_term_op,			/* e */
 	&sysrq_moom_op,			/* f */
 	/* g: May be registered by ppc for kgdb */
+	/*    May be registered by sparc for global register dump */
 	NULL,				/* g */
 	NULL,				/* h */
 	&sysrq_kill_op,			/* i */
diff --git a/include/asm-sparc64/smp.h b/include/asm-sparc64/smp.h
index e8a96a3..29393e3 100644
--- a/include/asm-sparc64/smp.h
+++ b/include/asm-sparc64/smp.h
@@ -1,6 +1,6 @@
 /* smp.h: Sparc64 specific SMP stuff.
  *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
  */
 
 #ifndef _SPARC64_SMP_H
@@ -43,6 +43,8 @@ extern int hard_smp_processor_id(void);
 extern void smp_fill_in_sib_core_maps(void);
 extern void cpu_play_dead(void);
 
+extern void smp_fetch_global_regs(void);
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
@@ -54,6 +56,7 @@ extern void __cpu_die(unsigned int cpu);
 
 #define hard_smp_processor_id()		0
 #define smp_fill_in_sib_core_maps() do { } while (0)
+#define smp_fetch_global_regs() do { } while (0)
 
 #endif /* !(CONFIG_SMP) */
 
