From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:03 +0000
Subject: [PATCH 5/13]: sparc32: Call sun4m_clear_profile_irq() directly
Message-Id: <20080919.153903.38279744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Call sun4m_clear_profile_irq() directly from sun4m_smp.c

This is the only use of the clear_profile_irq() btfixup entry,
which just eats up lots of dead space on other platform types.

A subsequent commit will delete the other implementations and
the btfixup entry as well.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sun4m_irq.c |    3 ++-
 arch/sparc/kernel/sun4m_smp.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 39d40e9..8e1ecc6 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -264,7 +264,8 @@ static void sun4m_clear_clock_irq(void)
 	sbus_readl(&timers_global->l10_limit);
 }
 
-static void sun4m_clear_profile_irq(int cpu)
+/* Exported for sun4m_smp.c */
+void sun4m_clear_profile_irq(int cpu)
 {
 	sbus_readl(&timers_percpu[cpu]->l14_limit);
 }
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index a14a76a..e3c0be1 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -313,6 +313,8 @@ void smp4m_cross_call_irq(void)
 	ccall_info.processors_out[i] = 1;
 }
 
+extern void sun4m_clear_profile_irq(int cpu);
+
 void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -320,7 +322,7 @@ void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 
 	old_regs = set_irq_regs(regs);
 
-	clear_profile_irq(cpu);
+	sun4m_clear_profile_irq(cpu);
 
 	profile_tick(CPU_PROFILING);
 
-- 
1.5.6.5

