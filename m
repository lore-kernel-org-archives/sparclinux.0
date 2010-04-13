From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 05:17:26 +0000
Subject: [PATCH] sparc64: Use kstack_valid() in die_if_kernel().
Message-Id: <20100412.221726.239347571.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This gets rid of a local function (is_kernel_stack()) which tries to
do the same thing, yet poorly in that it doesn't handle IRQ stacks
properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Committed to sparc-2.6

 arch/sparc/kernel/traps_64.c |   26 +++-----------------------
 1 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index bdc05a2..2ff178c 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2202,27 +2202,6 @@ void dump_stack(void)
 
 EXPORT_SYMBOL(dump_stack);
 
-static inline int is_kernel_stack(struct task_struct *task,
-				  struct reg_window *rw)
-{
-	unsigned long rw_addr = (unsigned long) rw;
-	unsigned long thread_base, thread_end;
-
-	if (rw_addr < PAGE_OFFSET) {
-		if (task != &init_task)
-			return 0;
-	}
-
-	thread_base = (unsigned long) task_stack_page(task);
-	thread_end = thread_base + sizeof(union thread_union);
-	if (rw_addr >= thread_base &&
-	    rw_addr < thread_end &&
-	    !(rw_addr & 0x7UL))
-		return 1;
-
-	return 0;
-}
-
 static inline struct reg_window *kernel_stack_up(struct reg_window *rw)
 {
 	unsigned long fp = rw->ins[6];
@@ -2251,6 +2230,7 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 	show_regs(regs);
 	add_taint(TAINT_DIE);
 	if (regs->tstate & TSTATE_PRIV) {
+		struct thread_info *tp = current_thread_info();
 		struct reg_window *rw = (struct reg_window *)
 			(regs->u_regs[UREG_FP] + STACK_BIAS);
 
@@ -2258,8 +2238,8 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 		 * find some badly aligned kernel stack.
 		 */
 		while (rw &&
-		       count++ < 30&&
-		       is_kernel_stack(current, rw)) {
+		       count++ < 30 &&
+		       kstack_valid(tp, (unsigned long) rw)) {
 			printk("Caller[%016lx]: %pS\n", rw->ins[7],
 			       (void *) rw->ins[7]);
 
-- 
1.7.0.4

