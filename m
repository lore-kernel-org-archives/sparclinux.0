From: David Miller <davem@davemloft.net>
Date: Thu, 09 Apr 2009 05:37:43 +0000
Subject: [PATCH 7/12]: sparc: Call OF and MD cpu scanning explicitly from
Message-Id: <20090408.223743.101682480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tj@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


We need to split up the cpu present mask setup from the cpu_data
initialization, and this is a first step towards that.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/prom.h   |    1 +
 arch/sparc/kernel/mdesc.c       |    4 ----
 arch/sparc/kernel/prom.h        |    1 -
 arch/sparc/kernel/prom_common.c |    2 --
 arch/sparc/mm/init_32.c         |    1 +
 arch/sparc/mm/init_64.c         |    5 ++++-
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/prom.h b/arch/sparc/include/asm/prom.h
index 1b15212..be8d7aa 100644
--- a/arch/sparc/include/asm/prom.h
+++ b/arch/sparc/include/asm/prom.h
@@ -87,6 +87,7 @@ extern int of_node_to_nid(struct device_node *dp);
 
 extern void prom_build_devicetree(void);
 extern void of_populate_present_mask(void);
+extern void of_fill_in_cpu_data(void);
 
 /* Dummy ref counting routines - to be implemented later */
 static inline struct device_node *of_node_get(struct device_node *node)
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index f50af3f..602cbb7 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -919,7 +919,6 @@ void __init sun4v_mdesc_init(void)
 {
 	struct mdesc_handle *hp;
 	unsigned long len, real_len, status;
-	cpumask_t mask;
 
 	(void) sun4v_mach_desc(0UL, 0UL, &len);
 
@@ -943,7 +942,4 @@ void __init sun4v_mdesc_init(void)
 	cur_mdesc = hp;
 
 	report_platform_properties();
-
-	cpus_setall(mask);
-	mdesc_fill_in_cpu_data(mask);
 }
diff --git a/arch/sparc/kernel/prom.h b/arch/sparc/kernel/prom.h
index bb0f0fd..453397f 100644
--- a/arch/sparc/kernel/prom.h
+++ b/arch/sparc/kernel/prom.h
@@ -22,7 +22,6 @@ static inline int is_root_node(const struct device_node *dp)
 
 extern char *build_path_component(struct device_node *dp);
 extern void of_console_init(void);
-extern void of_fill_in_cpu_data(void);
 
 extern unsigned int prom_early_allocated;
 
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index ff7b591..0fb5789 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -313,6 +313,4 @@ void __init prom_build_devicetree(void)
 
 	printk("PROM: Built device tree with %u bytes of memory.\n",
 	       prom_early_allocated);
-
-	of_fill_in_cpu_data();
 }
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index cbb282d..26bb391 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -358,6 +358,7 @@ void __init paging_init(void)
 	protection_map[15] = PAGE_SHARED;
 	btfixup();
 	prom_build_devicetree();
+	of_fill_in_cpu_data();
 	device_scan();
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index f26a352..c589d6e 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1806,9 +1806,12 @@ void __init paging_init(void)
 	real_setup_per_cpu_areas();
 
 	prom_build_devicetree();
+	of_fill_in_cpu_data();
 
-	if (tlb_type = hypervisor)
+	if (tlb_type = hypervisor) {
 		sun4v_mdesc_init();
+		mdesc_fill_in_cpu_data(CPU_MASK_ALL);
+	}
 
 	/* Once the OF device tree and MDESC have been setup, we know
 	 * the list of possible cpus.  Therefore we can allocate the
-- 
1.6.2.2

