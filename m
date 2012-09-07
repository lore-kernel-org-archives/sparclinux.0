From: David Miller <davem@davemloft.net>
Date: Fri, 07 Sep 2012 05:34:22 +0000
Subject: [PATCH 2/3] sparc64: Probe cpu page size support more portably.
Message-Id: <20120907.013422.96143223190317989.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On sun4v, interrogate the machine description.  This code is extremely
defensive in nature, and a lot of the checks can probably be removed.

On sun4u things are a lot simpler.  There are the page sizes all chips
support, and then Panther adds 32MB and 256MB pages.

Report the probed value in /proc/cpuinfo

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/mdesc.h |    1 +
 arch/sparc/kernel/mdesc.c      |   24 ++++++++++++++++++++++++
 arch/sparc/mm/init_64.c        |   31 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdesc.h
index 9faa046..139097f 100644
--- a/arch/sparc/include/asm/mdesc.h
+++ b/arch/sparc/include/asm/mdesc.h
@@ -73,6 +73,7 @@ extern void mdesc_register_notifier(struct mdesc_notifier_client *client);
 
 extern void mdesc_fill_in_cpu_data(cpumask_t *mask);
 extern void mdesc_populate_present_mask(cpumask_t *mask);
+extern void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask);
 
 extern void sun4v_mdesc_init(void);
 
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 6dc7962..831c001 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -817,6 +817,30 @@ void __cpuinit mdesc_populate_present_mask(cpumask_t *mask)
 	mdesc_iterate_over_cpus(record_one_cpu, NULL, mask);
 }
 
+static void * __init check_one_pgsz(struct mdesc_handle *hp, u64 mp, int cpuid, void *arg)
+{
+	const u64 *pgsz_prop = mdesc_get_property(hp, mp, "mmu-page-size-list", NULL);
+	unsigned long *pgsz_mask = arg;
+	u64 val;
+
+	val = (HV_PGSZ_MASK_8K | HV_PGSZ_MASK_64K |
+	       HV_PGSZ_MASK_512K | HV_PGSZ_MASK_4MB);
+	if (pgsz_prop)
+		val = *pgsz_prop;
+
+	if (!*pgsz_mask)
+		*pgsz_mask = val;
+	else
+		*pgsz_mask &= val;
+	return NULL;
+}
+
+void __init mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask)
+{
+	*pgsz_mask = 0;
+	mdesc_iterate_over_cpus(check_one_pgsz, pgsz_mask, mask);
+}
+
 static void * __cpuinit fill_in_one_cpu(struct mdesc_handle *hp, u64 mp, int cpuid, void *arg)
 {
 	const u64 *cfreq = mdesc_get_property(hp, mp, "clock-frequency", NULL);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index c0fc25b..4453691 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -83,6 +83,8 @@ unsigned long kpte_linear_bitmap[KPTE_BITMAP_BYTES / sizeof(unsigned long)];
 extern struct tsb swapper_4m_tsb[KERNEL_TSB4M_NENTRIES];
 #endif
 
+static unsigned long cpu_pgsz_mask;
+
 #define MAX_BANKS	32
 
 static struct linux_prom64_registers pavail[MAX_BANKS] __devinitdata;
@@ -419,6 +421,12 @@ EXPORT_SYMBOL(flush_icache_range);
 
 void mmu_info(struct seq_file *m)
 {
+	static const char *pgsz_strings[] = {
+		"8K", "64K", "512K", "4MB", "32MB",
+		"256MB", "2GB", "16GB",
+	};
+	int i, printed;
+
 	if (tlb_type = cheetah)
 		seq_printf(m, "MMU Type\t: Cheetah\n");
 	else if (tlb_type = cheetah_plus)
@@ -430,6 +438,17 @@ void mmu_info(struct seq_file *m)
 	else
 		seq_printf(m, "MMU Type\t: ???\n");
 
+	seq_printf(m, "MMU PGSZs\t: ");
+	printed = 0;
+	for (i = 0; i < ARRAY_SIZE(pgsz_strings); i++) {
+		if (cpu_pgsz_mask & (1UL << i)) {
+			seq_printf(m, "%s%s",
+				   printed ? "," : "", pgsz_strings[i]);
+			printed++;
+		}
+	}
+	seq_putc(m, '\n');
+
 #ifdef CONFIG_DEBUG_DCFLUSH
 	seq_printf(m, "DCPageFlushes\t: %d\n",
 		   atomic_read(&dcpage_flushes));
@@ -1803,6 +1822,18 @@ void __init paging_init(void)
 #ifndef CONFIG_SMP
 		mdesc_fill_in_cpu_data(cpu_all_mask);
 #endif
+		mdesc_get_page_sizes(cpu_all_mask, &cpu_pgsz_mask);
+	} else {
+		unsigned long impl, ver;
+
+		cpu_pgsz_mask = (HV_PGSZ_MASK_8K | HV_PGSZ_MASK_64K |
+				 HV_PGSZ_MASK_512K | HV_PGSZ_MASK_4MB);
+
+		__asm__ __volatile__("rdpr %%ver, %0" : "=r" (ver));
+		impl = ((ver >> 32) & 0xffff);
+		if (impl = PANTHER_IMPL)
+			cpu_pgsz_mask |= (HV_PGSZ_MASK_32MB |
+					  HV_PGSZ_MASK_256MB);
 	}
 
 	/* Setup bootmem... */
-- 
1.7.10.4

