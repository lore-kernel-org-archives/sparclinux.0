From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:42 +0000
Subject: [PATCH 27/29] sparc32: fix sparse warnings in sun4m_smp.c
Message-Id: <1398109184-3283-27-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
sun4m_smp.c:72:13: warning: symbol 'smp4m_boot_cpus' was not declared. Should it be static?
sun4m_smp.c:78:5: warning: symbol 'smp4m_boot_one_cpu' was not declared. Should it be static?
sun4m_smp.c:120:13: warning: symbol 'smp4m_smp_done' was not declared. Should it be static?
sun4m_smp.c:230:6: warning: symbol 'smp4m_cross_call_irq' was not declared. Should it be static?
sun4m_smp.c:240:6: warning: symbol 'smp4m_percpu_timer_interrupt' was not declared. Should it be static?

Add proper declarations.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h | 5 +++++
 arch/sparc/kernel/smp_32.c | 3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 4f22038..75d4171 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -51,6 +51,11 @@ extern void sun4m_clear_profile_irq(int cpu);
 /* sun4m_smp.c */
 void sun4m_cpu_pre_starting(void *arg);
 void sun4m_cpu_pre_online(void *arg);
+void __init smp4m_boot_cpus(void);
+int smp4m_boot_one_cpu(int i, struct task_struct *idle);
+void __init smp4m_smp_done(void);
+void smp4m_cross_call_irq(void);
+void smp4m_percpu_timer_interrupt(struct pt_regs *regs);
 
 /* sun4d_irq.c */
 extern spinlock_t sun4d_imsk_lock;
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 632bf7c..ab86c5e 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -75,7 +75,6 @@ void smp_store_cpu_info(int id)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	extern void smp4m_smp_done(void);
 	extern void smp4d_smp_done(void);
 	unsigned long bogosum = 0;
 	int cpu, num = 0;
@@ -183,7 +182,6 @@ int setup_profiling_timer(unsigned int multiplier)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	extern void __init smp4m_boot_cpus(void);
 	extern void __init smp4d_boot_cpus(void);
 	int i, cpuid, extra;
 
@@ -261,7 +259,6 @@ void __init smp_prepare_boot_cpu(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	extern int smp4m_boot_one_cpu(int, struct task_struct *);
 	extern int smp4d_boot_one_cpu(int, struct task_struct *);
 	int ret=0;
 
-- 
1.8.3.1

