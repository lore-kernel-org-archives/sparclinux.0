From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:50 +0000
Subject: [PATCH 7/10]: sparc: Add alignment and emulation fault perf events.
Message-Id: <20091211.225550.39160747.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This mirrors commit 196f02bf900c5eb6f85d889c4f70e7cc11fda7e8
(powerpc: perf_event: Add alignment-faults and emulation-faults software events)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/unaligned_32.c |   15 +++------------
 arch/sparc/kernel/unaligned_64.c |   23 +++++++++--------------
 arch/sparc/kernel/visemul.c      |    3 +++
 arch/sparc/math-emu/math_32.c    |    3 +++
 arch/sparc/math-emu/math_64.c    |    2 ++
 5 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_32.c b/arch/sparc/kernel/unaligned_32.c
index 6b1e6cd..f8514e2 100644
--- a/arch/sparc/kernel/unaligned_32.c
+++ b/arch/sparc/kernel/unaligned_32.c
@@ -17,8 +17,7 @@
 #include <asm/uaccess.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-
-/* #define DEBUG_MNA */
+#include <linux/perf_event.h>
 
 enum direction {
 	load,    /* ld, ldd, ldh, ldsh */
@@ -29,12 +28,6 @@ enum direction {
 	invalid,
 };
 
-#ifdef DEBUG_MNA
-static char *dirstrings[] = {
-  "load", "store", "both", "fpload", "fpstore", "invalid"
-};
-#endif
-
 static inline enum direction decode_direction(unsigned int insn)
 {
 	unsigned long tmp = (insn >> 21) & 1;
@@ -255,10 +248,7 @@ asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn)
 		unsigned long addr = compute_effective_address(regs, insn);
 		int err;
 
-#ifdef DEBUG_MNA
-		printk("KMNA: pc=%08lx [dir=%s addr=%08lx size=%d] retpc[%08lx]\n",
-		       regs->pc, dirstrings[dir], addr, size, regs->u_regs[UREG_RETPC]);
-#endif
+		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, 0, regs, addr);
 		switch (dir) {
 		case load:
 			err = do_int_load(fetch_reg_addr(((insn>>25)&0x1f),
@@ -350,6 +340,7 @@ asmlinkage void user_unaligned_trap(struct pt_regs *regs, unsigned int insn)
 		}
 
 		addr = compute_effective_address(regs, insn);
+		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, 0, regs, addr);
 		switch(dir) {
 		case load:
 			err = do_int_load(fetch_reg_addr(((insn>>25)&0x1f),
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 3792099..378ca82 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -20,10 +20,9 @@
 #include <asm/uaccess.h>
 #include <linux/smp.h>
 #include <linux/bitops.h>
+#include <linux/perf_event.h>
 #include <asm/fpumacro.h>
 
-/* #define DEBUG_MNA */
-
 enum direction {
 	load,    /* ld, ldd, ldh, ldsh */
 	store,   /* st, std, sth, stsh */
@@ -33,12 +32,6 @@ enum direction {
 	invalid,
 };
 
-#ifdef DEBUG_MNA
-static char *dirstrings[] = {
-  "load", "store", "both", "fpload", "fpstore", "invalid"
-};
-#endif
-
 static inline enum direction decode_direction(unsigned int insn)
 {
 	unsigned long tmp = (insn >> 21) & 1;
@@ -327,12 +320,7 @@ asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn)
 
 		addr = compute_effective_address(regs, insn,
 						 ((insn >> 25) & 0x1f));
-#ifdef DEBUG_MNA
-		printk("KMNA: pc=%016lx [dir=%s addr=%016lx size=%d] "
-		       "retpc[%016lx]\n",
-		       regs->tpc, dirstrings[dir], addr, size,
-		       regs->u_regs[UREG_RETPC]);
-#endif
+		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, 0, regs, addr);
 		switch (asi) {
 		case ASI_NL:
 		case ASI_AIUPL:
@@ -399,6 +387,7 @@ int handle_popc(u32 insn, struct pt_regs *regs)
 	int ret, i, rd = ((insn >> 25) & 0x1f);
 	int from_kernel = (regs->tstate & TSTATE_PRIV) != 0;
 	                        
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
 	if (insn & 0x2000) {
 		maybe_flush_windows(0, 0, rd, from_kernel);
 		value = sign_extend_imm13(insn);
@@ -445,6 +434,8 @@ int handle_ldf_stq(u32 insn, struct pt_regs *regs)
 	int asi = decode_asi(insn, regs);
 	int flag = (freg < 32) ? FPRS_DL : FPRS_DU;
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
+
 	save_and_clear_fpu();
 	current_thread_info()->xfsr[0] &= ~0x1c000;
 	if (freg & 3) {
@@ -566,6 +557,8 @@ void handle_ld_nf(u32 insn, struct pt_regs *regs)
 	int from_kernel = (regs->tstate & TSTATE_PRIV) != 0;
 	unsigned long *reg;
 	                        
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
+
 	maybe_flush_windows(0, 0, rd, from_kernel);
 	reg = fetch_reg_addr(rd, regs);
 	if (from_kernel || rd < 16) {
@@ -596,6 +589,7 @@ void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 
 	if (tstate & TSTATE_PRIV)
 		die_if_kernel("lddfmna from kernel", regs);
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, 0, regs, sfar);
 	if (test_thread_flag(TIF_32BIT))
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
@@ -657,6 +651,7 @@ void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 
 	if (tstate & TSTATE_PRIV)
 		die_if_kernel("stdfmna from kernel", regs);
+	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, 0, regs, sfar);
 	if (test_thread_flag(TIF_32BIT))
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
diff --git a/arch/sparc/kernel/visemul.c b/arch/sparc/kernel/visemul.c
index d231cbd..9dfd2eb 100644
--- a/arch/sparc/kernel/visemul.c
+++ b/arch/sparc/kernel/visemul.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/thread_info.h>
+#include <linux/perf_event.h>
 
 #include <asm/ptrace.h>
 #include <asm/pstate.h>
@@ -801,6 +802,8 @@ int vis_emul(struct pt_regs *regs, unsigned int insn)
 
 	BUG_ON(regs->tstate & TSTATE_PRIV);
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
+
 	if (test_thread_flag(TIF_32BIT))
 		pc = (u32)pc;
 
diff --git a/arch/sparc/math-emu/math_32.c b/arch/sparc/math-emu/math_32.c
index e13f65d..a3fccde 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -67,6 +67,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/perf_event.h>
 #include <asm/uaccess.h>
 
 #include "sfp-util_32.h"
@@ -163,6 +164,8 @@ int do_mathemu(struct pt_regs *regs, struct task_struct *fpt)
 	int retcode = 0;                               /* assume all succeed */
 	unsigned long insn;
 
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
+
 #ifdef DEBUG_MATHEMU
 	printk("In do_mathemu()... pc is %08lx\n", regs->pc);
 	printk("fpqdepth is %ld\n", fpt->thread.fpqdepth);
diff --git a/arch/sparc/math-emu/math_64.c b/arch/sparc/math-emu/math_64.c
index 6863c9b..56d2c44 100644
--- a/arch/sparc/math-emu/math_64.c
+++ b/arch/sparc/math-emu/math_64.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
+#include <linux/perf_event.h>
 
 #include <asm/fpumacro.h>
 #include <asm/ptrace.h>
@@ -183,6 +184,7 @@ int do_mathemu(struct pt_regs *regs, struct fpustate *f)
 
 	if (tstate & TSTATE_PRIV)
 		die_if_kernel("unfinished/unimplemented FPop from kernel", regs);
+	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, 0, regs, 0);
 	if (test_thread_flag(TIF_32BIT))
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
-- 
1.6.5

