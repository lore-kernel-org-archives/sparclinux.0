From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Feb 2011 08:51:51 +0000
Subject: [PATCH] sparc64: fix unused-but-set-variable warnings
Message-Id: <20110226085151.GA23117@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dennis Gilmore reported that sparc64 generate warnings
when build with gcc 4.6.
This broke the build as sparc is intolerant for warnings in arch specific code.

Fix following warnings seen with gcc 4.6:

arch/sparc/kernel/traps_64.c: In function 'show_stack':
arch/sparc/kernel/traps_64.c:2155:20: warning: variable 'thread_base' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/iommu.c: In function 'dma_4u_free_coherent':
arch/sparc/kernel/iommu.c:336:11: warning: variable 'iopte' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/pcr.c: In function 'n2_pcr_write':
arch/sparc/kernel/pcr.c:81:16: warning: variable 'ret' set but not used [- Wunused-but-set-variable]
arch/sparc/kernel/smp_64.c: In function 'smp_synchronize_tick_client':
arch/sparc/kernel/smp_64.c:192:46: warning: variable 'bound' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/smp_64.c: In function 'flush_dcache_page_all':
arch/sparc/kernel/smp_64.c:936:6: warning: variable 'this_cpu' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_common.c: In function 'sun4v_write_pci_cfg':
arch/sparc/kernel/pci_common.c:298:16: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_sun4v.c: In function 'pci_sun4v_iommu_init':
arch/sparc/kernel/pci_sun4v.c:583:37: warning: variable 'tsbsize' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_schizo.c: In function 'schizo_pbm_init':
arch/sparc/kernel/pci_schizo.c:1316:6: warning: variable 'is_pbm_a' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/pci_fire.c: In function 'pci_fire_msi_teardown':
arch/sparc/kernel/pci_fire.c:217:16: warning: variable 'msiqid' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/ldc.c: In function 'ldc_rx':
arch/sparc/kernel/ldc.c:793:28: warning: variable 'hv_err' set but not used [-Wunused-but-set-variable]
arch/sparc/kernel/ldc.c: In function 'ldc_tx':
arch/sparc/kernel/ldc.c:907:23: warning: variable 'hv_err' set but not used [-Wunused-but-set-variable]

Following warning was silenced as we must use the return result of sysfs_create_file()
arch/sparc/kernel/pci.c: In function 'pci_bus_register_of_sysfs':
arch/sparc/kernel/pci.c:667:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]

Cc: Dennis Gilmore <dennis@ausil.us>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I took a qucik stab on this - most look legitimate.
Following is only build tested and needs a bit of review.

I expect a similar set of warnings on sparc32 - I will look into this
when I get a chance (need gcc or someone send a list of warnings)

	Sam

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 47977a7..a4393bf 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -334,13 +334,10 @@ static void dma_4u_free_coherent(struct device *dev, size_t size,
 				 void *cpu, dma_addr_t dvma)
 {
 	struct iommu *iommu;
-	iopte_t *iopte;
 	unsigned long flags, order, npages;
 
 	npages = IO_PAGE_ALIGN(size) >> IO_PAGE_SHIFT;
 	iommu = dev->archdata.iommu;
-	iopte = iommu->page_table +
-		((dvma - iommu->page_table_map_base) >> IO_PAGE_SHIFT);
 
 	spin_lock_irqsave(&iommu->lock, flags);
 
diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index df39a0f..fa83776 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -790,16 +790,16 @@ static void send_events(struct ldc_channel *lp, unsigned int event_mask)
 static irqreturn_t ldc_rx(int irq, void *dev_id)
 {
 	struct ldc_channel *lp = dev_id;
-	unsigned long orig_state, hv_err, flags;
+	unsigned long orig_state, flags;
 	unsigned int event_mask;
 
 	spin_lock_irqsave(&lp->lock, flags);
 
 	orig_state = lp->chan_state;
-	hv_err = sun4v_ldc_rx_get_state(lp->id,
-					&lp->rx_head,
-					&lp->rx_tail,
-					&lp->chan_state);
+	sun4v_ldc_rx_get_state(lp->id,
+				&lp->rx_head,
+				&lp->rx_tail,
+				&lp->chan_state);
 
 	ldcdbg(RX, "RX state[0x%02lx:0x%02lx] head[0x%04lx] tail[0x%04lx]\n",
 	       orig_state, lp->chan_state, lp->rx_head, lp->rx_tail);
@@ -904,16 +904,16 @@ out:
 static irqreturn_t ldc_tx(int irq, void *dev_id)
 {
 	struct ldc_channel *lp = dev_id;
-	unsigned long flags, hv_err, orig_state;
+	unsigned long flags, orig_state;
 	unsigned int event_mask = 0;
 
 	spin_lock_irqsave(&lp->lock, flags);
 
 	orig_state = lp->chan_state;
-	hv_err = sun4v_ldc_tx_get_state(lp->id,
-					&lp->tx_head,
-					&lp->tx_tail,
-					&lp->chan_state);
+	sun4v_ldc_tx_get_state(lp->id,
+				&lp->tx_head,
+				&lp->tx_tail,
+				&lp->chan_state);
 
 	ldcdbg(TX, " TX state[0x%02lx:0x%02lx] head[0x%04lx] tail[0x%04lx]\n",
 	       orig_state, lp->chan_state, lp->tx_head, lp->tx_tail);
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index bfede51..e4efcc3 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -675,6 +675,7 @@ static void __devinit pci_bus_register_of_sysfs(struct pci_bus *bus)
 		 * humanoid.
 		 */
 		err = sysfs_create_file(&dev->dev.kobj, &dev_attr_obppath.attr);
+		(void)err;
 	}
 	list_for_each_entry(child_bus, &bus->children, node)
 		pci_bus_register_of_sysfs(child_bus);
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 6c7a33a..34845cf 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -295,12 +295,11 @@ static int sun4v_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 	unsigned int bus = bus_dev->number;
 	unsigned int device = PCI_SLOT(devfn);
 	unsigned int func = PCI_FUNC(devfn);
-	unsigned long ret;
 
 	if (config_out_of_range(pbm, bus, devfn, where)) {
 		/* Do nothing. */
 	} else {
-		ret = pci_sun4v_config_put(devhandle,
+		pci_sun4v_config_put(devhandle,
 				HV_PCI_DEVICE_BUILD(bus, device, func),
 				where, size, value);
 	}
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index 539d3a8..e225945 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -214,11 +214,9 @@ static int pci_fire_msi_setup(struct pci_pbm_info *pbm, unsigned long msiqid,
 
 static int pci_fire_msi_teardown(struct pci_pbm_info *pbm, unsigned long msi)
 {
-	unsigned long msiqid;
 	u64 val;
 
 	val = upa_readq(pbm->pbm_regs + MSI_MAP(msi));
-	msiqid = (val & MSI_MAP_EQNUM);
 
 	val &= ~MSI_MAP_VALID;
 
diff --git a/arch/sparc/kernel/pci_schizo.c b/arch/sparc/kernel/pci_schizo.c
index 445a47a..4620eb7 100644
--- a/arch/sparc/kernel/pci_schizo.c
+++ b/arch/sparc/kernel/pci_schizo.c
@@ -1313,7 +1313,7 @@ static int __devinit schizo_pbm_init(struct pci_pbm_info *pbm,
 	const struct linux_prom64_registers *regs;
 	struct device_node *dp = op->dev.of_node;
 	const char *chipset_name;
-	int is_pbm_a, err;
+	int err;
 
 	switch (chip_type) {
 	case PBM_CHIP_TYPE_TOMATILLO:
@@ -1343,8 +1343,6 @@ static int __devinit schizo_pbm_init(struct pci_pbm_info *pbm,
 	 */
 	regs = of_get_property(dp, "reg", NULL);
 
-	is_pbm_a = ((regs[0].phys_addr & 0x00700000) = 0x00600000);
-
 	pbm->next = pci_pbm_root;
 	pci_pbm_root = pbm;
 
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index ae96cf5..564ab22 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -78,9 +78,7 @@ static const struct pcr_ops direct_pcr_ops = {
 
 static void n2_pcr_write(u64 val)
 {
-	unsigned long ret;
-
-	ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
+	sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
 	if (val != HV_EOK)
 		write_pcr(val);
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b6a2b8f..274f361 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -188,7 +188,7 @@ static inline long get_delta (long *rt, long *master)
 void smp_synchronize_tick_client(void)
 {
 	long i, delta, adj, adjust_latency = 0, done = 0;
-	unsigned long flags, rt, master_time_stamp, bound;
+	unsigned long flags, rt, master_time_stamp;
 #if DEBUG_TICK_SYNC
 	struct {
 		long rt;	/* roundtrip time */
@@ -209,7 +209,6 @@ void smp_synchronize_tick_client(void)
 			delta = get_delta(&rt, &master_time_stamp);
 			if (delta = 0) {
 				done = 1;	/* let's lock on to this... */
-				bound = rt;
 			}
 
 			if (!done) {
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 1e97709..1ed547b 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2152,7 +2152,7 @@ static void user_instruction_dump(unsigned int __user *pc)
 
 void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 {
-	unsigned long fp, thread_base, ksp;
+	unsigned long fp, ksp;
 	struct thread_info *tp;
 	int count = 0;
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -2173,7 +2173,6 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 		flushw_all();
 
 	fp = ksp + STACK_BIAS;
-	thread_base = (unsigned long) tp;
 
 	printk("Call Trace:\n");
 	do {
