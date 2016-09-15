From: Atish Patra <atish.patra@oracle.com>
Date: Thu, 15 Sep 2016 20:54:41 +0000
Subject: [PATCH 2/2] sparc64: Fix irq stack bootmem allocation.
Message-Id: <1473972881-10671-3-git-send-email-atish.patra@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Currently, irq stack bootmem is allocated for all possible cpus
before nr_cpus value changes the list of possible cpus. As a result,
there is unnecessary wastage of bootmemory.

Move the irq stack bootmem allocation so that it happens after
possible cpu list is modified based on nr_cpus value.

Signed-off-by: Atish Patra <atish.patra@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/kernel/setup_64.c |   25 +++++++++++++++++++++++++
 arch/sparc/mm/init_64.c      |   16 ----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f32cfe8..6b7331d 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -31,6 +31,7 @@
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/start_kernel.h>
+#include <linux/bootmem.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -50,6 +51,8 @@
 #include <asm/elf.h>
 #include <asm/mdesc.h>
 #include <asm/cacheflush.h>
+#include <asm/dma.h>
+#include <asm/irq.h>
 
 #ifdef CONFIG_IP_PNP
 #include <net/ipconfig.h>
@@ -590,6 +593,22 @@ static void __init init_sparc64_elf_hwcap(void)
 		pause_patch();
 }
 
+void __init alloc_irqstack_bootmem(void)
+{
+	unsigned int i, node;
+
+	for_each_possible_cpu(i) {
+		node = cpu_to_node(i);
+
+		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
+							THREAD_SIZE,
+							THREAD_SIZE, 0);
+		hardirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
+							THREAD_SIZE,
+							THREAD_SIZE, 0);
+	}
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
@@ -651,6 +670,12 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 	init_sparc64_elf_hwcap();
 	smp_fill_in_cpu_possible_map();
+	/*
+	 * Once the OF device tree and MDESC have been setup and nr_cpus has
+	 * been parsed, we know the list of possible cpus.  Therefore we can
+	 * allocate the IRQ stacks.
+	 */
+	alloc_irqstack_bootmem();
 }
 
 extern int stop_a_enabled;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 65457c9..bc7a239 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2081,7 +2081,6 @@ void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
 	unsigned long real_end, i;
-	int node;
 
 	setup_page_offset();
 
@@ -2250,21 +2249,6 @@ void __init paging_init(void)
 	/* Setup bootmem... */
 	last_valid_pfn = end_pfn = bootmem_init(phys_base);
 
-	/* Once the OF device tree and MDESC have been setup, we know
-	 * the list of possible cpus.  Therefore we can allocate the
-	 * IRQ stacks.
-	 */
-	for_each_possible_cpu(i) {
-		node = cpu_to_node(i);
-
-		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
-							THREAD_SIZE,
-							THREAD_SIZE, 0);
-		hardirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
-							THREAD_SIZE,
-							THREAD_SIZE, 0);
-	}
-
 	kernel_physical_mapping_init();
 
 	{
-- 
1.7.1

