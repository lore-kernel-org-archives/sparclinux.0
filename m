From: David Miller <davem@davemloft.net>
Date: Sun, 04 Nov 2007 05:10:57 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071103.221057.171375079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 02 Nov 2007 16:37:25 +0100

> I've sent g several times to sysrq, output is attached.
> According to top the two hanging aptitude processes were running on CPU
> 1 + 3.
> 
>  3204 root      20   0 19552 5088 4072 R  100  0.1   6:54.49 1 aptitude
>  3203 root      20   0 19552 5088 4072 R  100  0.1   6:56.39 3 aptitude

Ok, the key in the trace is:

Nov  2 16:25:30 titan kernel: [  978.134874]   CPU[  1]: TSTATE[0000000080009603] TPC[000000000067d2e0] TNPC[000000000067d2d4] TASK[aptitude:3204]
Nov  2 16:25:30 titan kernel: [  978.257809]              TPC[_write_unlock_irq+0x20/0x110]
 ...
Nov  2 16:25:30 titan kernel: [  978.507778]   CPU[  3]: TSTATE[0000000011009605] TPC[00000000004419f8] TNPC[00000000004419fc] TASK[aptitude:3203]
Nov  2 16:25:30 titan kernel: [  978.630707]              TPC[cheetah_xcall_deliver+0x174/0x23c]

The first symbol is misleading, it says _write_unlock_irq but actually
in the assembler the PC is in the spinlock read spinning loop
section.  So actually it's hanging in _spin_lock().

CPU #3 is trying to send a cross-call message interrupt, but for
some reason that isn't making forward progress.

Let's see what's calling these things by adding some more debugging
information.  Please retry the test with the following patch on
top of the original sysrq-g debugging patch and please get new
logs when it hangs.

Thanks!

--- arch/sparc64/kernel/process.c.ORIG	2007-11-03 20:53:27.000000000 -0700
+++ arch/sparc64/kernel/process.c	2007-11-03 21:05:47.000000000 -0700
@@ -49,6 +49,7 @@
 #include <asm/hypervisor.h>
 #include <asm/sstate.h>
 #include <asm/irq_regs.h>
+#include <asm/smp.h>
 
 /* #define VERBOSE_SHOWREGS */
 
@@ -394,7 +395,11 @@ struct global_reg_snapshot {
 	unsigned long		tstate;
 	unsigned long		tpc;
 	unsigned long		tnpc;
+	unsigned long		o7;
+	unsigned long		i7;
 	struct thread_info	*thread;
+	unsigned long		pad1;
+	unsigned long		pad2;
 } global_reg_snapshot[NR_CPUS];
 static DEFINE_SPINLOCK(global_reg_snapshot_lock);
 
@@ -413,6 +418,8 @@ static void sysrq_handle_globreg(int key
 		global_reg_snapshot[cpu].tstate = regs->tstate;
 		global_reg_snapshot[cpu].tpc = regs->tpc;
 		global_reg_snapshot[cpu].tnpc = regs->tnpc;
+		global_reg_snapshot[cpu].o7 = regs->u_regs[UREG_I7];
+		global_reg_snapshot[cpu].i7 = 0;
 	} else {
 		global_reg_snapshot[cpu].tstate = 0;
 		global_reg_snapshot[cpu].tpc = 0;
@@ -432,9 +439,19 @@ static void sysrq_handle_globreg(int key
 		       ((tp  && tp->task) ? tp->task->comm : "NULL"),
 		       ((tp  && tp->task) ? tp->task->pid : -1));
 #ifdef CONFIG_KALLSYMS
-		if ((gp->tstate & TSTATE_PRIV) && (gp->tpc != 0UL)) {
-			sprint_symbol(buffer, gp->tpc);
-			printk("             TPC[%s]\n", buffer);
+		if (gp->tstate & TSTATE_PRIV) {
+			if (gp->tpc != 0UL) {
+				sprint_symbol(buffer, gp->tpc);
+				printk("             TPC[%s]\n", buffer);
+			}
+			if (gp->o7 != 0UL) {
+				sprint_symbol(buffer, gp->o7);
+				printk("             O7[%s]\n", buffer);
+			}
+			if (gp->i7 != 0UL) {
+				sprint_symbol(buffer, gp->i7);
+				printk("             I7[%s]\n", buffer);
+			}
 		}
 #endif
 	}
--- arch/sparc64/mm/ultra.S.ORIG	2007-11-03 20:53:27.000000000 -0700
+++ arch/sparc64/mm/ultra.S	2007-11-03 20:57:12.000000000 -0700
@@ -528,7 +528,7 @@ xcall_fetch_glob_regs:
 	sethi		%hi(global_reg_snapshot), %g1
 	or		%g1, %lo(global_reg_snapshot), %g1
 	__GET_CPUID(%g2)
-	sllx		%g2, 5, %g3
+	sllx		%g2, 6, %g3
 	add		%g1, %g3, %g1
 	rdpr		%tstate, %g7
 	stx		%g7, [%g1 + 0x00]
@@ -536,12 +536,14 @@ xcall_fetch_glob_regs:
 	stx		%g7, [%g1 + 0x08]
 	rdpr		%tnpc, %g7
 	stx		%g7, [%g1 + 0x10]
+	stx		%o7, [%g1 + 0x18]
+	stx		%i7, [%g1 + 0x20]
 	sethi		%hi(trap_block), %g7
 	or		%g7, %lo(trap_block), %g7
 	sllx		%g2, TRAP_BLOCK_SZ_SHIFT, %g2
 	add		%g7, %g2, %g7
 	ldx		[%g7 + TRAP_PER_CPU_THREAD], %g3
-	stx		%g3, [%g1 + 0x18]
+	stx		%g3, [%g1 + 0x28]
 	retry
 
 #ifdef DCACHE_ALIASING_POSSIBLE
