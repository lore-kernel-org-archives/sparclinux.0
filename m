From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:47:55 +0000
Subject: [PATCH 2/16]: sparc64: Fix sparse warnings in global reg
Message-Id: <20080912.144755.91176831.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in global reg snapshotting.

Lots of shadowed local variables and global_reg_snapshot[] needs
an extern declaration in asm/ptrace_64.h.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/ptrace_64.h |    3 +++
 arch/sparc64/kernel/process.c      |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/ptrace_64.h b/arch/sparc/include/asm/ptrace_64.h
index 06e4914..3d3e9c1 100644
--- a/arch/sparc/include/asm/ptrace_64.h
+++ b/arch/sparc/include/asm/ptrace_64.h
@@ -113,6 +113,8 @@ struct sparc_trapf {
 
 #ifdef __KERNEL__
 
+#include <linux/threads.h>
+
 static inline int pt_regs_trap_type(struct pt_regs *regs)
 {
 	return regs->magic & 0x1ff;
@@ -138,6 +140,7 @@ struct global_reg_snapshot {
 	struct thread_info	*thread;
 	unsigned long		pad1;
 };
+extern struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
 
 #define __ARCH_WANT_COMPAT_SYS_PTRACE
 
diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 11bb6c4..d5e2ace 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -215,7 +215,6 @@ static void __global_reg_self(struct thread_info *tp, struct pt_regs *regs,
 	global_reg_snapshot[this_cpu].o7 = regs->u_regs[UREG_I7];
 
 	if (regs->tstate & TSTATE_PRIV) {
-		struct thread_info *tp = current_thread_info();
 		struct reg_window *rw;
 
 		rw = (struct reg_window *)
@@ -271,7 +270,6 @@ void __trigger_all_cpu_backtrace(void)
 
 	for_each_online_cpu(cpu) {
 		struct global_reg_snapshot *gp = &global_reg_snapshot[cpu];
-		struct thread_info *tp;
 
 		__global_reg_poll(gp);
 
-- 
1.5.6.5.GIT

