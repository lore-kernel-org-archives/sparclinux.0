From: Joris van Rantwijk <jorisvr@sron.nl>
Date: Wed, 23 Jan 2013 19:33:25 +0000
Subject: Kernel panic on FPU instruction without FPU present
Message-Id: <20130123203325.1e330a9a@bever>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I'm running Linux on a LEON3 SparcV8 without floating point unit
present (the PSR_EF bit is hardwired to 0).

I noticed that I can easily cause a kernel panic by running a
user-mode application with an FPU instruction in it.

The FPU instruction traps to do_fpd_trap().
The kernel then tries to enable the FPU by setting PSR_EF and performs
an FPU context switch. During the FPU context switch, the kernel itself
executes an FPU instruction, which jumps to do_fpd_trap() and then the
system dies.

I prepared a patch which modifies do_fpd_trap() to be more graceful
on machines that can not enable PSR_EF.
Tested on Linux 3.7.1 and Linux 3.8-rc4.

Can anyone here decide if this is the right approach and help me to
get this fixed in the kernel?

Thanks, Joris.


diff -U 5 -urN linux-3.7.1/arch/sparc/kernel/traps_32.c linux-3.7.1-sparcfp/arch/sparc/kernel/traps_32.c
--- linux-3.7.1/arch/sparc/kernel/traps_32.c	2012-12-17 20:14:54.000000000 +0100
+++ linux-3.7.1-sparcfp/arch/sparc/kernel/traps_32.c	2013-01-20 19:38:02.616017770 +0100
@@ -183,10 +183,24 @@
 	/* Sanity check... */
 	if(psr & PSR_PS)
 		die_if_kernel("Kernel gets FloatingPenguinUnit disabled trap", regs);
 
 	put_psr(get_psr() | PSR_EF);    /* Allow FPU ops. */
+
+	if ((get_psr() & PSR_EF) = 0) {
+		/* No FPU present. Do not kill the kernel in this case. */
+		siginfo_t info;
+		printk(KERN_INFO "%s[%d]: no FPU present PC=%08lx\n", current->comm, task_pid_nr(current), pc);
+		info.si_signo = SIGFPE;
+		info.si_errno = 0;
+		info.si_addr = (void __user *)pc;
+		info.si_trapno = 0;
+		info.si_code = __SI_FAULT;
+		force_sig_info(SIGFPE, &info, current);
+		return;
+	}
+
 	regs->psr |= PSR_EF;
 #ifndef CONFIG_SMP
 	if(last_task_used_math = current)
 		return;
 	if(last_task_used_math) {
