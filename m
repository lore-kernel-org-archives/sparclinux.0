From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2007 07:15:37 +0000
Subject: Re: sparc64 - empty call traces
Message-Id: <20070730.001537.07640949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bastian Blank <waldi@debian.org>
Date: Sun, 24 Jun 2007 08:58:26 +0200

> I don't think it is expected that the call traces in a process dump
> (sysrq t) are empty? This happens on at least 2.6.21 and 2.6.22-rc5. The
> userland is 32bit. The machine is a T2000.

Please try this patch:

diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index 6ef2d29..6ef42b8 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -2134,12 +2134,20 @@ static void user_instruction_dump (unsigned int __user *pc)
 void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
 	unsigned long pc, fp, thread_base, ksp;
-	void *tp = task_stack_page(tsk);
+	struct thread_info *tp;
 	struct reg_window *rw;
 	int count = 0;
 
 	ksp = (unsigned long) _ksp;
-
+	if (!tsk)
+		tsk = current;
+	tp = task_thread_info(tsk);
+	if (ksp = 0UL) {
+		if (tsk = current)
+			asm("mov %%fp, %0" : "=r" (ksp));
+		else
+			ksp = tp->ksp;
+	}
 	if (tp = current_thread_info())
 		flushw_all();
 
@@ -2168,11 +2176,7 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 
 void dump_stack(void)
 {
-	unsigned long *ksp;
-
-	__asm__ __volatile__("mov	%%fp, %0"
-			     : "=r" (ksp));
-	show_stack(current, ksp);
+	show_stack(current, NULL);
 }
 
 EXPORT_SYMBOL(dump_stack);
diff --git a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
index 17123e9..9f7740e 100644
--- a/arch/sparc64/mm/fault.c
+++ b/arch/sparc64/mm/fault.c
@@ -112,15 +112,12 @@ static void __kprobes unhandled_fault(unsigned long address,
 
 static void bad_kernel_pc(struct pt_regs *regs, unsigned long vaddr)
 {
-	unsigned long *ksp;
-
 	printk(KERN_CRIT "OOPS: Bogus kernel PC [%016lx] in fault handler\n",
 	       regs->tpc);
 	printk(KERN_CRIT "OOPS: RPC [%016lx]\n", regs->u_regs[15]);
 	print_symbol("RPC: <%s>\n", regs->u_regs[15]);
 	printk(KERN_CRIT "OOPS: Fault was to vaddr[%lx]\n", vaddr);
-	__asm__("mov %%sp, %0" : "=r" (ksp));
-	show_stack(current, ksp);
+	dump_stack();
 	unhandled_fault(regs->tpc, current, regs);
 }
 
