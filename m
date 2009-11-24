From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:19:52 +0000
Subject: [PATCH 10/11] microblaze: gut implementation of
Message-Id: <20091124081944.6216.41834.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

Microblaze only has one CPU, it isn't SMP at all.  This function is
effectively just a no-op, so remove it.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/prom.c |   54 -----------------------------------------
 1 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 8c00457..1f79e4d 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -50,60 +50,6 @@ struct device_node *of_chosen;
 int __init early_init_dt_scan_cpus(unsigned long node, const char *uname,
 				   int depth, void *data)
 {
-	static int logical_cpuid;
-	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	const u32 *intserv;
-	int i, nthreads;
-	int found = 0;
-
-	/* We are scanning "cpu" nodes only */
-	if (type = NULL || strcmp(type, "cpu") != 0)
-		return 0;
-
-	/* Get physical cpuid */
-	intserv = of_get_flat_dt_prop(node, "reg", NULL);
-	nthreads = 1;
-
-	/*
-	 * Now see if any of these threads match our boot cpu.
-	 * NOTE: This must match the parsing done in smp_setup_cpu_maps.
-	 */
-	for (i = 0; i < nthreads; i++) {
-		/*
-		 * version 2 of the kexec param format adds the phys cpuid of
-		 * booted proc.
-		 */
-		if (initial_boot_params && initial_boot_params->version >= 2) {
-			if (intserv[i] =
-					initial_boot_params->boot_cpuid_phys) {
-				found = 1;
-				break;
-			}
-		} else {
-			/*
-			 * Check if it's the boot-cpu, set it's hw index now,
-			 * unfortunately this format did not support booting
-			 * off secondary threads.
-			 */
-			if (of_get_flat_dt_prop(node,
-					"linux,boot-cpu", NULL) != NULL) {
-				found = 1;
-				break;
-			}
-		}
-
-#ifdef CONFIG_SMP
-		/* logical cpu id is always 0 on UP kernels */
-		logical_cpuid++;
-#endif
-	}
-
-	if (found) {
-		pr_debug("boot cpu: logical %d physical %d\n", logical_cpuid,
-			intserv[i]);
-		boot_cpuid = logical_cpuid;
-	}
-
 	return 0;
 }
 

