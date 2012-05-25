From: David Miller <davem@davemloft.net>
Date: Fri, 25 May 2012 07:37:14 +0000
Subject: [PATCH] sparc64: Fix several bugs in quad floating point emulation.
Message-Id: <20120525.033714.2012043475251308239.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


UltraSPARC-T2 and later do not use the fp_exception_other trap and do
not set the floating point trap type field in the %fsr at all when you
try to execute an unimplemented FPU operation.

Instead, it uses the illegal_instruction trap and it leaves the
floating point trap type field clear.

So we should not validate the %fsr trap type field when do_mathemu()
is invoked from the illegal instruction handler.

Also, the floating point trap type field is 3 bits, not 4 bits.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/traps_64.c  |   12 +++++++-----
 arch/sparc/math-emu/math_64.c |   20 ++++++++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index c72fdf5..3b05e66 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2054,7 +2054,7 @@ void do_fpieee(struct pt_regs *regs)
 	do_fpe_common(regs);
 }
 
-extern int do_mathemu(struct pt_regs *, struct fpustate *);
+extern int do_mathemu(struct pt_regs *, struct fpustate *, bool);
 
 void do_fpother(struct pt_regs *regs)
 {
@@ -2068,7 +2068,7 @@ void do_fpother(struct pt_regs *regs)
 	switch ((current_thread_info()->xfsr[0] & 0x1c000)) {
 	case (2 << 14): /* unfinished_FPop */
 	case (3 << 14): /* unimplemented_FPop */
-		ret = do_mathemu(regs, f);
+		ret = do_mathemu(regs, f, false);
 		break;
 	}
 	if (ret)
@@ -2308,10 +2308,12 @@ void do_illegal_instruction(struct pt_regs *regs)
 			} else {
 				struct fpustate *f = FPUSTATE;
 
-				/* XXX maybe verify XFSR bits like
-				 * XXX do_fpother() does?
+				/* On UltraSPARC T2 and later, FPU insns which
+				 * are not implemented in HW signal an illegal
+				 * instruction trap and do not set the FP Trap
+				 * Trap in the %fsr to unimplemented_FPop.
 				 */
-				if (do_mathemu(regs, f))
+				if (do_mathemu(regs, f, true))
 					return;
 			}
 		}
diff --git a/arch/sparc/math-emu/math_64.c b/arch/sparc/math-emu/math_64.c
index 2bbe2f2..1704068 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -163,7 +163,7 @@ typedef union {
 	u64 q[2];
 } *argp;
 
-int do_mathemu(struct pt_regs *regs, struct fpustate *f)
+int do_mathemu(struct pt_regs *regs, struct fpustate *f, bool illegal_insn_trap)
 {
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
@@ -218,7 +218,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f)
 			case FSQRTS: {
 				unsigned long x = current_thread_info()->xfsr[0];
 
-				x = (x >> 14) & 0xf;
+				x = (x >> 14) & 0x7;
 				TYPE(x,1,1,1,1,0,0);
 				break;
 			}
@@ -226,7 +226,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f)
 			case FSQRTD: {
 				unsigned long x = current_thread_info()->xfsr[0];
 
-				x = (x >> 14) & 0xf;
+				x = (x >> 14) & 0x7;
 				TYPE(x,2,1,2,1,0,0);
 				break;
 			}
@@ -357,9 +357,17 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f)
 	if (type) {
 		argp rs1 = NULL, rs2 = NULL, rd = NULL;
 		
-		freg = (current_thread_info()->xfsr[0] >> 14) & 0xf;
-		if (freg != (type >> 9))
-			goto err;
+		/* Starting with UltraSPARC-T2, the cpu does not set the FP Trap
+		 * Type field in the %fsr to unimplemented_FPop.  Nor does it
+		 * use the fp_exception_other trap.  Instead it signals an
+		 * illegal instruction and leaves the FP trap type field of
+		 * the %fsr unchanged.
+		 */
+		if (!illegal_insn_trap) {
+			int ftt = (current_thread_info()->xfsr[0] >> 14) & 0x7;
+			if (ftt != (type >> 9))
+				goto err;
+		}
 		current_thread_info()->xfsr[0] &= ~0x1c000;
 		freg = ((insn >> 14) & 0x1f);
 		switch (type & 0x3) {
-- 
1.7.10

