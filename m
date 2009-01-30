From: David Miller <davem@davemloft.net>
Date: Fri, 30 Jan 2009 08:26:00 +0000
Subject: [PATCH 2/3]: sparc: Probe PMU type and record in sparc_pmu_type.
Message-Id: <20090130.002600.33237675.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/cpu.c      |   33 ++++++++++++++++++++++-----------
 arch/sparc/kernel/kernel.h   |    1 +
 arch/sparc/kernel/setup_64.c |    2 ++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 32d32b4..d85c3dc 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -26,6 +26,7 @@ EXPORT_PER_CPU_SYMBOL(__cpu_data);
 struct cpu_info {
 	int psr_vers;
 	const char *name;
+	const char *pmu_name;
 };
 
 struct fpu_info {
@@ -45,6 +46,9 @@ struct manufacturer_info {
 #define CPU(ver, _name) \
 { .psr_vers = ver, .name = _name }
 
+#define CPU_PMU(ver, _name, _pmu_name)	\
+{ .psr_vers = ver, .name = _name, .pmu_name = _pmu_name }
+
 #define FPU(ver, _name) \
 { .fp_vers = ver, .name = _name }
 
@@ -183,10 +187,10 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 },{
 	0x17,
 	.cpu_info = {
-		CPU(0x10, "TI UltraSparc I   (SpitFire)"),
-		CPU(0x11, "TI UltraSparc II  (BlackBird)"),
-		CPU(0x12, "TI UltraSparc IIi (Sabre)"),
-		CPU(0x13, "TI UltraSparc IIe (Hummingbird)"),
+		CPU_PMU(0x10, "TI UltraSparc I   (SpitFire)", "ultra12"),
+		CPU_PMU(0x11, "TI UltraSparc II  (BlackBird)", "ultra12"),
+		CPU_PMU(0x12, "TI UltraSparc IIi (Sabre)", "ultra12"),
+		CPU_PMU(0x13, "TI UltraSparc IIe (Hummingbird)", "ultra12"),
 		CPU(-1, NULL)
 	},
 	.fpu_info = {
@@ -199,7 +203,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 },{
 	0x22,
 	.cpu_info = {
-		CPU(0x10, "TI UltraSparc I   (SpitFire)"),
+		CPU_PMU(0x10, "TI UltraSparc I   (SpitFire)", "ultra12"),
 		CPU(-1, NULL)
 	},
 	.fpu_info = {
@@ -209,12 +213,12 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 },{
 	0x3e,
 	.cpu_info = {
-		CPU(0x14, "TI UltraSparc III (Cheetah)"),
-		CPU(0x15, "TI UltraSparc III+ (Cheetah+)"),
-		CPU(0x16, "TI UltraSparc IIIi (Jalapeno)"),
-		CPU(0x18, "TI UltraSparc IV (Jaguar)"),
-		CPU(0x19, "TI UltraSparc IV+ (Panther)"),
-		CPU(0x22, "TI UltraSparc IIIi+ (Serrano)"),
+		CPU_PMU(0x14, "TI UltraSparc III (Cheetah)", "ultra3"),
+		CPU_PMU(0x15, "TI UltraSparc III+ (Cheetah+)", "ultra3+"),
+		CPU_PMU(0x16, "TI UltraSparc IIIi (Jalapeno)", "ultra3i"),
+		CPU_PMU(0x18, "TI UltraSparc IV (Jaguar)", "ultra3+"),
+		CPU_PMU(0x19, "TI UltraSparc IV+ (Panther)", "ultra4+"),
+		CPU_PMU(0x22, "TI UltraSparc IIIi+ (Serrano)", "ultra3i"),
 		CPU(-1, NULL)
 	},
 	.fpu_info = {
@@ -234,6 +238,7 @@ static const struct manufacturer_info __initconst manufacturer_info[] = {
 
 const char *sparc_cpu_type;
 const char *sparc_fpu_type;
+const char *sparc_pmu_type;
 
 unsigned int fsr_storage;
 
@@ -244,6 +249,7 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 
 	sparc_cpu_type = NULL;
 	sparc_fpu_type = NULL;
+	sparc_pmu_type = NULL;
 	manuf = NULL;
 
 	for (i = 0; i < ARRAY_SIZE(manufacturer_info); i++)
@@ -263,6 +269,7 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 		{
 			if (cpu->psr_vers = psr_vers) {
 				sparc_cpu_type = cpu->name;
+				sparc_pmu_type = cpu->pmu_name;
 				sparc_fpu_type = "No FPU";
 				break;
 			}
@@ -290,6 +297,8 @@ static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 		       psr_impl, fpu_vers);
 		sparc_fpu_type = "Unknown FPU";
 	}
+	if (sparc_pmu_type = NULL)
+		sparc_pmu_type = "Unknown PMU";
 }
 
 #ifdef CONFIG_SPARC32
@@ -315,11 +324,13 @@ static void __init sun4v_cpu_probe(void)
 	case SUN4V_CHIP_NIAGARA1:
 		sparc_cpu_type = "UltraSparc T1 (Niagara)";
 		sparc_fpu_type = "UltraSparc T1 integrated FPU";
+		sparc_pmu_type = "niagara";
 		break;
 
 	case SUN4V_CHIP_NIAGARA2:
 		sparc_cpu_type = "UltraSparc T2 (Niagara2)";
 		sparc_fpu_type = "UltraSparc T2 integrated FPU";
+		sparc_pmu_type = "niagara2";
 		break;
 
 	default:
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 81a972e..15d8a3f 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -5,6 +5,7 @@
 
 /* cpu.c */
 extern const char *sparc_cpu_type;
+extern const char *sparc_pmu_type;
 extern const char *sparc_fpu_type;
 
 extern unsigned int fsr_storage;
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 49d061f..f2bcfd2 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -354,6 +354,7 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 	seq_printf(m, 
 		   "cpu\t\t: %s\n"
 		   "fpu\t\t: %s\n"
+		   "pmu\t\t: %s\n"
 		   "prom\t\t: %s\n"
 		   "type\t\t: %s\n"
 		   "ncpus probed\t: %d\n"
@@ -366,6 +367,7 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   ,
 		   sparc_cpu_type,
 		   sparc_fpu_type,
+		   sparc_pmu_type,
 		   prom_version,
 		   ((tlb_type = hypervisor) ?
 		    "sun4v" :
-- 
1.6.1.2.253.ga34a

