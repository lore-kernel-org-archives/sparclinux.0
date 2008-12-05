From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 05 Dec 2008 19:55:22 +0000
Subject: [PATCH] sparc: report "Unknown CPU/FPU" for unknown cpu/fpu
Message-Id: <20081205195522.GA8526@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If we cannot determine the CPU or FPU report
"Unknown CPU" or "Unknown FPU" like sparc64 does.

And report with KERN_ERR that we cannot determine the CPU.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This killed the magic [31] I complained about in last mail.

	Sam

 arch/sparc/kernel/cpu_32.c   |    9 ++++++---
 arch/sparc/kernel/setup_32.c |    4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/cpu_32.c b/arch/sparc/kernel/cpu_32.c
index d0fe5d2..cdaf763 100644
--- a/arch/sparc/kernel/cpu_32.c
+++ b/arch/sparc/kernel/cpu_32.c
@@ -152,8 +152,11 @@ void __cpuinit cpu_probe(void)
 	}
 
 	if (i = NSPARCCHIPS)
-		printk(KERN_DEBUG "psr.impl = 0x%x   psr.vers = 0x%x\n",
+	{
+		printk(KERN_ERR "CPU: Unknown chip, impl[0x%x] vers[0x%x]\n",
 		       psr_impl, psr_vers);
+		sparc_cpu_type = "Unknown CPU";
+	}
 
 	for (i = 0; i < NSPARCFPU; i++) {
 		if (linux_sparc_fpu[i].psr_impl = psr_impl)
@@ -164,8 +167,8 @@ void __cpuinit cpu_probe(void)
 	}
 
 	if (i = NSPARCFPU) {
-		printk(KERN_DEBUG "psr.impl = 0x%x  fsr.vers = 0x%x\n",
+		printk(KERN_ERR "FPU: Unknown chip, impl[0x%x] vers[0x%x]\n",
 		       psr_impl, fpu_vers);
-		sparc_fpu_type = linux_sparc_fpu[31].fp_name;
+		sparc_fpu_type = "Unknown FPU";
 	}
 }
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 24fe307..d21abbe 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -328,8 +328,8 @@ static int show_cpuinfo(struct seq_file *m, void *__unused)
 		   "CPU0ClkTck\t: %ld\n"
 #endif
 		   ,
-		   sparc_cpu_type ? sparc_cpu_type : "undetermined",
-		   sparc_fpu_type ? sparc_fpu_type : "undetermined",
+		   sparc_cpu_type,
+		   sparc_fpu_type ,
 		   romvec->pv_romvers,
 		   prom_rev,
 		   romvec->pv_printrev >> 16,
-- 
1.5.6.GIT

