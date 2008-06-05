From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:26:38 +0000
Subject: [RFC: 2.6 patch] sparc64/kernel/: make code static
Message-Id: <20080605182637.GI1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch makes the following needlessly global code static:
- central.c: struct central_bus
- central.c: struct fhc_list
- central.c: apply_fhc_ranges()
- central.c: apply_central_ranges()
- ds.c: struct ds_states_template[]
- pci_msi.c: sparc64_setup_msi_irq()
- pci_msi.c: sparc64_teardown_msi_irq()
- pci_sun4v.c: struct sun4v_dma_ops
- sys_sparc32.c: cp_compat_stat64()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc64/kernel/central.c     |   14 +++++++-------
 arch/sparc64/kernel/ds.c          |    2 +-
 arch/sparc64/kernel/pci_msi.c     |   10 +++++-----
 arch/sparc64/kernel/pci_sun4v.c   |    2 +-
 arch/sparc64/kernel/sys_sparc32.c |    3 ++-
 include/asm-sparc64/fhc.h         |   10 ----------
 6 files changed, 16 insertions(+), 25 deletions(-)

600b4d4fff3d77e283f95b8f964c8c0c79ecdbcb diff --git a/arch/sparc64/kernel/central.c b/arch/sparc64/kernel/central.c
index b61b8df..f2e87d0 100644
--- a/arch/sparc64/kernel/central.c
+++ b/arch/sparc64/kernel/central.c
@@ -16,8 +16,8 @@
 #include <asm/fhc.h>
 #include <asm/starfire.h>
 
-struct linux_central *central_bus = NULL;
-struct linux_fhc *fhc_list = NULL;
+static struct linux_central *central_bus = NULL;
+static struct linux_fhc *fhc_list = NULL;
 
 #define IS_CENTRAL_FHC(__fhc)	((__fhc) = central_bus->child)
 
@@ -79,9 +79,9 @@ static void adjust_regs(struct linux_prom_registers *regp, int nregs,
 }
 
 /* Apply probed fhc ranges to registers passed, if no ranges return. */
-void apply_fhc_ranges(struct linux_fhc *fhc,
-		      struct linux_prom_registers *regs,
-		      int nregs)
+static void apply_fhc_ranges(struct linux_fhc *fhc,
+			     struct linux_prom_registers *regs,
+			     int nregs)
 {
 	if (fhc->num_fhc_ranges)
 		adjust_regs(regs, nregs, fhc->fhc_ranges,
@@ -89,8 +89,8 @@ void apply_fhc_ranges(struct linux_fhc *fhc,
 }
 
 /* Apply probed central ranges to registers passed, if no ranges return. */
-void apply_central_ranges(struct linux_central *central,
-			  struct linux_prom_registers *regs, int nregs)
+static void apply_central_ranges(struct linux_central *central,
+				 struct linux_prom_registers *regs, int nregs)
 {
 	if (central->num_central_ranges)
 		adjust_regs(regs, nregs, central->central_ranges,
diff --git a/arch/sparc64/kernel/ds.c b/arch/sparc64/kernel/ds.c
index edb74f5..d0fa5aa 100644
--- a/arch/sparc64/kernel/ds.c
+++ b/arch/sparc64/kernel/ds.c
@@ -159,7 +159,7 @@ static void ds_var_data(struct ds_info *dp,
 			struct ds_cap_state *cp,
 			void *buf, int len);
 
-struct ds_cap_state ds_states_template[] = {
+static struct ds_cap_state ds_states_template[] = {
 	{
 		.service_id	= "md-update",
 		.data		= md_update_data,
diff --git a/arch/sparc64/kernel/pci_msi.c b/arch/sparc64/kernel/pci_msi.c
index db5e8fd..60c71e3 100644
--- a/arch/sparc64/kernel/pci_msi.c
+++ b/arch/sparc64/kernel/pci_msi.c
@@ -120,9 +120,9 @@ static struct irq_chip msi_irq = {
 	/* XXX affinity XXX */
 };
 
-int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
-			  struct pci_dev *pdev,
-			  struct msi_desc *entry)
+static int sparc64_setup_msi_irq(unsigned int *virt_irq_p,
+				 struct pci_dev *pdev,
+				 struct msi_desc *entry)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 	const struct sparc64_msiq_ops *ops = pbm->msi_ops;
@@ -179,8 +179,8 @@ out_err:
 	return err;
 }
 
-void sparc64_teardown_msi_irq(unsigned int virt_irq,
-			      struct pci_dev *pdev)
+static void sparc64_teardown_msi_irq(unsigned int virt_irq,
+				     struct pci_dev *pdev)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 	const struct sparc64_msiq_ops *ops = pbm->msi_ops;
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index e2bb979..a104c80 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -531,7 +531,7 @@ static void dma_4v_sync_sg_for_cpu(struct device *dev,
 	/* Nothing to do... */
 }
 
-const struct dma_ops sun4v_dma_ops = {
+static const struct dma_ops sun4v_dma_ops = {
 	.alloc_coherent			= dma_4v_alloc_coherent,
 	.free_coherent			= dma_4v_free_coherent,
 	.map_single			= dma_4v_map_single,
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index ba5bd62..5906797 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -359,7 +359,8 @@ int cp_compat_stat(struct kstat *stat, struct compat_stat __user *statbuf)
 	return err;
 }
 
-int cp_compat_stat64(struct kstat *stat, struct compat_stat64 __user *statbuf)
+static int cp_compat_stat64(struct kstat *stat,
+			    struct compat_stat64 __user *statbuf)
 {
 	int err;
 
diff --git a/include/asm-sparc64/fhc.h b/include/asm-sparc64/fhc.h
index ddffcdf..788cbc4 100644
--- a/include/asm-sparc64/fhc.h
+++ b/include/asm-sparc64/fhc.h
@@ -118,14 +118,4 @@ struct linux_fhc {
 	int				num_fhc_ranges;
 };
 
-extern struct linux_central *central_bus;
-
-extern void apply_central_ranges(struct linux_central *central, 
-				 struct linux_prom_registers *regs,
-				 int nregs);
-
-extern void apply_fhc_ranges(struct linux_fhc *fhc, 
-			     struct linux_prom_registers *regs,
-			     int nregs);
-
 #endif /* !(_SPARC64_FHC_H) */

