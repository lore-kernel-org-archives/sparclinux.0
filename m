From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 07 Sep 2017 23:39:19 +0000
Subject: [PATCH] sparc64: Handle additional cases of no fault loads
Message-Id: <1504827559-109802-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Load instructions using ASI_PNF or other no-fault ASIs should not
cause a SIGSEGV or SIGBUS.

A garden variety unmapped address follows the TSB miss path, and when
no valid mapping is found in the process page tables, the miss handler
checks to see if the access was via a no-fault ASI.  It then fixes up
the target register with a zero, and skips the no-fault load
instruction.

But different paths are taken for data access exceptions and alignment
traps, and these do not respect the no-fault ASI. We add checks in
these paths for the no-fault ASI, and fix up the target register and
TPC just like in the TSB miss case.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/kernel/traps_64.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index ad31af1..c49949c 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -265,6 +265,34 @@ void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
 	sun4v_insn_access_exception(regs, addr, type_ctx);
 }
 
+bool is_no_fault_exception(struct pt_regs *regs)
+{
+	unsigned char asi;
+	u32 insn;
+
+	if (get_user(insn, (u32 __user *)regs->tpc) = -EFAULT)
+		return false;
+
+	if ((insn & 0xc0800000) = 0xc0800000) {
+		if (insn & 0x2000)
+			asi = (regs->tstate >> 24);
+		else
+			asi = (insn >> 5);
+		if ((asi & 0xf2) = ASI_PNF) {
+			if (insn & 0x1000000) {
+				handle_ldf_stq(insn, regs);
+				return true;
+			} else if (insn & 0x200000) {
+				/* store instruction, do not handle */
+				return false;
+			}
+			handle_ld_nf(insn, regs);
+			return true;
+		}
+	}
+	return false;
+}
+
 void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, unsigned long sfar)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -296,6 +324,9 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 		die_if_kernel("Dax", regs);
 	}
 
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code = SEGV_MAPERR;
@@ -352,6 +383,9 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code = SEGV_MAPERR;
@@ -2575,6 +2609,9 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 		kernel_unaligned_trap(regs, *((unsigned int *)regs->tpc));
 		goto out;
 	}
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
@@ -2597,6 +2634,9 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 		kernel_unaligned_trap(regs, *((unsigned int *)regs->tpc));
 		return;
 	}
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
-- 
1.7.1

