From: David Miller <davem@davemloft.net>
Date: Mon, 01 Mar 2010 08:05:53 +0000
Subject: [PATCH]: sparc: Support show_unhandled_signals.
Message-Id: <20100301.000553.193706488.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just commited the following to sparc-next-2.6 to be
consistent with powerpc and x86, as it has also helped
me debug a problem this weekend.

sparc: Support show_unhandled_signals.

Just faults right now, will add other traps later.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_32.c |  106 ++++++++++++++++++++++++++--------------------
 arch/sparc/mm/fault_64.c |   34 +++++++++++++-
 kernel/sysctl.c          |    2 +-
 3 files changed, 92 insertions(+), 50 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a3413ac..ec8f22c 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -35,6 +35,8 @@
 
 extern int prom_node_root;
 
+int show_unhandled_signals = 1;
+
 /* At boot time we determine these two values necessary for setting
  * up the segment maps and page table entries (pte's).
  */
@@ -149,6 +151,45 @@ asmlinkage int lookup_fault(unsigned long pc, unsigned long ret_pc,
 	return 0;
 }
 
+static inline void
+show_signal_msg(struct pt_regs *regs, int sig, int code,
+		unsigned long address, struct task_struct *tsk)
+{
+	if (!unhandled_signal(tsk, sig))
+		return;
+
+	if (!printk_ratelimit())
+		return;
+
+	printk("%s%s[%d]: segfault at %lx ip %p (rpc %p) sp %p error %x",
+	       task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+	       tsk->comm, task_pid_nr(tsk), address,
+	       (void *)regs->pc, (void *)regs->u_regs[UREG_I7],
+	       (void *)regs->u_regs[UREG_FP], code);
+
+	print_vma_addr(KERN_CONT " in ", regs->pc);
+
+	printk(KERN_CONT "\n");
+}
+
+static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
+			       unsigned long addr)
+{
+	siginfo_t info;
+
+	info.si_signo = sig;
+	info.si_code = code;
+	info.si_errno = 0;
+	info.si_addr = (void __user *) addr;
+	info.si_trapno = 0;
+
+	if (unlikely(show_unhandled_signals))
+		show_signal_msg(regs, sig, info.si_code,
+				addr, current);
+
+	force_sig_info (sig, &info, current);
+}
+
 extern unsigned long safe_compute_effective_address(struct pt_regs *,
 						    unsigned int);
 
@@ -168,6 +209,14 @@ static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
 	return safe_compute_effective_address(regs, insn);
 }
 
+static noinline void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
+				      int text_fault)
+{
+	unsigned long addr = compute_si_addr(regs, text_fault);
+
+	__do_fault_siginfo(code, sig, regs, addr);
+}
+
 asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 			       unsigned long address)
 {
@@ -176,9 +225,8 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	struct mm_struct *mm = tsk->mm;
 	unsigned int fixup;
 	unsigned long g2;
-	siginfo_t info;
 	int from_user = !(regs->psr & PSR_PS);
-	int fault;
+	int fault, code;
 
 	if(text_fault)
 		address = regs->pc;
@@ -195,7 +243,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	if (!ARCH_SUN4C && address >= TASK_SIZE)
 		goto vmalloc_fault;
 
-	info.si_code = SEGV_MAPERR;
+	code = SEGV_MAPERR;
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -229,7 +277,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * we can handle it..
 	 */
 good_area:
-	info.si_code = SEGV_ACCERR;
+	code = SEGV_ACCERR;
 	if(write) {
 		if(!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
@@ -273,18 +321,8 @@ bad_area:
 
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
-	if(from_user) {
-#if 0
-		printk("Fault whee %s [%d]: segfaults at %08lx pc=%08lx\n",
-		       tsk->comm, tsk->pid, address, regs->pc);
-#endif
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code set above to make clear whether
-		   this was a SEGV_MAPERR or SEGV_ACCERR fault.  */
-		info.si_addr = (void __user *)compute_si_addr(regs, text_fault);
-		info.si_trapno = 0;
-		force_sig_info (SIGSEGV, &info, tsk);
+	if (from_user) {
+		do_fault_siginfo(code, SIGSEGV, regs, text_fault);
 		return;
 	}
 
@@ -335,12 +373,7 @@ out_of_memory:
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) compute_si_addr(regs, text_fault);
-	info.si_trapno = 0;
-	force_sig_info (SIGBUS, &info, tsk);
+	do_fault_siginfo(BUS_ADRERR, SIGBUS, regs, text_fault);
 	if (!from_user)
 		goto no_context;
 
@@ -466,14 +499,10 @@ static void force_user_fault(unsigned long address, int write)
 	struct vm_area_struct *vma;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	siginfo_t info;
+	int code;
 
-	info.si_code = SEGV_MAPERR;
+	code = SEGV_MAPERR;
 
-#if 0
-	printk("wf<pid=%d,wr=%d,addr=%08lx>\n",
-	       tsk->pid, write, address);
-#endif
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if(!vma)
@@ -485,7 +514,7 @@ static void force_user_fault(unsigned long address, int write)
 	if(expand_stack(vma, address))
 		goto bad_area;
 good_area:
-	info.si_code = SEGV_ACCERR;
+	code = SEGV_ACCERR;
 	if(write) {
 		if(!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
@@ -502,27 +531,12 @@ good_area:
 	return;
 bad_area:
 	up_read(&mm->mmap_sem);
-#if 0
-	printk("Window whee %s [%d]: segfaults at %08lx\n",
-	       tsk->comm, tsk->pid, address);
-#endif
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	/* info.si_code set above to make clear whether
-	   this was a SEGV_MAPERR or SEGV_ACCERR fault.  */
-	info.si_addr = (void __user *) address;
-	info.si_trapno = 0;
-	force_sig_info (SIGSEGV, &info, tsk);
+	__do_fault_siginfo(code, SIGSEGV, tsk->thread.kregs, address);
 	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) address;
-	info.si_trapno = 0;
-	force_sig_info (SIGBUS, &info, tsk);
+	__do_fault_siginfo(BUS_ADRERR, SIGBUS, tsk->thread.kregs, address);
 }
 
 void window_overflow_fault(void)
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index b9d4ff0..f92ce56 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -32,6 +32,8 @@
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 
+int show_unhandled_signals = 1;
+
 static inline __kprobes int notify_page_fault(struct pt_regs *regs)
 {
 	int ret = 0;
@@ -128,22 +130,48 @@ outret:
 	return insn;
 }
 
+static inline void
+show_signal_msg(struct pt_regs *regs, int sig, int code,
+		unsigned long address, struct task_struct *tsk)
+{
+	if (!unhandled_signal(tsk, sig))
+		return;
+
+	if (!printk_ratelimit())
+		return;
+
+	printk("%s%s[%d]: segfault at %lx ip %p (rpc %p) sp %p error %x",
+	       task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+	       tsk->comm, task_pid_nr(tsk), address,
+	       (void *)regs->tpc, (void *)regs->u_regs[UREG_I7],
+	       (void *)regs->u_regs[UREG_FP], code);
+
+	print_vma_addr(KERN_CONT " in ", regs->tpc);
+
+	printk(KERN_CONT "\n");
+}
+
 extern unsigned long compute_effective_address(struct pt_regs *, unsigned int, unsigned int);
 
 static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 			     unsigned int insn, int fault_code)
 {
+	unsigned long addr;
 	siginfo_t info;
 
 	info.si_code = code;
 	info.si_signo = sig;
 	info.si_errno = 0;
 	if (fault_code & FAULT_CODE_ITLB)
-		info.si_addr = (void __user *) regs->tpc;
+		addr = regs->tpc;
 	else
-		info.si_addr = (void __user *)
-			compute_effective_address(regs, insn, 0);
+		addr = compute_effective_address(regs, insn, 0);
+	info.si_addr = (void __user *) addr;
 	info.si_trapno = 0;
+
+	if (unlikely(show_unhandled_signals))
+		show_signal_msg(regs, sig, code, addr, current);
+
 	force_sig_info(sig, &info, current);
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a68b24..33e7a38 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1441,7 +1441,7 @@ static struct ctl_table fs_table[] = {
 };
 
 static struct ctl_table debug_table[] = {
-#if defined(CONFIG_X86) || defined(CONFIG_PPC)
+#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
 	{
 		.procname	= "exception-trace",
 		.data		= &show_unhandled_signals,
-- 
1.6.6.1

