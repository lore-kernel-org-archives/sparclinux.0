From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 14:01:09 +0000
Subject: [PATCH 1/2] Fix merge problem between sparc32 IPI patches and schedule_ipi() callback
Message-Id: <1305900070-23492-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, peterz@infradead.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes a merge conflict in arch/sparc/kernel/smp_32.c between commit
d6d048192b1d ("sparc32: implement SMP IPIs using the generic functions")
from the sparc tree and commit 184748cc50b2 ("sched: Provide
scheduler_ipi() callback in response to smp_send_reschedule()").

The patch adds a call to scheduler_ipi() from the resched IPI handler in
sparc32.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/smp_32.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 41102c5..d5b3958 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -156,11 +156,11 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void smp_resched_interrupt(void)
 {
+	irq_enter();
+	scheduler_ipi();
 	local_cpu_data().irq_resched_count++;
-	/*
-	 * do nothing, since it all was about calling re-schedule
-	 * routine called by interrupt return code.
-	 */
+	irq_exit();
+	/* re-schedule routine called by interrupt return code. */
 }
 
 void smp_call_function_single_interrupt(void)
-- 
1.6.0.3

