From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 20 Apr 2018 14:38:07 +0000
Subject: [REVIEW][PATCH 18/22] signal/sparc: Use force_sig_fault where appropriate
Message-Id: <20180420143811.9994-18-ebiederm@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87604mhrnb.fsf@xmission.com>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/kernel/process_64.c   |  10 +--
 arch/sparc/kernel/sys_sparc_32.c |   9 +--
 arch/sparc/kernel/sys_sparc_64.c |   8 +--
 arch/sparc/kernel/traps_32.c     |  21 +-----
 arch/sparc/kernel/traps_64.c     | 145 ++++++++-------------------------------
 arch/sparc/mm/fault_32.c         |  13 +---
 arch/sparc/mm/fault_64.c         |   9 +--
 7 files changed, 37 insertions(+), 178 deletions(-)

diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 2219e55206b4..6c086086ca8f 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -518,15 +518,7 @@ void synchronize_user_stack(void)
 
 static void stack_unaligned(unsigned long sp)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void __user *) sp;
-	info.si_trapno = 0;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0, current);
 }
 
 void fault_in_user_windows(void)
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 00f6353fe435..7f3d9c59719a 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -147,18 +147,11 @@ SYSCALL_DEFINE0(nis_syscall)
 asmlinkage void
 sparc_breakpoint (struct pt_regs *regs)
 {
-	siginfo_t info;
 
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%x, nPC=%x\n", regs->pc, regs->npc);
 #endif
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
-	info.si_addr = (void __user *)regs->pc;
-	info.si_trapno = 0;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0, current);
 
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%x nPC=%x\n", regs->pc, regs->npc);
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9ef8de63f28b..7e49bbc925a5 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -502,7 +502,6 @@ SYSCALL_DEFINE0(nis_syscall)
 asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (test_thread_flag(TIF_32BIT)) {
 		regs->tpc &= 0xffffffff;
@@ -511,12 +510,7 @@ asmlinkage void sparc_breakpoint(struct pt_regs *regs)
 #ifdef DEBUG_SPARC_BREAKPOINT
         printk ("TRAP: Entering kernel PC=%lx, nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = 0;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->tpc, 0, current);
 #ifdef DEBUG_SPARC_BREAKPOINT
 	printk ("TRAP: Returning to space: PC=%lx nPC=%lx\n", regs->tpc, regs->tnpc);
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 06f43cf9695f..bcdfc6168dd5 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -93,8 +93,6 @@ void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 
 void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 {
-	siginfo_t info;
-
 	if(type < 0x80) {
 		/* Sun OS's puke from bad traps, Linux survives! */
 		printk("Unimplemented Sparc TRAP, type = %02lx\n", type);
@@ -104,13 +102,8 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 	if(regs->psr & PSR_PS)
 		die_if_kernel("Kernel bad trap", regs);
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLTRP;
-	info.si_addr = (void __user *)regs->pc;
-	info.si_trapno = type - 0x80;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLTRP,
+			(void __user *)regs->pc, type - 0x80, current);
 }
 
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
@@ -330,19 +323,11 @@ void handle_watchpoint(struct pt_regs *regs, unsigned long pc, unsigned long npc
 void handle_reg_access(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 		       unsigned long psr)
 {
-	siginfo_t info;
-
 #ifdef TRAP_DEBUG
 	printk("Register Access Exception at PC %08lx NPC %08lx PSR %08lx\n",
 	       pc, npc, psr);
 #endif
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_OBJERR;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)pc, 0, current);
 }
 
 void handle_cp_disabled(struct pt_regs *regs, unsigned long pc, unsigned long npc,
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index b485b49b87a8..aa624ed79db1 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -87,7 +87,6 @@ static void dump_tl1_traplog(struct tl1_traplog *p)
 void bad_trap(struct pt_regs *regs, long lvl)
 {
 	char buffer[36];
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "bad trap", regs,
 		       0, lvl, SIGTRAP) = NOTIFY_STOP)
@@ -107,13 +106,8 @@ void bad_trap(struct pt_regs *regs, long lvl)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLTRP;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = lvl;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLTRP,
+			(void __user *)regs->tpc, lvl, current);
 }
 
 void bad_trap_tl1(struct pt_regs *regs, long lvl)
@@ -192,7 +186,6 @@ EXPORT_SYMBOL_GPL(unregister_dimm_printer);
 void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "instruction access exception", regs,
 		       0, 0x8, SIGTRAP) = NOTIFY_STOP)
@@ -207,13 +200,8 @@ void spitfire_insn_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = SEGV_MAPERR;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR,
+			(void __user *)regs->tpc, 0, current);
 out:
 	exception_exit(prev_state);
 }
@@ -232,7 +220,6 @@ void sun4v_insn_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 {
 	unsigned short type = (type_ctx >> 16);
 	unsigned short ctx  = (type_ctx & 0xffff);
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "instruction access exception", regs,
 		       0, 0x8, SIGTRAP) = NOTIFY_STOP)
@@ -249,13 +236,7 @@ void sun4v_insn_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = SEGV_MAPERR;
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *) addr, 0, current);
 }
 
 void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
@@ -310,7 +291,6 @@ bool is_no_fault_exception(struct pt_regs *regs)
 void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "data access exception", regs,
 		       0, 0x30, SIGTRAP) = NOTIFY_STOP)
@@ -341,13 +321,7 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 	if (is_no_fault_exception(regs))
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = SEGV_MAPERR;
-	info.si_addr = (void __user *)sfar;
-	info.si_trapno = 0;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)sfar, 0, current);
 out:
 	exception_exit(prev_state);
 }
@@ -563,8 +537,6 @@ static void spitfire_cee_log(unsigned long afsr, unsigned long afar, unsigned lo
 
 static void spitfire_ue_log(unsigned long afsr, unsigned long afar, unsigned long udbh, unsigned long udbl, unsigned long tt, int tl1, struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	printk(KERN_WARNING "CPU[%d]: Uncorrectable Error AFSR[%lx] "
 	       "AFAR[%lx] UDBL[%lx] UDBH[%ld] TT[%lx] TL>1[%d]\n",
 	       smp_processor_id(), afsr, afar, udbl, udbh, tt, tl1);
@@ -599,13 +571,7 @@ static void spitfire_ue_log(unsigned long afsr, unsigned long afar, unsigned lon
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_OBJERR;
-	info.si_addr = (void *)0;
-	info.si_trapno = 0;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_OBJERR, (void *)0, 0, current);
 }
 
 void spitfire_access_error(struct pt_regs *regs, unsigned long status_encoded, unsigned long afar)
@@ -2195,7 +2161,6 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 
 	if (attrs & SUN4V_ERR_ATTRS_MEMORY) {
 		unsigned long addr = ent->err_raddr;
-		siginfo_t info;
 
 		if (addr = ~(u64)0) {
 			/* This seems highly unlikely to ever occur */
@@ -2216,23 +2181,13 @@ bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
 				addr += PAGE_SIZE;
 			}
 		}
-		clear_siginfo(&info);
-		info.si_signo = SIGKILL;
-		info.si_errno = 0;
-		info.si_trapno = 0;
-		force_sig_info(info.si_signo, &info, current);
+		force_sig(SIGKILL, current);
 
 		return true;
 	}
 	if (attrs & SUN4V_ERR_ATTRS_PIO) {
-		siginfo_t info;
-
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)sun4v_get_vaddr(regs);
-		force_sig_info(info.si_signo, &info, current);
-
+		force_sig_fault(SIGBUS, BUS_ADRERR,
+				(void __user *)sun4v_get_vaddr(regs), 0, current);
 		return true;
 	}
 
@@ -2369,31 +2324,27 @@ static void do_fpe_common(struct pt_regs *regs)
 		regs->tnpc += 4;
 	} else {
 		unsigned long fsr = current_thread_info()->xfsr[0];
-		siginfo_t info;
+		int code;
 
 		if (test_thread_flag(TIF_32BIT)) {
 			regs->tpc &= 0xffffffff;
 			regs->tnpc &= 0xffffffff;
 		}
-		clear_siginfo(&info);
-		info.si_signo = SIGFPE;
-		info.si_errno = 0;
-		info.si_addr = (void __user *)regs->tpc;
-		info.si_trapno = 0;
-		info.si_code = FPE_FLTUNK;
+		code = FPE_FLTUNK;
 		if ((fsr & 0x1c000) = (1 << 14)) {
 			if (fsr & 0x10)
-				info.si_code = FPE_FLTINV;
+				code = FPE_FLTINV;
 			else if (fsr & 0x08)
-				info.si_code = FPE_FLTOVF;
+				code = FPE_FLTOVF;
 			else if (fsr & 0x04)
-				info.si_code = FPE_FLTUND;
+				code = FPE_FLTUND;
 			else if (fsr & 0x02)
-				info.si_code = FPE_FLTDIV;
+				code = FPE_FLTDIV;
 			else if (fsr & 0x01)
-				info.si_code = FPE_FLTRES;
+				code = FPE_FLTRES;
 		}
-		force_sig_info(SIGFPE, &info, current);
+		force_sig_fault(SIGFPE, code,
+				(void __user *)regs->tpc, 0, current);
 	}
 }
 
@@ -2436,7 +2387,6 @@ void do_fpother(struct pt_regs *regs)
 void do_tof(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "tagged arithmetic overflow", regs,
 		       0, 0x26, SIGEMT) = NOTIFY_STOP)
@@ -2448,13 +2398,8 @@ void do_tof(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGEMT;
-	info.si_errno = 0;
-	info.si_code = EMT_TAGOVF;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = 0;
-	force_sig_info(SIGEMT, &info, current);
+	force_sig_fault(SIGEMT, EMT_TAGOVF,
+			(void __user *)regs->tpc, 0, current);
 out:
 	exception_exit(prev_state);
 }
@@ -2462,7 +2407,6 @@ void do_tof(struct pt_regs *regs)
 void do_div0(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "integer division by zero", regs,
 		       0, 0x28, SIGFPE) = NOTIFY_STOP)
@@ -2474,13 +2418,8 @@ void do_div0(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_code = FPE_INTDIV;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = 0;
-	force_sig_info(SIGFPE, &info, current);
+	force_sig_fault(SIGFPE, FPE_INTDIV,
+			(void __user *)regs->tpc, 0, current);
 out:
 	exception_exit(prev_state);
 }
@@ -2642,7 +2581,6 @@ void do_illegal_instruction(struct pt_regs *regs)
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
 	u32 insn;
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "illegal instruction", regs,
 		       0, 0x10, SIGILL) = NOTIFY_STOP)
@@ -2676,13 +2614,7 @@ void do_illegal_instruction(struct pt_regs *regs)
 			}
 		}
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLOPC;
-	info.si_addr = (void __user *)pc;
-	info.si_trapno = 0;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, 0, current);
 out:
 	exception_exit(prev_state);
 }
@@ -2690,7 +2622,6 @@ void do_illegal_instruction(struct pt_regs *regs)
 void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "memory address unaligned", regs,
 		       0, 0x34, SIGSEGV) = NOTIFY_STOP)
@@ -2703,21 +2634,13 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 	if (is_no_fault_exception(regs))
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void __user *)sfar;
-	info.si_trapno = 0;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)sfar, 0, current);
 out:
 	exception_exit(prev_state);
 }
 
 void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_ctx)
 {
-	siginfo_t info;
-
 	if (notify_die(DIE_TRAP, "memory address unaligned", regs,
 		       0, 0x34, SIGSEGV) = NOTIFY_STOP)
 		return;
@@ -2729,13 +2652,7 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 	if (is_no_fault_exception(regs))
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) addr, 0, current);
 }
 
 /* sun4v_mem_corrupt_detect_precise() - Handle precise exception on an ADI
@@ -2788,7 +2705,6 @@ void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
 void do_privop(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
-	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "privileged operation", regs,
 		       0, 0x11, SIGILL) = NOTIFY_STOP)
@@ -2798,13 +2714,8 @@ void do_privop(struct pt_regs *regs)
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_PRVOPC;
-	info.si_addr = (void __user *)regs->tpc;
-	info.si_trapno = 0;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_PRVOPC,
+			(void __user *)regs->tpc, 0, current);
 out:
 	exception_exit(prev_state);
 }
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 2deb586665b9..9f75b6444bf1 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -127,20 +127,11 @@ show_signal_msg(struct pt_regs *regs, int sig, int code,
 static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 			       unsigned long addr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_code = code;
-	info.si_errno = 0;
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
-
 	if (unlikely(show_unhandled_signals))
-		show_signal_msg(regs, sig, info.si_code,
+		show_signal_msg(regs, sig, code,
 				addr, current);
 
-	force_sig_info (sig, &info, current);
+	force_sig_fault(sig, code, (void __user *) addr, 0, current);
 }
 
 static unsigned long compute_si_addr(struct pt_regs *regs, int text_fault)
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 46ccff95d10e..63166fcf9e25 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -170,12 +170,7 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 			     int fault_code)
 {
 	unsigned long addr;
-	siginfo_t info;
 
-	clear_siginfo(&info);
-	info.si_code = code;
-	info.si_signo = sig;
-	info.si_errno = 0;
 	if (fault_code & FAULT_CODE_ITLB) {
 		addr = regs->tpc;
 	} else {
@@ -188,13 +183,11 @@ static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 		else
 			addr = fault_addr;
 	}
-	info.si_addr = (void __user *) addr;
-	info.si_trapno = 0;
 
 	if (unlikely(show_unhandled_signals))
 		show_signal_msg(regs, sig, code, addr, current);
 
-	force_sig_info(sig, &info, current);
+	force_sig_fault(sig, code, (void __user *) addr, 0, current);
 }
 
 static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
-- 
2.14.1

