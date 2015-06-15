From: David Ahern <david.ahern@oracle.com>
Date: Mon, 15 Jun 2015 20:15:43 +0000
Subject: [PATCH 1/4] sparc: perf: Disable pagefaults while walking userspace stacks
Message-Id: <1434399346-21665-2-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Page faults generated walking userspace stacks can call schedule to switch
out the task. When collecting callchains for scheduler tracepoints this
causes a deadlock as the tracepoints can be hit with the runqueue lock held:

[ 8138.159054] WARNING: CPU: 758 PID: 12488 at /opt/dahern/linux.git/arch/sparc/kernel/nmi.c:80 perfctr_irq+0x1f8/0x2b4()

[ 8138.203152] Watchdog detected hard LOCKUP on cpu 758

[ 8138.410969] CPU: 758 PID: 12488 Comm: perf Not tainted 4.0.0-rc6+ #6
[ 8138.437146] Call Trace:
[ 8138.447193]  [000000000045cdd4] warn_slowpath_common+0x7c/0xa0
[ 8138.471238]  [000000000045ce90] warn_slowpath_fmt+0x30/0x40
[ 8138.494189]  [0000000000983e38] perfctr_irq+0x1f8/0x2b4
[ 8138.515716]  [00000000004209f4] tl0_irq15+0x14/0x20
[ 8138.535791]  [00000000009839ec] _raw_spin_trylock_bh+0x68/0x108
[ 8138.560180]  [0000000000980018] __schedule+0xcc/0x710
[ 8138.580981]  [00000000009806dc] preempt_schedule_common+0x10/0x3c
[ 8138.606082]  [000000000098077c] _cond_resched+0x34/0x44
[ 8138.627603]  [0000000000565990] kmem_cache_alloc_node+0x24/0x1a0
[ 8138.652345]  [0000000000450b60] tsb_grow+0xac/0x488
[ 8138.672429]  [0000000000985040] do_sparc64_fault+0x4dc/0x6e4
[ 8138.695736]  [0000000000407c2c] sparc64_realfault_common+0x10/0x20
[ 8138.721202]  [00000000006f2e24] NG4copy_from_user+0xa4/0x3c0
[ 8138.744510]  [000000000044f900] perf_callchain_user+0x5c/0x6c
[ 8138.768182]  [0000000000517b5c] perf_callchain+0x16c/0x19c
[ 8138.790774]  [0000000000515f84] perf_prepare_sample+0x68/0x218
[ 8138.814801] ---[ end trace 42ca6294b1ff7573 ]---

As with PowerPC (b59a1bfcc240, "powerpc/perf: Disable pagefaults during
callchain stack read") disable pagefaults while walking userspace stacks.

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/kernel/perf_event.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 59cf917a77b5..48387be665e9 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -21,7 +21,7 @@
 
 #include <asm/stacktrace.h>
 #include <asm/cpudata.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <linux/atomic.h>
 #include <asm/nmi.h>
 #include <asm/pcr.h>
@@ -1803,8 +1803,13 @@ perf_callchain_user(struct perf_callchain_entry *entry, struct pt_regs *regs)
 		return;
 
 	flushw_user();
+
+	pagefault_disable();
+
 	if (test_thread_flag(TIF_32BIT))
 		perf_callchain_user_32(entry, regs);
 	else
 		perf_callchain_user_64(entry, regs);
+
+	pagefault_enable();
 }
-- 
2.3.0

