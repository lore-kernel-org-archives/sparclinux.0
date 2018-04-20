From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 20 Apr 2018 14:38:06 +0000
Subject: [REVIEW][PATCH 17/22] signal/sparc: Use send_sig_fault where appropriate
Message-Id: <20180420143811.9994-17-ebiederm@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87604mhrnb.fsf@xmission.com>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

Filling in struct siginfo before calling send_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper send_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls send_sig_info.

In short about a 5 line reduction in code for every time send_sig_info
is called, which makes the calling function clearer.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/kernel/traps_32.c     | 93 ++++++++--------------------------------
 arch/sparc/kernel/unaligned_32.c | 12 ++----
 2 files changed, 20 insertions(+), 85 deletions(-)

diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 03e522274b8b..06f43cf9695f 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -116,8 +116,6 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	siginfo_t info;
-
 	if(psr & PSR_PS)
 		die_if_kernel("Kernel illegal instruction", regs);
 #ifdef TRAP_DEBUG
@@ -125,29 +123,15 @@ void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned lon
 	       regs->pc, *(unsigned long *)regs->pc);
 #endif
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLOPC;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGILL, &info, current);
+	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0, current);
 }
 
 void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			 unsigned long psr)
 {
-	siginfo_t info;
-
 	if(psr & PSR_PS)
 		die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_PRVOPC;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGILL, &info, current);
+	send_sig_fault(SIGILL, ILL_PRVOPC, (void __user *)pc, 0, current);
 }
 
 /* XXX User may want to be allowed to do this. XXX */
@@ -155,8 +139,6 @@ void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long n
 void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	siginfo_t info;
-
 	if(regs->psr & PSR_PS) {
 		printk("KERNEL MNA at pc %08lx npc %08lx called by %08lx\n", pc, npc,
 		       regs->u_regs[UREG_RETPC]);
@@ -168,13 +150,9 @@ void do_memaccess_unaligned(struct pt_regs *regs, unsigned long pc, unsigned lon
 	instruction_dump ((unsigned long *) regs->pc);
 	printk ("do_MNA!\n");
 #endif
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = /* FIXME: Should dig out mna address */ (void *)0;
-	info.si_trapno = 0;
-	send_sig_info(SIGBUS, &info, current);
+	send_sig_fault(SIGBUS, BUS_ADRALN,
+		       /* FIXME: Should dig out mna address */ (void *)0,
+		       0, current);
 }
 
 static unsigned long init_fsr = 0x0UL;
@@ -230,9 +208,9 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		 unsigned long psr)
 {
 	static int calls;
-	siginfo_t info;
 	unsigned long fsr;
 	int ret = 0;
+	int code;
 #ifndef CONFIG_SMP
 	struct task_struct *fpt = last_task_used_math;
 #else
@@ -307,25 +285,20 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 	}
 
 	fsr = fpt->thread.fsr;
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	info.si_code = FPE_FLTUNK;
+	code = FPE_FLTUNK;
 	if ((fsr & 0x1c000) = (1 << 14)) {
 		if (fsr & 0x10)
-			info.si_code = FPE_FLTINV;
+			code = FPE_FLTINV;
 		else if (fsr & 0x08)
-			info.si_code = FPE_FLTOVF;
+			code = FPE_FLTOVF;
 		else if (fsr & 0x04)
-			info.si_code = FPE_FLTUND;
+			code = FPE_FLTUND;
 		else if (fsr & 0x02)
-			info.si_code = FPE_FLTDIV;
+			code = FPE_FLTDIV;
 		else if (fsr & 0x01)
-			info.si_code = FPE_FLTRES;
+			code = FPE_FLTRES;
 	}
-	send_sig_info(SIGFPE, &info, fpt);
+	send_sig_fault(SIGFPE, code, (void __user *)pc, 0, fpt);
 #ifndef CONFIG_SMP
 	last_task_used_math = NULL;
 #endif
@@ -337,17 +310,9 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 void handle_tag_overflow(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			 unsigned long psr)
 {
-	siginfo_t info;
-
 	if(psr & PSR_PS)
 		die_if_kernel("Penguin overflow trap from kernel mode", regs);
-	clear_siginfo(&info);
-	info.si_signo = SIGEMT;
-	info.si_errno = 0;
-	info.si_code = EMT_TAGOVF;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGEMT, &info, current);
+	send_sig_fault(SIGEMT, EMT_TAGOVF, (void __user *)pc, 0, current);
 }
 
 void handle_watchpoint(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -383,47 +348,23 @@ void handle_reg_access(struct pt_regs *regs, unsigned long pc, unsigned long npc
 void handle_cp_disabled(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			unsigned long psr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_COPROC;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGILL, &info, current);
+	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
 }
 
 void handle_cp_exception(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			 unsigned long psr)
 {
-	siginfo_t info;
-
 #ifdef TRAP_DEBUG
 	printk("Co-Processor Exception at PC %08lx NPC %08lx PSR %08lx\n",
 	       pc, npc, psr);
 #endif
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_COPROC;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGILL, &info, current);
+	send_sig_fault(SIGILL, ILL_COPROC, (void __user *)pc, 0, current);
 }
 
 void handle_hw_divzero(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		       unsigned long psr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_code = FPE_INTDIV;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, FPE_INTDIV, (void __user *)pc, 0, current);
 }
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index 0e4cf7217413..64ac8c0c1429 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -311,15 +311,9 @@ static inline int ok_for_user(struct pt_regs *regs, unsigned int insn,
 
 static void user_mna_trap_fault(struct pt_regs *regs, unsigned int insn)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void __user *)safe_compute_effective_address(regs, insn);
-	info.si_trapno = 0;
-	send_sig_info(SIGBUS, &info, current);
+	send_sig_fault(SIGBUS, BUS_ADRALN,
+		       (void __user *)safe_compute_effective_address(regs, insn),
+		       0, current);
 }
 
 asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
-- 
2.14.1

