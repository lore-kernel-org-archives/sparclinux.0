From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 23 Dec 2015 04:16:07 +0000
Subject: [PATCH 2/2] sparc64: Perf should save/restore fault info
Message-Id: <1450844167-7327-2-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There have been several reports of random processes being killed with
a bus error or segfault during userspace stack walking in perf.  One
of the root causes of this problem is an asynchronous modification to
thread_info fault_address and fault_code, which stems from a perf
counter interrupt arriving during kernel processing of a "benign"
fault, such as a TSB miss. Since perf_callchain_user() invokes
copy_from_user() to read user stacks, a fault is not only possible,
but probable. Validity checks on the stack address merely cover up the
problem and reduce its frequency.

The solution here is to save and restore fault_address and fault_code
in perf_callchain_user() so that the benign fault handler is not
disturbed by a perf interrupt.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Dave Aldridge <david.j.aldridge@oracle.com>
---
 arch/sparc/kernel/perf_event.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 55a6caa..cb20d34 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1810,6 +1810,8 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 void
 perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 {
+	u64 saved_fault_address = current_thread_info()->fault_address;
+	u8  saved_fault_code = get_thread_fault_code();
 	u8  saved_asi;
 
 	perf_callchain_store(entry, regs->tpc);
@@ -1837,4 +1839,6 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 	if (saved_asi != ASI_AIUS)
 		__asm__ __volatile__ (
 			"wr %%g0, %0, %%asi\n" : : "r" (saved_asi));
+	set_thread_fault_code(saved_fault_code);
+	current_thread_info()->fault_address = saved_fault_address;
 }
-- 
1.7.9.5

