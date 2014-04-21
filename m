From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:35 +0000
Subject: [PATCH 23/24] sparc32: fix sparse warnings in sun4d_smp.c
Message-Id: <1398100356-19794-23-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
sun4d_smp.c:113:13: warning: symbol 'smp4d_boot_cpus' was not declared. Should it be static?
sun4d_smp.c:121:5: warning: symbol 'smp4d_boot_one_cpu' was not declared. Should it be static?
sun4d_smp.c:162:13: warning: symbol 'smp4d_smp_done' was not declared. Should it be static?
sun4d_smp.c:353:6: warning: symbol 'smp4d_cross_call_irq' was not declared. Should it be static?
sun4d_smp.c:363:6: warning: symbol 'smp4d_percpu_timer_interrupt' was not declared. Should it be static?

Add proper declarations

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kernel.h | 9 +++++++--
 arch/sparc/kernel/smp_32.c | 3 ---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index fd36dc1..7678e9a 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -70,8 +70,13 @@ extern void sun4d_distribute_irqs(void);
 extern void sun4d_free_irq(unsigned int irq, void *dev_id);
 
 /* sun4d_smp.c */
-void sun4d_cpu_pre_starting(void *arg);
-void sun4d_cpu_pre_online(void *arg);
+extern void sun4d_cpu_pre_starting(void *arg);
+extern void sun4d_cpu_pre_online(void *arg);
+extern void __init smp4d_boot_cpus(void);
+extern int smp4d_boot_one_cpu(int i, struct task_struct *idle);
+extern void __init smp4d_smp_done(void);
+extern void smp4d_cross_call_irq(void);
+extern void smp4d_percpu_timer_interrupt(struct pt_regs *regs);
 
 /* leon_smp.c */
 void leon_cpu_pre_starting(void *arg);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index ab86c5e..9d3297d 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -75,7 +75,6 @@ void smp_store_cpu_info(int id)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	extern void smp4d_smp_done(void);
 	unsigned long bogosum = 0;
 	int cpu, num = 0;
 
@@ -182,7 +181,6 @@ int setup_profiling_timer(unsigned int multiplier)
 
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	extern void __init smp4d_boot_cpus(void);
 	int i, cpuid, extra;
 
 	printk("Entering SMP Mode...\n");
@@ -259,7 +257,6 @@ void __init smp_prepare_boot_cpu(void)
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
-	extern int smp4d_boot_one_cpu(int, struct task_struct *);
 	int ret=0;
 
 	switch(sparc_cpu_model) {
-- 
1.8.3.1

