From: Rob Gardner <rob.gardner@oracle.com>
Date: Sat, 31 Oct 2015 04:36:23 +0000
Subject: [PATCH] sparc64: Don't restrict fp regs for no-fault loads
Message-Id: <1446266183-28234-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The function handle_ldf_stq() deals with no-fault ASI
loads and stores, but restricts fp registers to quad
word regs (ie, %f0, %f4 etc). This is valid for the
STQ case, but unnecessarily restricts loads, which
may be single precision, double, or quad. This results
in SIGFPE being raised for this instruction when the
source address is invalid:
	ldda [%g1] ASI_PNF, %f2
but not for this one:
	ldda [%g1] ASI_PNF, %f4
The validation check for quad register is moved to
within the STQ block so that loads are not affected
by the check.

An additional problem is that the calculation for freg
is incorrect when a single precision load is being
handled. This causes %f1 to be seen as %f32 etc,
and the incorrect register ends up being overwritten.
This code sequence demonstrates the problem:
	ldd [%g1], %f32		! g1 = valid address
	lda [%i3] ASI_PNF, %f1  ! i3 = invalid address
	std %f32, [%g1]
This is corrected by basing the freg calculation on
the load size.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/kernel/unaligned_64.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 62098a8..d89e97b 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -436,24 +436,26 @@ extern void sun4v_data_access_exception(struct pt_regs *regs,
 int handle_ldf_stq(u32 insn, struct pt_regs *regs)
 {
 	unsigned long addr = compute_effective_address(regs, insn, 0);
-	int freg = ((insn >> 25) & 0x1e) | ((insn >> 20) & 0x20);
+	int freg;
 	struct fpustate *f = FPUSTATE;
 	int asi = decode_asi(insn, regs);
-	int flag = (freg < 32) ? FPRS_DL : FPRS_DU;
+	int flag;
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
 
 	save_and_clear_fpu();
 	current_thread_info()->xfsr[0] &= ~0x1c000;
-	if (freg & 3) {
-		current_thread_info()->xfsr[0] |= (6 << 14) /* invalid_fp_register */;
-		do_fpother(regs);
-		return 0;
-	}
 	if (insn & 0x200000) {
 		/* STQ */
 		u64 first = 0, second = 0;
 		
+		freg = ((insn >> 25) & 0x1e) | ((insn >> 20) & 0x20);
+		flag = (freg < 32) ? FPRS_DL : FPRS_DU;
+		if (freg & 3) {
+			current_thread_info()->xfsr[0] |= (6 << 14) /* invalid_fp_register */;
+			do_fpother(regs);
+			return 0;
+		}
 		if (current_thread_info()->fpsaved[0] & flag) {
 			first = *(u64 *)&f->regs[freg];
 			second = *(u64 *)&f->regs[freg+2];
@@ -513,6 +515,12 @@ int handle_ldf_stq(u32 insn, struct pt_regs *regs)
 		case 0x100000: size = 4; break;
 		default: size = 2; break;
 		}
+		if (size = 1)
+			freg = (insn >> 25) & 0x1f;
+		else
+			freg = ((insn >> 25) & 0x1e) | ((insn >> 20) & 0x20);
+		flag = (freg < 32) ? FPRS_DL : FPRS_DU;
+
 		for (i = 0; i < size; i++)
 			data[i] = 0;
 		
-- 
1.7.9.5

