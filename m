From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 11 Nov 2005 20:46:03 +0000
Subject: Re: detecting smp systems
Message-Id: <20051111.124603.31059835.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1131735249.2300.21.camel@localhost.localdomain>
In-Reply-To: <1131735249.2300.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 11 Nov 2005 12:54:09 -0600

> This means that 2.6 is not probing all of the cpus with the UP kernel,
> instead, stopping at the first one it finds.
> 
> Is there some other method we should be using (with the UP kernel
> booted) to detect whether the hardware is SMP capable or not?

This change in behavior was unintentional.  I changed the
/proc/cpuinfo code to use num_possible_cpus(), but that
gets defined to 1 on uniprocessor so isn't very useful
for this, whoops.

I'll check in this patch which gets us back to the old behavior.

Thanks for reporting.

diff --git a/arch/sparc64/kernel/setup.c b/arch/sparc64/kernel/setup.c
index bf1849d..4818053 100644
--- a/arch/sparc64/kernel/setup.c
+++ b/arch/sparc64/kernel/setup.c
@@ -587,6 +587,8 @@ extern void mmu_info(struct seq_file *);
 unsigned int dcache_parity_tl1_occurred;
 unsigned int icache_parity_tl1_occurred;
 
+static int ncpus_probed;
+
 static int show_cpuinfo(struct seq_file *m, void *__unused)
 {
 	seq_printf(m, 
@@ -595,8 +597,8 @@ static int show_cpuinfo(struct seq_file 
 		   "promlib\t\t: Version 3 Revision %d\n"
 		   "prom\t\t: %d.%d.%d\n"
 		   "type\t\t: sun4u\n"
-		   "ncpus probed\t: %ld\n"
-		   "ncpus active\t: %ld\n"
+		   "ncpus probed\t: %d\n"
+		   "ncpus active\t: %d\n"
 		   "D$ parity tl1\t: %u\n"
 		   "I$ parity tl1\t: %u\n"
 #ifndef CONFIG_SMP
@@ -610,8 +612,8 @@ static int show_cpuinfo(struct seq_file 
 		   prom_prev >> 16,
 		   (prom_prev >> 8) & 0xff,
 		   prom_prev & 0xff,
-		   (long)num_possible_cpus(),
-		   (long)num_online_cpus(),
+		   ncpus_probed,
+		   num_online_cpus(),
 		   dcache_parity_tl1_occurred,
 		   icache_parity_tl1_occurred
 #ifndef CONFIG_SMP
@@ -677,6 +679,15 @@ static int __init topology_init(void)
 	int i, err;
 
 	err = -ENOMEM;
+
+	/* Count the number of physically present processors in
+	 * the machine, even on uniprocessor, so that /proc/cpuinfo
+	 * output is consistent with 2.4.x
+	 */
+	ncpus_probed = 0;
+	while (!cpu_find_by_instance(ncpus_probed, NULL, NULL))
+		ncpus_probed++;
+
 	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_possible(i)) {
 			struct cpu *p = kmalloc(sizeof(*p), GFP_KERNEL);
diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 797a654..6efc03d 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -39,7 +39,6 @@
 #include <asm/starfire.h>
 #include <asm/tlb.h>
 
-extern int linux_num_cpus;
 extern void calibrate_delay(void);
 
 /* Please don't make this stuff initdata!!!  --DaveM */
