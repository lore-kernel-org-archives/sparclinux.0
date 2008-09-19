From: David Miller <davem@davemloft.net>
Date: Fri, 19 Sep 2008 22:39:07 +0000
Subject: [PATCH 6/13]: sparc32: Kill clear_profile_irq btfixup entry.
Message-Id: <20080919.153907.264190697.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill clear_profile_irq btfixup entry.

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/irq.h       |    6 ------
 arch/sparc/kernel/pcic.c      |    6 ------
 arch/sparc/kernel/sun4c_irq.c |    6 ------
 arch/sparc/kernel/sun4d_irq.c |    6 ------
 arch/sparc/kernel/sun4m_irq.c |    1 -
 5 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/irq.h b/arch/sparc/kernel/irq.h
index 32ef3eb..db75138 100644
--- a/arch/sparc/kernel/irq.h
+++ b/arch/sparc/kernel/irq.h
@@ -13,7 +13,6 @@ BTFIXUPDEF_CALL(void, enable_irq, unsigned int)
 BTFIXUPDEF_CALL(void, disable_pil_irq, unsigned int)
 BTFIXUPDEF_CALL(void, enable_pil_irq, unsigned int)
 BTFIXUPDEF_CALL(void, clear_clock_irq, void)
-BTFIXUPDEF_CALL(void, clear_profile_irq, int)
 BTFIXUPDEF_CALL(void, load_profile_irq, int, unsigned int)
 
 static inline void __disable_irq(unsigned int irq)
@@ -41,11 +40,6 @@ static inline void clear_clock_irq(void)
 	BTFIXUP_CALL(clear_clock_irq)();
 }
 
-static inline void clear_profile_irq(int irq)
-{
-	BTFIXUP_CALL(clear_profile_irq)(irq);
-}
-
 static inline void load_profile_irq(int cpu, int limit)
 {
 	BTFIXUP_CALL(load_profile_irq)(cpu, limit);
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index e5950b0..462584e 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -897,11 +897,6 @@ static void pcic_enable_irq(unsigned int irq_nr)
 	local_irq_restore(flags);
 }
 
-static void pcic_clear_profile_irq(int cpu)
-{
-	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
-}
-
 static void pcic_load_profile_irq(int cpu, unsigned int limit)
 {
 	printk("PCIC: unimplemented code: FILE=%s LINE=%d", __FILE__, __LINE__);
@@ -927,7 +922,6 @@ void __init sun4m_pci_init_IRQ(void)
 	BTFIXUPSET_CALL(enable_pil_irq, pcic_enable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_pil_irq, pcic_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, pcic_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_profile_irq, pcic_clear_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, pcic_load_profile_irq, BTFIXUPCALL_NORM);
 }
 
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 5602972..6f28a13 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -131,11 +131,6 @@ static void sun4c_clear_clock_irq(void)
 	clear_intr = sun4c_timers->timer_limit10;
 }
 
-static void sun4c_clear_profile_irq(int cpu)
-{
-	/* Errm.. not sure how to do this.. */
-}
-
 static void sun4c_load_profile_irq(int cpu, unsigned int limit)
 {
 	/* Errm.. not sure how to do this.. */
@@ -204,7 +199,6 @@ void __init sun4c_init_IRQ(void)
 	BTFIXUPSET_CALL(enable_pil_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_pil_irq, sun4c_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4c_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_profile_irq, sun4c_clear_profile_irq, BTFIXUPCALL_NOP);
 	BTFIXUPSET_CALL(load_profile_irq, sun4c_load_profile_irq, BTFIXUPCALL_NOP);
 	sparc_init_timers = sun4c_init_timers;
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 6e3bf6e..d376d38 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -448,11 +448,6 @@ static void sun4d_clear_clock_irq(void)
 	sbus_readl(&sun4d_timers->l10_timer_limit);
 }
 
-static void sun4d_clear_profile_irq(int cpu)
-{
-	bw_get_prof_limit(cpu);
-}
-
 static void sun4d_load_profile_irq(int cpu, unsigned int limit)
 {
 	bw_set_prof_limit(cpu, limit);
@@ -585,7 +580,6 @@ void __init sun4d_init_IRQ(void)
 	BTFIXUPSET_CALL(enable_irq, sun4d_enable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_irq, sun4d_disable_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4d_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_profile_irq, sun4d_clear_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4d_load_profile_irq, BTFIXUPCALL_NORM);
 	sparc_init_timers = sun4d_init_timers;
 #ifdef CONFIG_SMP
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 8e1ecc6..ab309ec 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -379,7 +379,6 @@ void __init sun4m_init_IRQ(void)
 	BTFIXUPSET_CALL(enable_pil_irq, sun4m_enable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(disable_pil_irq, sun4m_disable_pil_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(clear_clock_irq, sun4m_clear_clock_irq, BTFIXUPCALL_NORM);
-	BTFIXUPSET_CALL(clear_profile_irq, sun4m_clear_profile_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(load_profile_irq, sun4m_load_profile_irq, BTFIXUPCALL_NORM);
 	sparc_init_timers = sun4m_init_timers;
 #ifdef CONFIG_SMP
-- 
1.5.6.5

