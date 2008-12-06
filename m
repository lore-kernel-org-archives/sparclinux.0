From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 20:57:10 +0000
Subject: [RFC PATCH] sparc: expand cpu table
Message-Id: <20081206205710.GA27536@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Prepare cputable to include sparc64 versions
Declare it __initconst so it can be dropped after init

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I had to hardcode the arraysize - but as this is initdata
I think it does not matter.

This patch is only build tested - so the chance for
a stupid code bug exists.

Please review the approch and drop it if you do not like it.

Final unification patch follows.

	Sam

 arch/sparc/kernel/cpu_32.c |  319 +++++++++++++++++++++++++++-----------------
 1 files changed, 195 insertions(+), 124 deletions(-)

diff --git a/arch/sparc/kernel/cpu_32.c b/arch/sparc/kernel/cpu_32.c
index 4e14240..6052822 100644
--- a/arch/sparc/kernel/cpu_32.c
+++ b/arch/sparc/kernel/cpu_32.c
@@ -19,158 +19,229 @@
 
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 
-struct cpu_iu_info {
-	int psr_impl;
+struct cpu_info {
 	int psr_vers;
-	char *cpu_name;   /* should be enough I hope... */
+	const char *name;
 };
 
-struct cpu_fp_info {
-	int psr_impl;
+struct fpu_info {
 	int fp_vers;
-	char *fp_name;
+	const char *name;
 };
 
-/* In order to get the fpu type correct, you need to take the IDPROM's
- * machine type value into consideration too.  I will fix this.
- */
-#define CPU_FP(psr, ver, name) \
-{ .psr_impl = (psr), .fp_vers = (ver), .fp_name = (name) }
-static struct cpu_fp_info linux_sparc_fpu[] = {
-	CPU_FP(0, 0, "Fujitsu MB86910 or Weitek WTL1164/5"),
-	CPU_FP(0, 1, "Fujitsu MB86911 or Weitek WTL1164/5 or LSI L64831"),
-	CPU_FP(0, 2, "LSI Logic L64802 or Texas Instruments ACT8847"),
-	/* SparcStation SLC, SparcStation1 */
-	CPU_FP(0, 3, "Weitek WTL3170/2"),
-	/* SPARCstation-5 */
-	CPU_FP(0, 4, "Lsi Logic/Meiko L64804 or compatible"),
-	CPU_FP(0, 5, "reserved"),
-	CPU_FP(0, 6, "reserved"),
-	CPU_FP(0, 7, "No FPU"),
-	CPU_FP(1, 0, "ROSS HyperSparc combined IU/FPU"),
-	CPU_FP(1, 1, "Lsi Logic L64814"),
-	CPU_FP(1, 2, "Texas Instruments TMS390-C602A"),
-	CPU_FP(1, 3, "Cypress CY7C602 FPU"),
-	CPU_FP(1, 4, "reserved"),
-	CPU_FP(1, 5, "reserved"),
-	CPU_FP(1, 6, "reserved"),
-	CPU_FP(1, 7, "No FPU"),
-	CPU_FP(2, 0, "BIT B5010 or B5110/20 or B5210"),
-	CPU_FP(2, 1, "reserved"),
-	CPU_FP(2, 2, "reserved"),
-	CPU_FP(2, 3, "reserved"),
-	CPU_FP(2, 4, "reserved"),
-	CPU_FP(2, 5, "reserved"),
-	CPU_FP(2, 6, "reserved"),
-	CPU_FP(2, 7, "No FPU"),
-	/* SuperSparc 50 module */
-	CPU_FP(4, 0, "SuperSparc on-chip FPU"),
-	/* SparcClassic */
-	CPU_FP(4, 4, "TI MicroSparc on chip FPU"),
-	CPU_FP(5, 0, "Matsushita MN10501"),
-	CPU_FP(5, 1, "reserved"),
-	CPU_FP(5, 2, "reserved"),
-	CPU_FP(5, 3, "reserved"),
-	CPU_FP(5, 4, "reserved"),
-	CPU_FP(5, 5, "reserved"),
-	CPU_FP(5, 6, "reserved"),
-	CPU_FP(5, 7, "No FPU"),
-	CPU_FP(9, 3, "Fujitsu or Weitek on-chip FPU"),
+#define NOCPU 8
+#define NOFPU 8
+
+struct manufacturer_info {
+	int psr_impl;
+	struct cpu_info cpu_info[NOCPU];
+	struct fpu_info fpu_info[NOFPU];
 };
 
-#define NSPARCFPU  ARRAY_SIZE(linux_sparc_fpu)
+#define CPU(ver, _name) \
+{ .psr_vers = ver, .name = _name }
+
+#define FPU(ver, _name) \
+{ .fp_vers = ver, .name = _name }
 
-#define CPU_INFO(psr, ver, name) \
-{ .psr_impl = (psr), .psr_vers = (ver), .cpu_name = (name) }
-static struct cpu_iu_info linux_sparc_chips[] = {
+static const struct manufacturer_info __initconst manufacturer_info[] = {
+{
+	0,
 	/* Sun4/100, 4/200, SLC */
-	CPU_INFO(0, 0, "Fujitsu  MB86900/1A or LSI L64831 SparcKIT-40"),
-	/* borned STP1012PGA */
-	CPU_INFO(0, 4, "Fujitsu  MB86904"),
-	CPU_INFO(0, 5, "Fujitsu TurboSparc MB86907"),
-	/* SparcStation2, SparcServer 490 & 690 */
-	CPU_INFO(1, 0, "LSI Logic Corporation - L64811"),
-	/* SparcStation2 */
-	CPU_INFO(1, 1, "Cypress/ROSS CY7C601"),
-	/* Embedded controller */
-	CPU_INFO(1, 3, "Cypress/ROSS CY7C611"),
-	/* Ross Technologies HyperSparc */
-	CPU_INFO(1, 0xf, "ROSS HyperSparc RT620"),
-	CPU_INFO(1, 0xe, "ROSS HyperSparc RT625 or RT626"),
-	/* ECL Implementation, CRAY S-MP Supercomputer... AIEEE! */
-	/* Someone please write the code to support this beast! ;) */
-	CPU_INFO(2, 0, "Bipolar Integrated Technology - B5010"),
-	CPU_INFO(3, 0, "LSI Logic Corporation - unknown-type"),
-	CPU_INFO(4, 0, "Texas Instruments, Inc. - SuperSparc-(II)"),
-	/* SparcClassic  --  borned STP1010TAB-50*/
-	CPU_INFO(4, 1, "Texas Instruments, Inc. - MicroSparc"),
-	CPU_INFO(4, 2, "Texas Instruments, Inc. - MicroSparc II"),
-	CPU_INFO(4, 3, "Texas Instruments, Inc. - SuperSparc 51"),
-	CPU_INFO(4, 4, "Texas Instruments, Inc. - SuperSparc 61"),
-	CPU_INFO(4, 5, "Texas Instruments, Inc. - unknown"),
-	CPU_INFO(5, 0, "Matsushita - MN10501"),
-	CPU_INFO(6, 0, "Philips Corporation - unknown"),
-	CPU_INFO(7, 0, "Harvest VLSI Design Center, Inc. - unknown"),
-	/* Gallium arsenide 200MHz, BOOOOGOOOOMIPS!!! */
-	CPU_INFO(8, 0, "Systems and Processes Engineering Corporation (SPEC)"),
-	CPU_INFO(9, 0, "Fujitsu or Weitek Power-UP"),
-	CPU_INFO(9, 1, "Fujitsu or Weitek Power-UP"),
-	CPU_INFO(9, 2, "Fujitsu or Weitek Power-UP"),
-	CPU_INFO(9, 3, "Fujitsu or Weitek Power-UP"),
-	CPU_INFO(0xa, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-	CPU_INFO(0xb, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-	CPU_INFO(0xc, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-	CPU_INFO(0xd, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-	CPU_INFO(0xe, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-	CPU_INFO(0xf, 0, "UNKNOWN CPU-VENDOR/TYPE"),
-};
+	.cpu_info = {
+		CPU(0, "Fujitsu  MB86900/1A or LSI L64831 SparcKIT-40"),
+		/* borned STP1012PGA */
+		CPU(4,  "Fujitsu  MB86904"),
+		CPU(5, "Fujitsu TurboSparc MB86907"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0, "Fujitsu MB86910 or Weitek WTL1164/5"),
+		FPU(1, "Fujitsu MB86911 or Weitek WTL1164/5 or LSI L64831"),
+		FPU(2, "LSI Logic L64802 or Texas Instruments ACT8847"),
+		/* SparcStation SLC, SparcStation1 */
+		FPU(3, "Weitek WTL3170/2"),
+		/* SPARCstation-5 */
+		FPU(4, "Lsi Logic/Meiko L64804 or compatible"),
+		FPU(-1, NULL)
+	}
+},{
+	1,
+	.cpu_info = {
+		/* SparcStation2, SparcServer 490 & 690 */
+		CPU(0, "LSI Logic Corporation - L64811"),
+		/* SparcStation2 */
+		CPU(1, "Cypress/ROSS CY7C601"),
+		/* Embedded controller */
+		CPU(3, "Cypress/ROSS CY7C611"),
+		/* Ross Technologies HyperSparc */
+		CPU(0xf, "ROSS HyperSparc RT620"),
+		CPU(0xe, "ROSS HyperSparc RT625 or RT626"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0, "ROSS HyperSparc combined IU/FPU"),
+		FPU(1, "Lsi Logic L64814"),
+		FPU(2, "Texas Instruments TMS390-C602A"),
+		FPU(3, "Cypress CY7C602 FPU"),
+		FPU(-1, NULL)
+	}
+},{
+	2,
+	.cpu_info = {
+		/* ECL Implementation, CRAY S-MP Supercomputer... AIEEE! */
+		/* Someone please write the code to support this beast! ;) */
+		CPU(0, "Bipolar Integrated Technology - B5010"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(-1, NULL)
+	}
+},{
+	3,
+	.cpu_info = {
+		CPU(0, "LSI Logic Corporation - unknown-type"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(-1, NULL)
+	}
+},{
+	4,
+	.cpu_info = {
+		CPU(0, "Texas Instruments, Inc. - SuperSparc-(II)"),
+		/* SparcClassic  --  borned STP1010TAB-50*/
+		CPU(1, "Texas Instruments, Inc. - MicroSparc"),
+		CPU(2, "Texas Instruments, Inc. - MicroSparc II"),
+		CPU(3, "Texas Instruments, Inc. - SuperSparc 51"),
+		CPU(4, "Texas Instruments, Inc. - SuperSparc 61"),
+		CPU(5, "Texas Instruments, Inc. - unknown"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		/* SuperSparc 50 module */
+		FPU(0, "SuperSparc on-chip FPU"),
+		/* SparcClassic */
+		FPU(4, "TI MicroSparc on chip FPU"),
+		FPU(-1, NULL)
+	}
+},{
+	5,
+	.cpu_info = {
+		CPU(0, "Matsushita - MN10501"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(0, "Matsushita MN10501"),
+		FPU(-1, NULL)
+	}
+},{
+	6,
+	.cpu_info = {
+		CPU(0, "Philips Corporation - unknown"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(-1, NULL)
+	}
+},{
+	7,
+	.cpu_info = {
+		CPU(0, "Harvest VLSI Design Center, Inc. - unknown"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(-1, NULL)
+	}
+},{
+	8,
+	.cpu_info = {
+		CPU(0, "Systems and Processes Engineering Corporation (SPEC)"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(-1, NULL)
+	}
+},{
+	9,
+	.cpu_info = {
+		/* Gallium arsenide 200MHz, BOOOOGOOOOMIPS!!! */
+		CPU(0, "Fujitsu or Weitek Power-UP"),
+		CPU(1, "Fujitsu or Weitek Power-UP"),
+		CPU(2, "Fujitsu or Weitek Power-UP"),
+		CPU(3, "Fujitsu or Weitek Power-UP"),
+		CPU(-1, NULL)
+	},
+	.fpu_info = {
+		FPU(3, "Fujitsu or Weitek on-chip FPU"),
+		FPU(-1, NULL)
+	}
+}};
 
-#define NSPARCCHIPS  ARRAY_SIZE(linux_sparc_chips)
+/* In order to get the fpu type correct, you need to take the IDPROM's
+ * machine type value into consideration too.  I will fix this.
+ */
 
 const char *sparc_cpu_type;
 const char *sparc_fpu_type;
 
 unsigned int fsr_storage;
 
-void __cpuinit cpu_probe(void)
+static void set_cpu_and_fpu(int psr_impl, int psr_vers, int fpu_vers)
 {
-	int psr_impl, psr_vers, fpu_vers;
-	int i, psr;
-
-	psr_impl = ((get_psr() >> 28) & 0xf);
-	psr_vers = ((get_psr() >> 24) & 0xf);
-
-	psr = get_psr();
-	put_psr(psr | PSR_EF);
-	fpu_vers = ((get_fsr() >> 17) & 0x7);
-	put_psr(psr);
-
-	for (i = 0; i < NSPARCCHIPS; i++) {
-		if (linux_sparc_chips[i].psr_impl = psr_impl)
-			if (linux_sparc_chips[i].psr_vers = psr_vers) {
-				sparc_cpu_type = linux_sparc_chips[i].cpu_name;
+	sparc_cpu_type = NULL;
+	sparc_fpu_type = NULL;
+	if (psr_impl < ARRAY_SIZE(manufacturer_info))
+	{
+		const struct cpu_info *cpu;
+		const struct fpu_info *fpu;
+
+		cpu = &manufacturer_info[psr_impl].cpu_info[0];
+		while (cpu->psr_vers != -1)
+		{
+			if (cpu->psr_vers = psr_vers) {
+				sparc_cpu_type = cpu->name;
+				sparc_fpu_type = "No FPU";
+				break;
+			}
+			cpu++;
+		}
+		fpu =  &manufacturer_info[psr_impl].fpu_info[0];
+		while (fpu->fp_vers != -1)
+		{
+			if (fpu->fp_vers = fpu_vers) {
+				sparc_fpu_type = fpu->name;
 				break;
 			}
+			fpu++;
+		}
 	}
-
-	if (i = NSPARCCHIPS)
+	if (sparc_cpu_type = NULL)
 	{
 		printk(KERN_ERR "CPU: Unknown chip, impl[0x%x] vers[0x%x]\n",
 		       psr_impl, psr_vers);
 		sparc_cpu_type = "Unknown CPU";
 	}
-
-	for (i = 0; i < NSPARCFPU; i++) {
-		if (linux_sparc_fpu[i].psr_impl = psr_impl)
-			if (linux_sparc_fpu[i].fp_vers = fpu_vers) {
-				sparc_fpu_type = linux_sparc_fpu[i].fp_name;
-				break;
-			}
-	}
-
-	if (i = NSPARCFPU) {
+	if (sparc_fpu_type = NULL)
+	{
 		printk(KERN_ERR "FPU: Unknown chip, impl[0x%x] vers[0x%x]\n",
 		       psr_impl, fpu_vers);
 		sparc_fpu_type = "Unknown FPU";
 	}
 }
+
+void __cpuinit cpu_probe(void)
+{
+	int psr_impl, psr_vers, fpu_vers;
+	int psr;
+
+	psr_impl = ((get_psr() >> 28) & 0xf);
+	psr_vers = ((get_psr() >> 24) & 0xf);
+
+	psr = get_psr();
+	put_psr(psr | PSR_EF);
+	fpu_vers = ((get_fsr() >> 17) & 0x7);
+	put_psr(psr);
+
+	set_cpu_and_fpu(psr_impl, psr_vers, fpu_vers);
+}
-- 
1.5.6.GIT

