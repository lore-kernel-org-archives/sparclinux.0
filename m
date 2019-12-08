From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Date: Sun, 08 Dec 2019 14:58:31 +0000
Subject: [tip: sched/urgent] sched/rt, sparc: Use CONFIG_PREEMPTION
Message-Id: <157581711171.21853.11624347815991134047.tip-bot2@tip-bot2>
List-Id: <sparclinux.vger.kernel.org>
References: <20191015191821.11479-20-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-20-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     85a683d0a6895026b535bf40643687c626e376f3
Gitweb:        https://git.kernel.org/tip/85a683d0a6895026b535bf40643687c626e376f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:35 +01:00

sched/rt, sparc: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the trap code over to use CONFIG_PREEMPTION.

[bigeasy: +Kconfig]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: sparclinux@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-20-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/sparc/Kconfig           | 2 +-
 arch/sparc/kernel/rtrap_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index eb24cb1..e8c3ea0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -277,7 +277,7 @@ config US3_MC
 config GENERIC_LOCKBREAK
 	bool
 	default y
-	depends on SPARC64 && SMP && PREEMPT
+	depends on SPARC64 && SMP && PREEMPTION
 
 config NUMA
 	bool "NUMA support"
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 29aa34f..c5fd4b4 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -310,7 +310,7 @@ kern_rtt_restore:
 		retry
 
 to_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		ldsw			[%g6 + TI_PRE_COUNT], %l5
 		brnz			%l5, kern_fpucheck
 		 ldx			[%g6 + TI_FLAGS], %l5
