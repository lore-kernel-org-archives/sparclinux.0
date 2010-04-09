From: David Miller <davem@davemloft.net>
Date: Fri, 09 Apr 2010 23:01:40 +0000
Subject: [PATCH 3/4] sched: Use local_irq_save_nmi() in cpu_clock()
Message-Id: <20100409.160140.250344636.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org


Since we can call cpu_clock() from NMI context fix up the IRQ
disabling to conform to the new rules.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 kernel/sched_clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched_clock.c b/kernel/sched_clock.c
index 5b49613..ef159ee 100644
--- a/kernel/sched_clock.c
+++ b/kernel/sched_clock.c
@@ -241,9 +241,9 @@ unsigned long long cpu_clock(int cpu)
 	unsigned long long clock;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	local_irq_save_nmi(flags);
 	clock = sched_clock_cpu(cpu);
-	local_irq_restore(flags);
+	local_irq_restore_nmi(flags);
 
 	return clock;
 }
-- 
1.7.0.4

