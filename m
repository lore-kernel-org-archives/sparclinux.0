From: David Miller <davem@davemloft.net>
Date: Tue, 16 Oct 2012 20:16:26 +0000
Subject: [PATCH 1/3] sparc64: Like x86 we should check current->mm during perf backtrace generation.
Message-Id: <20121016.161626.1630652093620854470.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If the MM is not active, only report the top-level PC.  Do not try to
access the address space.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index e48651d..9e96f84 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1738,8 +1738,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 {
 	unsigned long ufp;
 
-	perf_callchain_store(entry, regs->tpc);
-
 	ufp = regs->u_regs[UREG_I6] + STACK_BIAS;
 	do {
 		struct sparc_stackf *usf, sf;
@@ -1760,8 +1758,6 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 {
 	unsigned long ufp;
 
-	perf_callchain_store(entry, regs->tpc);
-
 	ufp = regs->u_regs[UREG_I6] & 0xffffffffUL;
 	do {
 		struct sparc_stackf32 *usf, sf;
@@ -1780,6 +1776,11 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 void
 perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 {
+	perf_callchain_store(entry, regs->tpc);
+
+	if (!current->mm)
+		return;
+
 	flushw_user();
 	if (test_thread_flag(TIF_32BIT))
 		perf_callchain_user_32(entry, regs);
-- 
1.7.12.2.dirty

