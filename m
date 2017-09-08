From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 08 Sep 2017 22:34:21 +0000
Subject: [PATCH v2] sparc64: Handle additional cases of no fault loads
Message-Id: <1504910061-248242-1-git-send-email-rob.gardner@oracle.com>
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
 arch/sparc/kernel/traps_64.c |   51 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index ad31af1..c74f2df 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -265,6 +265,45 @@ void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
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
+	/*
+	 * Must do a little instruction decoding here in order to
+	 * decide on a course of action. The bits of interest are:
+	 *  insn[31:30] = op, where 3 indicates the load/store group
+	 *  insn[24:19] = op3, which identifies individual opcodes
+	 *  insn[13] indicates an immediate offset
+	 *  op3[4]=1 identifies alternate space instructions
+	 *  op3[5:4]=3 identifies floating point instructions
+	 *  op3[2]=1 identifies stores
+	 * See "Opcode Maps" in the appendix of any Sparc V9
+	 * architecture spec for full details.
+	 */
+	if ((insn & 0xc0800000) = 0xc0800000) {    /* op=3, op3[4]=1   */
+		if (insn & 0x2000)		    /* immediate offset */
+			asi = (regs->tstate >> 24); /* saved %asi       */
+		else
+			asi = (insn >> 5);	    /* immediate asi    */
+		if ((asi & 0xf2) = ASI_PNF) {
+			if (insn & 0x1000000) {     /* op3[5:4]=3       */
+				handle_ldf_stq(insn, regs);
+				return true;
+			} else if (insn & 0x200000) { /* op3[2], stores */
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
@@ -296,6 +335,9 @@ void spitfire_data_access_exception(struct pt_regs *regs, unsigned long sfsr, un
 		die_if_kernel("Dax", regs);
 	}
 
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code = SEGV_MAPERR;
@@ -352,6 +394,9 @@ void sun4v_data_access_exception(struct pt_regs *regs, unsigned long addr, unsig
 		regs->tpc &= 0xffffffff;
 		regs->tnpc &= 0xffffffff;
 	}
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGSEGV;
 	info.si_errno = 0;
 	info.si_code = SEGV_MAPERR;
@@ -2575,6 +2620,9 @@ void mem_address_unaligned(struct pt_regs *regs, unsigned long sfar, unsigned lo
 		kernel_unaligned_trap(regs, *((unsigned int *)regs->tpc));
 		goto out;
 	}
+	if (is_no_fault_exception(regs))
+		return;
+
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
@@ -2597,6 +2645,9 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
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

