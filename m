From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 20:09:01 +0000
Subject: [PATCH 3/3] sparc32: probe for cpu info only during startup
Message-Id: <1303330141-31123-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We did a cpu_probe() call each time a CPU got online - which
only effect was to save latest CPU/FPU info for use by show_cpuinfo().
Use same setup as for sparc64 where we probe for this info during startup,
and only once.

This allowed us to annotate a few functions __init which again
fixed the following section mismatch warnings:

WARNING: vmlinux.o(.text+0x65f0): Section mismatch in reference from the function set_cpu_and_fpu() to the (unknown reference) .init.rodata:(unknown)
WARNING: vmlinux.o(.text+0x65f8): Section mismatch in reference from the function set_cpu_and_fpu() to the (unknown reference) .init.rodata:(unknown)
WARNING: vmlinux.o(.text+0x664c): Section mismatch in reference from the function set_cpu_and_fpu() to the variable .init.rodata:manufacturer_info
WARNING: vmlinux.o(.text+0x6650): Section mismatch in reference from the function set_cpu_and_fpu() to the variable .init.rodata:manufacturer_info

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/leon.h |    1 -
 arch/sparc/kernel/cpu.c       |   12 ++++++++----
 arch/sparc/kernel/devices.c   |    2 --
 arch/sparc/kernel/leon_smp.c  |    2 --
 arch/sparc/kernel/sun4d_smp.c |    2 --
 arch/sparc/kernel/sun4m_smp.c |    2 --
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index c04f96f..959adac 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -366,7 +366,6 @@ extern void leon_smp_done(void);
 extern void leon_boot_cpus(void);
 extern int leon_boot_one_cpu(int i);
 void leon_init_smp(void);
-extern void cpu_probe(void);
 extern void cpu_idle(void);
 extern void init_IRQ(void);
 extern void cpu_panic(void);
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index c3483c7..138dbbc 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -258,7 +258,7 @@ static const char *sparc_fpu_type;
 const char *sparc_pmu_type;
 
 
-static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
+static void __init set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 {
 	const struct manufacturer_info *manuf;
 	int i;
@@ -434,7 +434,7 @@ const struct seq_operations cpuinfo_op = {
 };
 
 #ifdef CONFIG_SPARC32
-void __cpuinit cpu_probe(void)
+static int __init cpu_type_probe(void)
 {
 	int psr_impl, psr_vers, fpu_vers;
 	int psr;
@@ -453,8 +453,12 @@ void __cpuinit cpu_probe(void)
 	put_psr(psr);
 
 	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
+
+	return 0;
 }
-#else
+#endif /* CONFIG_SPARC32 */
+
+#ifdef CONFIG_SPARC64
 static void __init sun4v_cpu_probe(void)
 {
 	switch (sun4v_chip_type) {
@@ -495,6 +499,6 @@ static int __init cpu_type_probe(void)
 	}
 	return 0;
 }
+#endif /* CONFIG_SPARC64 */
 
 early_initcall(cpu_type_probe);
-#endif
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index d2eddd6..12aff23 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -20,7 +20,6 @@
 #include <asm/system.h>
 #include <asm/cpudata.h>
 
-extern void cpu_probe(void);
 extern void clock_stop_probe(void); /* tadpole.c */
 extern void sun4c_probe_memerr_reg(void);
 
@@ -133,7 +132,6 @@ void __init device_scan(void)
 	}
 #endif /* !CONFIG_SMP */
 
-	cpu_probe();
 	{
 		extern void auxio_probe(void);
 		extern void auxio_power_probe(void);
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 8f5de4a..9a061c1 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -94,8 +94,6 @@ void __cpuinit leon_callin(void)
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	cpu_probe();
-
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t" : : "r"(&current_set[cpuid])
 			     : "memory" /* paranoid */);
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 475d50b..38423a0 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -80,8 +80,6 @@ void __cpuinit smp4d_callin(void)
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	cpu_probe();
-
 	while ((unsigned long)current_set[cpuid] < PAGE_OFFSET)
 		barrier();
 
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 58b8d84..5545d10 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -59,8 +59,6 @@ void __cpuinit smp4m_callin(void)
 	local_flush_cache_all();
 	local_flush_tlb_all();
 
-	cpu_probe();
-
 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
 			     : : "r" (&current_set[cpuid])
-- 
1.6.0.6

