From: David Miller <davem@davemloft.net>
Date: Mon, 01 Sep 2008 04:49:41 +0000
Subject: [PATCH]: sparc64: Clean up CPU chip type probing code.
Message-Id: <20080831.214941.245462561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I've always wanted to get rid of some of the cob webs in this
guy.

sparc64: Clean up CPU chip type probing code.

Three main things:

1) Make prober an arch initcall instead of using hard-coded invocation
   from paging_init()

2) Shrink table size, the fpu ident stuff was never used.

3) Use named struct initialized in table.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/cpudata_64.h |    1 -
 arch/sparc64/kernel/cpu.c           |  208 ++++++++++++++++++-----------------
 arch/sparc64/kernel/entry.h         |    4 +-
 arch/sparc64/mm/init.c              |    2 -
 4 files changed, 111 insertions(+), 104 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 532975e..7da7c13 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -86,7 +86,6 @@ extern struct trap_per_cpu trap_block[NR_CPUS];
 extern void init_cur_cpu_trap(struct thread_info *);
 extern void setup_tba(void);
 extern int ncpus_probed;
-extern void __init cpu_probe(void);
 extern const struct seq_operations cpuinfo_op;
 
 extern unsigned long real_hard_smp_processor_id(void);
diff --git a/arch/sparc64/kernel/cpu.c b/arch/sparc64/kernel/cpu.c
index 0097c08..0c9ac83 100644
--- a/arch/sparc64/kernel/cpu.c
+++ b/arch/sparc64/kernel/cpu.c
@@ -1,7 +1,7 @@
 /* cpu.c: Dinky routines to look for the kind of Sparc cpu
  *        we are on.
  *
- * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 2007, 2008 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/kernel.h>
@@ -19,53 +19,86 @@
 
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 
-struct cpu_iu_info {
-  short manuf;
-  short impl;
-  char* cpu_name;   /* should be enough I hope... */
+struct cpu_chip_info {
+	unsigned short	manuf;
+	unsigned short	impl;
+	const char	*cpu_name;
+	const char	*fp_name;
 };
 
-struct cpu_fp_info {
-  short manuf;
-  short impl;
-  char fpu_vers;
-  char* fp_name;
+static const struct cpu_chip_info cpu_chips[] = {
+	{
+		.manuf		= 0x17,
+		.impl		= 0x10,
+		.cpu_name	= "TI UltraSparc I   (SpitFire)",
+		.fp_name	= "UltraSparc I integrated FPU",
+	},
+	{
+		.manuf		= 0x22,
+		.impl		= 0x10,
+		.cpu_name	= "TI UltraSparc I   (SpitFire)",
+		.fp_name	= "UltraSparc I integrated FPU",
+	},
+	{
+		.manuf		= 0x17,
+		.impl		= 0x11,
+		.cpu_name	= "TI UltraSparc II  (BlackBird)",
+		.fp_name	= "UltraSparc II integrated FPU",
+	},
+	{
+		.manuf		= 0x17,
+		.impl		= 0x12,
+		.cpu_name	= "TI UltraSparc IIi (Sabre)",
+		.fp_name	= "UltraSparc IIi integrated FPU",
+	},
+	{
+		.manuf		= 0x17,
+		.impl		= 0x13,
+		.cpu_name	= "TI UltraSparc IIe (Hummingbird)",
+		.fp_name	= "UltraSparc IIe integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x14,
+		.cpu_name	= "TI UltraSparc III (Cheetah)",
+		.fp_name	= "UltraSparc III integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x15,
+		.cpu_name	= "TI UltraSparc III+ (Cheetah+)",
+		.fp_name	= "UltraSparc III+ integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x16,
+		.cpu_name	= "TI UltraSparc IIIi (Jalapeno)",
+		.fp_name	= "UltraSparc IIIi integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x18,
+		.cpu_name	= "TI UltraSparc IV (Jaguar)",
+		.fp_name	= "UltraSparc IV integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x19,
+		.cpu_name	= "TI UltraSparc IV+ (Panther)",
+		.fp_name	= "UltraSparc IV+ integrated FPU",
+	},
+	{
+		.manuf		= 0x3e,
+		.impl		= 0x22,
+		.cpu_name	= "TI UltraSparc IIIi+ (Serrano)",
+		.fp_name	= "UltraSparc IIIi+ integrated FPU",
+	},
 };
 
-static struct cpu_fp_info linux_sparc_fpu[] = {
-  { 0x17, 0x10, 0, "UltraSparc I integrated FPU"},
-  { 0x22, 0x10, 0, "UltraSparc I integrated FPU"},
-  { 0x17, 0x11, 0, "UltraSparc II integrated FPU"},
-  { 0x17, 0x12, 0, "UltraSparc IIi integrated FPU"},
-  { 0x17, 0x13, 0, "UltraSparc IIe integrated FPU"},
-  { 0x3e, 0x14, 0, "UltraSparc III integrated FPU"},
-  { 0x3e, 0x15, 0, "UltraSparc III+ integrated FPU"},
-  { 0x3e, 0x16, 0, "UltraSparc IIIi integrated FPU"},
-  { 0x3e, 0x18, 0, "UltraSparc IV integrated FPU"},
-  { 0x3e, 0x19, 0, "UltraSparc IV+ integrated FPU"},
-  { 0x3e, 0x22, 0, "UltraSparc IIIi+ integrated FPU"},
-};
-
-#define NSPARCFPU  ARRAY_SIZE(linux_sparc_fpu)
-
-static struct cpu_iu_info linux_sparc_chips[] = {
-  { 0x17, 0x10, "TI UltraSparc I   (SpitFire)"},
-  { 0x22, 0x10, "TI UltraSparc I   (SpitFire)"},
-  { 0x17, 0x11, "TI UltraSparc II  (BlackBird)"},
-  { 0x17, 0x12, "TI UltraSparc IIi (Sabre)"},
-  { 0x17, 0x13, "TI UltraSparc IIe (Hummingbird)"},
-  { 0x3e, 0x14, "TI UltraSparc III (Cheetah)"},
-  { 0x3e, 0x15, "TI UltraSparc III+ (Cheetah+)"},
-  { 0x3e, 0x16, "TI UltraSparc IIIi (Jalapeno)"},
-  { 0x3e, 0x18, "TI UltraSparc IV (Jaguar)"},
-  { 0x3e, 0x19, "TI UltraSparc IV+ (Panther)"},
-  { 0x3e, 0x22, "TI UltraSparc IIIi+ (Serrano)"},
-};
+#define NSPARCCHIPS ARRAY_SIZE(linux_sparc_chips)
 
-#define NSPARCCHIPS  ARRAY_SIZE(linux_sparc_chips)
-
-char *sparc_cpu_type;
-char *sparc_fpu_type;
+const char *sparc_cpu_type;
+const char *sparc_fpu_type;
 
 static void __init sun4v_cpu_probe(void)
 {
@@ -89,68 +122,45 @@ static void __init sun4v_cpu_probe(void)
 	}
 }
 
-void __init cpu_probe(void)
+static const struct cpu_chip_info * __init find_cpu_chip(unsigned short manuf,
+							 unsigned short impl)
 {
-	unsigned long ver, fpu_vers, manuf, impl, fprs;
 	int i;
-	
-	if (tlb_type = hypervisor) {
-		sun4v_cpu_probe();
-		return;
-	}
 
-	fprs = fprs_read();
-	fprs_write(FPRS_FEF);
-	__asm__ __volatile__ ("rdpr %%ver, %0; stx %%fsr, [%1]"
-			      : "=&r" (ver)
-			      : "r" (&fpu_vers));
-	fprs_write(fprs);
-	
-	manuf = ((ver >> 48) & 0xffff);
-	impl = ((ver >> 32) & 0xffff);
-
-	fpu_vers = ((fpu_vers >> 17) & 0x7);
-
-retry:
-	for (i = 0; i < NSPARCCHIPS; i++) {
-		if (linux_sparc_chips[i].manuf = manuf) {
-			if (linux_sparc_chips[i].impl = impl) {
-				sparc_cpu_type -					linux_sparc_chips[i].cpu_name;
-				break;
-			}
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(cpu_chips); i++) {
+		const struct cpu_chip_info *p = &cpu_chips[i];
 
-	if (i = NSPARCCHIPS) {
- 		/* Maybe it is a cheetah+ derivative, report it as cheetah+
- 		 * in that case until we learn the real names.
- 		 */
- 		if (manuf = 0x3e &&
- 		    impl > 0x15) {
- 			impl = 0x15;
- 			goto retry;
- 		} else {
- 			printk("DEBUG: manuf[%lx] impl[%lx]\n",
- 			       manuf, impl);
- 		}
-		sparc_cpu_type = "Unknown CPU";
+		if (p->manuf = manuf && p->impl = impl)
+			return p;
 	}
+	return NULL;
+}
 
-	for (i = 0; i < NSPARCFPU; i++) {
-		if (linux_sparc_fpu[i].manuf = manuf &&
-		    linux_sparc_fpu[i].impl = impl) {
-			if (linux_sparc_fpu[i].fpu_vers = fpu_vers) {
-				sparc_fpu_type -					linux_sparc_fpu[i].fp_name;
-				break;
-			}
+static int __init cpu_type_probe(void)
+{
+	if (tlb_type = hypervisor) {
+		sun4v_cpu_probe();
+	} else {
+		unsigned long ver, manuf, impl;
+		const struct cpu_chip_info *p;
+	
+		__asm__ __volatile__("rdpr %%ver, %0" : "=r" (ver));
+	
+		manuf = ((ver >> 48) & 0xffff);
+		impl = ((ver >> 32) & 0xffff);
+
+		p = find_cpu_chip(manuf, impl);
+		if (p) {
+			sparc_cpu_type = p->cpu_name;
+			sparc_fpu_type = p->fp_name;
+		} else {
+			printk(KERN_ERR "CPU: Unknown chip, manuf[%lx] impl[%lx]\n",
+			       manuf, impl);
+			sparc_cpu_type = "Unknown CPU";
+			sparc_fpu_type = "Unknown FPU";
 		}
 	}
-
-	if (i = NSPARCFPU) {
- 		printk("DEBUG: manuf[%lx] impl[%lx] fsr.vers[%lx]\n",
- 		       manuf, impl, fpu_vers);
-		sparc_fpu_type = "Unknown FPU";
-	}
+	return 0;
 }
+
+arch_initcall(cpu_type_probe);
diff --git a/arch/sparc64/kernel/entry.h b/arch/sparc64/kernel/entry.h
index 2255244..34d7ab5 100644
--- a/arch/sparc64/kernel/entry.h
+++ b/arch/sparc64/kernel/entry.h
@@ -5,8 +5,8 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
-extern char *sparc_cpu_type;
-extern char *sparc_fpu_type;
+extern const char *sparc_cpu_type;
+extern const char *sparc_fpu_type;
 
 extern void __init per_cpu_patch(void);
 extern void __init sun4v_patch(void);
diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index 8cc1892..54193f2 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -1841,8 +1841,6 @@ void __init paging_init(void)
 	}
 
 	printk("Booting Linux...\n");
-
-	cpu_probe();
 }
 
 int __init page_in_phys_avail(unsigned long paddr)
-- 
1.5.6.5.GIT

