From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 15 Oct 2019 19:18:06 +0000
Subject: [PATCH 19/34] sparc: Use CONFIG_PREEMPTION
Message-Id: <20191015191821.11479-20-bigeasy@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the trap code over to use CONFIG_PREEMPTION.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sparc/Kconfig           | 2 +-
 arch/sparc/kernel/rtrap_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index fbc1aecf0f94c..9798d2074a265 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -278,7 +278,7 @@ config US3_MC
 config GENERIC_LOCKBREAK
 	bool
 	default y
-	depends on SPARC64 && SMP && PREEMPT
+	depends on SPARC64 && SMP && PREEMPTION
 
 config NUMA
 	bool "NUMA support"
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index 29aa34f11720c..c5fd4b450d9b6 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -310,7 +310,7 @@ kern_rtt:	rdpr			%canrestore, %g1
 		retry
 
 to_kernel:
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 		ldsw			[%g6 + TI_PRE_COUNT], %l5
 		brnz			%l5, kern_fpucheck
 		 ldx			[%g6 + TI_FLAGS], %l5
-- 
2.23.0
