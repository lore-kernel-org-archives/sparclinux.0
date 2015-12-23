From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 23 Dec 2015 04:16:06 +0000
Subject: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When an interrupt (such as a perf counter interrupt) is delivered
while executing in user space, the trap entry code puts ASI_AIUS in
%asi so that copy_from_user() and copy_to_user() will access the
correct memory. But if a perf counter interrupt is delivered while the
cpu is already executing in kernel space, then the trap entry code
will put ASI_P in %asi, and this will prevent copy_from_user() from
reading any useful stack data in either of the perf_callchain_user_X
functions, and thus no user callgraph data will be collected for this
sample period. An additional problem is that a fault is guaranteed
to occur, and though it will be silently covered up, it wastes time
and could perturb state.

In perf_callchain_user(), we ensure that %asi contains ASI_AIUS
because we know for a fact that the subsequent calls to
copy_from_user() are intended to read the user's stack.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/kernel/perf_event.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 689db65..55a6caa 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1810,11 +1810,19 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 void
 perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 {
+	u8  saved_asi;
+
 	perf_callchain_store(entry, regs->tpc);
 
 	if (!current->mm)
 		return;
 
+	/* ensure we get user memory when trying to read stacks */
+	__asm__ __volatile__ ("rd %%asi, %0\n" : "=r" (saved_asi));
+	if (saved_asi != ASI_AIUS)
+		__asm__ __volatile__ (
+			"wr %%g0, %0, %%asi\n" : : "i" (ASI_AIUS));
+
 	flushw_user();
 
 	pagefault_disable();
@@ -1825,4 +1833,8 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 		perf_callchain_user_64(entry, regs);
 
 	pagefault_enable();
+
+	if (saved_asi != ASI_AIUS)
+		__asm__ __volatile__ (
+			"wr %%g0, %0, %%asi\n" : : "r" (saved_asi));
 }
-- 
1.7.9.5

