From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 06:20:39 +0000
Subject: [PATCH 4/4] sparc32: mark smp init functions as cpuinit
Message-Id: <448BB637.7010301@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090701020805090809070208"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090701020805090809070208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fix the smp related section mismatch warnings by marking the smp init
functions as cpuinit.

Signed-off-by: Bob Breuer <breuerr@mc.net>
---


--------------090701020805090809070208
Content-Type: text/plain;
 name="sparc32-smp-cpuinit.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparc32-smp-cpuinit.patch.txt"

--- linux-2.6.17-rc3/arch/sparc/kernel/smp.c.old	2006-04-22 21:55:33.000000000 -0500
+++ linux-2.6.17-rc3/arch/sparc/kernel/smp.c	2006-04-23 11:10:12.000000000 -0500
@@ -58,7 +58,7 @@ cpumask_t smp_commenced_mask = CPU_MASK_
 /* Used to make bitops atomic */
 unsigned char bitops_spinlock = 0;
 
-void __init smp_store_cpu_info(int id)
+void __cpuinit smp_store_cpu_info(int id)
 {
 	int cpu_node;
 
@@ -293,7 +293,7 @@ void __init smp_setup_cpu_possible_map(v
 	}
 }
 
-void __devinit smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	int cpuid = hard_smp_processor_id();
 
@@ -309,7 +309,7 @@ void __devinit smp_prepare_boot_cpu(void
 	cpu_set(cpuid, phys_cpu_present_map);
 }
 
-int __devinit __cpu_up(unsigned int cpu)
+int __cpuinit __cpu_up(unsigned int cpu)
 {
 	extern int smp4m_boot_one_cpu(int);
 	int ret;
--- linux-2.6.17-rc3/arch/sparc/kernel/sun4m_smp.c.old	2006-04-22 18:21:37.000000000 -0500
+++ linux-2.6.17-rc3/arch/sparc/kernel/sun4m_smp.c	2006-04-23 11:14:25.000000000 -0500
@@ -66,7 +66,7 @@ static inline unsigned long swap(volatil
 static void smp_setup_percpu_timer(void);
 extern void cpu_probe(void);
 
-void __init smp4m_callin(void)
+void __cpuinit smp4m_callin(void)
 {
 	int cpuid = hard_smp_processor_id();
 
@@ -112,13 +112,8 @@ void __init smp4m_callin(void)
 	local_irq_enable();
 
 	cpu_set(cpuid, cpu_online_map);
-	/* last one in gets all the interrupts (for testing) */
-	set_irq_udt(boot_cpu_id);
 }
 
-extern void init_IRQ(void);
-extern void cpu_panic(void);
-
 /*
  *	Cycle through the processors asking the PROM to start each one.
  */
@@ -134,7 +129,7 @@ void __init smp4m_boot_cpus(void)
 	local_flush_cache_all();
 }
 
-int smp4m_boot_one_cpu(int i)
+int __cpuinit smp4m_boot_one_cpu(int i)
 {
 	extern unsigned long sun4m_cpu_startup;
 	unsigned long *entry = &sun4m_cpu_startup;

--------------090701020805090809070208--
