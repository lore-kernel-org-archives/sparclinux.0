From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 21:02:37 +0000
Subject: [PATCH] sparc: unify kernel/cpu
Message-Id: <20081206210237.GA27594@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o use cpu_32.c as base
o move all sparc64 definitions to the common cpu.c
o use ifdef for the parts that differs and use cpu_32 as base
o spitfire.h required a CONFIG_SPARC64 guard to fix build on 32 bit

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This is build tested only! 
I need to get a sparc system soon if I shall continue this...

	Sam

 arch/sparc/include/asm/spitfire.h     |    4 +-
 arch/sparc/kernel/Makefile            |    2 +-
 arch/sparc/kernel/{cpu_32.c => cpu.c} |   91 ++++++++++++++++++
 arch/sparc/kernel/cpu_64.c            |  167 ---------------------------------
 4 files changed, 95 insertions(+), 169 deletions(-)
 rename arch/sparc/kernel/{cpu_32.c => cpu.c} (70%)
 delete mode 100644 arch/sparc/kernel/cpu_64.c

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 985ea7e..f0d0c40 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -6,6 +6,8 @@
 #ifndef _SPARC64_SPITFIRE_H
 #define _SPARC64_SPITFIRE_H
 
+#ifdef CONFIG_SPARC64
+
 #include <asm/asi.h>
 
 /* The following register addresses are accessible via ASI_DMMU
@@ -338,5 +340,5 @@ static inline void cheetah_put_itlb_data(int entry, unsigned long data)
 }
 
 #endif /* !(__ASSEMBLY__) */
-
+#endif /* CONFIG_SPARC64 */
 #endif /* !(_SPARC64_SPITFIRE_H) */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 04c74d0..0ba314b 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -27,7 +27,7 @@ obj-y                   += sys_sparc_$(BITS).o
 obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
 obj-$(CONFIG_SPARC32)   += windows.o
-obj-y                   += cpu_$(BITS).o
+obj-y                   += cpu.o
 obj-$(CONFIG_SPARC32)   += devices.o
 obj-$(CONFIG_SPARC32)   += tadpole.o
 obj-$(CONFIG_SPARC32)   += tick14.o
diff --git a/arch/sparc/kernel/cpu_32.c b/arch/sparc/kernel/cpu.c
similarity index 70%
rename from arch/sparc/kernel/cpu_32.c
rename to arch/sparc/kernel/cpu.c
index 6052822..6c2da24 100644
--- a/arch/sparc/kernel/cpu_32.c
+++ b/arch/sparc/kernel/cpu.c
@@ -8,6 +8,8 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
+
+#include <asm/spitfire.h>
 #include <asm/oplib.h>
 #include <asm/page.h>
 #include <asm/head.h>
@@ -176,6 +178,52 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 		FPU(3, "Fujitsu or Weitek on-chip FPU"),
 		FPU(-1, NULL)
 	}
+},{
+	0x17,
+	.cpu_info = {
+		CPU(0x10, "TI UltraSparc I   (SpitFire)"),
+		CPU(0x11, "TI UltraSparc II  (BlackBird)"),
+		CPU(0x12, "TI UltraSparc IIi (Sabre)"),
+		CPU(0x13, "TI UltraSparc IIe (Hummingbird)"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0x10, "UltraSparc I integrated FPU"),
+		FPU(0x11, "UltraSparc II integrated FPU"),
+		FPU(0x12, "UltraSparc IIi integrated FPU"),
+		FPU(0x13, "UltraSparc IIe integrated FPU"),
+		FPU(-1, NULL)
+	}
+},{
+	0x22,
+	.cpu_info = {
+		CPU(0x10, "TI UltraSparc I   (SpitFire)"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0x10, "UltraSparc I integrated FPU"),
+		FPU(-1, NULL)
+	}
+},{
+	0x3e,
+	.cpu_info = {
+		CPU(0x14, "TI UltraSparc III (Cheetah)"),
+		CPU(0x15, "TI UltraSparc III+ (Cheetah+)"),
+		CPU(0x16, "TI UltraSparc IIIi (Jalapeno)"),
+		CPU(0x18, "TI UltraSparc IV (Jaguar)"),
+		CPU(0x19, "TI UltraSparc IV+ (Panther)"),
+		CPU(0x22, "TI UltraSparc IIIi+ (Serrano)"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0x14, "UltraSparc III integrated FPU"),
+		FPU(0x15, "UltraSparc III+ integrated FPU"),
+		FPU(0x16, "UltraSparc IIIi integrated FPU"),
+		FPU(0x18, "UltraSparc IV integrated FPU"),
+		FPU(0x19, "UltraSparc IV+ integrated FPU"),
+		FPU(0x22, "UltraSparc IIIi+ integrated FPU"),
+		FPU(-1, NULL)
+	}
 }};
 
 /* In order to get the fpu type correct, you need to take the IDPROM's
@@ -230,6 +278,7 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 	}
 }
 
+#ifdef CONFIG_SPARC32
 void __cpuinit cpu_probe(void)
 {
 	int psr_impl, psr_vers, fpu_vers;
@@ -245,3 +294,45 @@ void __cpuinit cpu_probe(void)
 
 	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
 }
+#else
+static void __init sun4v_cpu_probe(void)
+{
+	switch (sun4v_chip_type) {
+	case SUN4V_CHIP_NIAGARA1:
+		sparc_cpu_type = "UltraSparc T1 (Niagara)";
+		sparc_fpu_type = "UltraSparc T1 integrated FPU";
+		break;
+
+	case SUN4V_CHIP_NIAGARA2:
+		sparc_cpu_type = "UltraSparc T2 (Niagara2)";
+		sparc_fpu_type = "UltraSparc T2 integrated FPU";
+		break;
+
+	default:
+		printk(KERN_WARNING "CPU: Unknown sun4v cpu type [%s]\n",
+		       prom_cpu_compatible);
+		sparc_cpu_type = "Unknown SUN4V CPU";
+		sparc_fpu_type = "Unknown SUN4V FPU";
+		break;
+	}
+}
+
+static int __init cpu_type_probe(void)
+{
+	if (tlb_type = hypervisor) {
+		sun4v_cpu_probe();
+	} else {
+		unsigned long ver;
+		int manuf, impl;
+
+		__asm__ __volatile__("rdpr %%ver, %0" : "=r" (ver));
+
+		manuf = ((ver >> 48) & 0xffff);
+		impl = ((ver >> 32) & 0xffff);
+		set_cpu_and_fpu(manuf, impl, impl);
+	}
+	return 0;
+}
+
+arch_initcall(cpu_type_probe);
+#endif
diff --git a/arch/sparc/kernel/cpu_64.c b/arch/sparc/kernel/cpu_64.c
deleted file mode 100644
index 4a81ed7..0000000
--- a/arch/sparc/kernel/cpu_64.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/* cpu.c: Dinky routines to look for the kind of Sparc cpu
- *        we are on.
- *
- * Copyright (C) 1996, 2007, 2008 David S. Miller (davem@davemloft.net)
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <asm/asi.h>
-#include <asm/system.h>
-#include <asm/fpumacro.h>
-#include <asm/cpudata.h>
-#include <asm/spitfire.h>
-#include <asm/oplib.h>
-
-#include "entry.h"
-#include "kernel.h"
-
-DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
-
-struct cpu_chip_info {
-	unsigned short	manuf;
-	unsigned short	impl;
-	const char	*cpu_name;
-	const char	*fp_name;
-};
-
-static const struct cpu_chip_info cpu_chips[] = {
-	{
-		.manuf		= 0x17,
-		.impl		= 0x10,
-		.cpu_name	= "TI UltraSparc I   (SpitFire)",
-		.fp_name	= "UltraSparc I integrated FPU",
-	},
-	{
-		.manuf		= 0x22,
-		.impl		= 0x10,
-		.cpu_name	= "TI UltraSparc I   (SpitFire)",
-		.fp_name	= "UltraSparc I integrated FPU",
-	},
-	{
-		.manuf		= 0x17,
-		.impl		= 0x11,
-		.cpu_name	= "TI UltraSparc II  (BlackBird)",
-		.fp_name	= "UltraSparc II integrated FPU",
-	},
-	{
-		.manuf		= 0x17,
-		.impl		= 0x12,
-		.cpu_name	= "TI UltraSparc IIi (Sabre)",
-		.fp_name	= "UltraSparc IIi integrated FPU",
-	},
-	{
-		.manuf		= 0x17,
-		.impl		= 0x13,
-		.cpu_name	= "TI UltraSparc IIe (Hummingbird)",
-		.fp_name	= "UltraSparc IIe integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x14,
-		.cpu_name	= "TI UltraSparc III (Cheetah)",
-		.fp_name	= "UltraSparc III integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x15,
-		.cpu_name	= "TI UltraSparc III+ (Cheetah+)",
-		.fp_name	= "UltraSparc III+ integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x16,
-		.cpu_name	= "TI UltraSparc IIIi (Jalapeno)",
-		.fp_name	= "UltraSparc IIIi integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x18,
-		.cpu_name	= "TI UltraSparc IV (Jaguar)",
-		.fp_name	= "UltraSparc IV integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x19,
-		.cpu_name	= "TI UltraSparc IV+ (Panther)",
-		.fp_name	= "UltraSparc IV+ integrated FPU",
-	},
-	{
-		.manuf		= 0x3e,
-		.impl		= 0x22,
-		.cpu_name	= "TI UltraSparc IIIi+ (Serrano)",
-		.fp_name	= "UltraSparc IIIi+ integrated FPU",
-	},
-};
-
-#define NSPARCCHIPS ARRAY_SIZE(linux_sparc_chips)
-
-const char *sparc_cpu_type;
-const char *sparc_fpu_type;
-
-static void __init sun4v_cpu_probe(void)
-{
-	switch (sun4v_chip_type) {
-	case SUN4V_CHIP_NIAGARA1:
-		sparc_cpu_type = "UltraSparc T1 (Niagara)";
-		sparc_fpu_type = "UltraSparc T1 integrated FPU";
-		break;
-
-	case SUN4V_CHIP_NIAGARA2:
-		sparc_cpu_type = "UltraSparc T2 (Niagara2)";
-		sparc_fpu_type = "UltraSparc T2 integrated FPU";
-		break;
-
-	default:
-		printk(KERN_WARNING "CPU: Unknown sun4v cpu type [%s]\n",
-		       prom_cpu_compatible);
-		sparc_cpu_type = "Unknown SUN4V CPU";
-		sparc_fpu_type = "Unknown SUN4V FPU";
-		break;
-	}
-}
-
-static const struct cpu_chip_info * __init find_cpu_chip(unsigned short manuf,
-							 unsigned short impl)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cpu_chips); i++) {
-		const struct cpu_chip_info *p = &cpu_chips[i];
-
-		if (p->manuf = manuf && p->impl = impl)
-			return p;
-	}
-	return NULL;
-}
-
-static int __init cpu_type_probe(void)
-{
-	if (tlb_type = hypervisor) {
-		sun4v_cpu_probe();
-	} else {
-		unsigned long ver, manuf, impl;
-		const struct cpu_chip_info *p;
-	
-		__asm__ __volatile__("rdpr %%ver, %0" : "=r" (ver));
-	
-		manuf = ((ver >> 48) & 0xffff);
-		impl = ((ver >> 32) & 0xffff);
-
-		p = find_cpu_chip(manuf, impl);
-		if (p) {
-			sparc_cpu_type = p->cpu_name;
-			sparc_fpu_type = p->fp_name;
-		} else {
-			printk(KERN_ERR "CPU: Unknown chip, manuf[%lx] impl[%lx]\n",
-			       manuf, impl);
-			sparc_cpu_type = "Unknown CPU";
-			sparc_fpu_type = "Unknown FPU";
-		}
-	}
-	return 0;
-}
-
-arch_initcall(cpu_type_probe);
-- 
1.5.6.GIT

