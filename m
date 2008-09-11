From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:14:35 +0000
Subject: [PATCH 2/3]: sparc64: Create and use psycho_pbm_init_common().
Message-Id: <20080910.231435.03528741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Create and use psycho_pbm_init_common().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_psycho.c    |   32 ++++----------------------------
 arch/sparc64/kernel/pci_sabre.c     |   19 +------------------
 arch/sparc64/kernel/psycho_common.c |   22 ++++++++++++++++++++++
 arch/sparc64/kernel/psycho_common.h |    4 ++++
 4 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 4681e3d..2de51fb 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -895,35 +895,8 @@ static void psycho_pbm_strbuf_init(struct pci_pbm_info *pbm,
 static void __init psycho_pbm_init(struct pci_pbm_info *pbm,
 				   struct of_device *op, int is_pbm_a)
 {
-	struct device_node *dp = op->node;
-
-	pbm->next = pci_pbm_root;
-	pci_pbm_root = pbm;
-
-	pbm->numa_node = -1;
-
-	pbm->pci_ops = &sun4u_pci_ops;
-	pbm->config_space_reg_bits = 8;
-
-	pbm->index = pci_num_pbms++;
-
-	pbm->chip_type = PBM_CHIP_TYPE_PSYCHO;
-	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
-	pbm->chip_revision = of_getintprop_default(dp, "module-revision#", 0);
-
-	pbm->op = op;
-	pbm->name = dp->full_name;
-
-	printk(KERN_INFO "%s: PSYCHO PCI Bus Module ver[%x:%x]\n",
-	       pbm->name,
-	       pbm->chip_version, pbm->chip_revision);
-
-	pci_determine_mem_io_space(pbm);
-
-	pci_get_pbm_props(pbm);
-
+	psycho_pbm_init_common(pbm, op, "PSYCHO", PBM_CHIP_TYPE_PSYCHO);
 	psycho_pbm_strbuf_init(pbm, is_pbm_a);
-
 	psycho_scan_bus(pbm, &op->dev);
 }
 
@@ -1009,6 +982,9 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	psycho_pbm_init(pbm, op, is_pbm_a);
 
+	pbm->next = pci_pbm_root;
+	pci_pbm_root = pbm;
+
 	if (pbm->sibling)
 		pbm->sibling->sibling = pbm;
 
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index a3a276d..ae11d67 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -678,24 +678,7 @@ static void __init sabre_scan_bus(struct pci_pbm_info *pbm,
 static void __init sabre_pbm_init(struct pci_pbm_info *pbm,
 				  struct of_device *op)
 {
-	struct device_node *dp = op->node;
-
-	pbm->name = dp->full_name;
-	printk("%s: SABRE PCI Bus Module\n", pbm->name);
-
-	pbm->numa_node = -1;
-
-	pbm->pci_ops = &sun4u_pci_ops;
-	pbm->config_space_reg_bits = 8;
-
-	pbm->index = pci_num_pbms++;
-
-	pbm->chip_type = PBM_CHIP_TYPE_SABRE;
-	pbm->op = op;
-	pci_get_pbm_props(pbm);
-
-	pci_determine_mem_io_space(pbm);
-
+	psycho_pbm_init_common(pbm, op, "SABRE", PBM_CHIP_TYPE_SABRE);
 	sabre_scan_bus(pbm, &op->dev);
 }
 
diff --git a/arch/sparc64/kernel/psycho_common.c b/arch/sparc64/kernel/psycho_common.c
index 07acc13..1b4d462 100644
--- a/arch/sparc64/kernel/psycho_common.c
+++ b/arch/sparc64/kernel/psycho_common.c
@@ -91,3 +91,25 @@ int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
 	return 0;
 
 }
+
+void psycho_pbm_init_common(struct pci_pbm_info *pbm, struct of_device *op,
+			    const char *chip_name, int chip_type)
+{
+	struct device_node *dp = op->node;
+
+	pbm->name = dp->full_name;
+	pbm->numa_node = -1;
+	pbm->chip_type = chip_type;
+	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
+	pbm->chip_revision = of_getintprop_default(dp, "module-revision#", 0);
+	pbm->op = op;
+	pbm->pci_ops = &sun4u_pci_ops;
+	pbm->config_space_reg_bits = 8;
+	pbm->index = pci_num_pbms++;
+	pci_get_pbm_props(pbm);
+	pci_determine_mem_io_space(pbm);
+
+	printk(KERN_INFO "%s: %s PCI Bus Module ver[%x:%x]\n",
+	       pbm->name, chip_name,
+	       pbm->chip_version, pbm->chip_revision);
+}
diff --git a/arch/sparc64/kernel/psycho_common.h b/arch/sparc64/kernel/psycho_common.h
index bffaff5..adfbadb 100644
--- a/arch/sparc64/kernel/psycho_common.h
+++ b/arch/sparc64/kernel/psycho_common.h
@@ -5,4 +5,8 @@ extern int psycho_iommu_init(struct pci_pbm_info *pbm, int tsbsize,
 			     u32 dvma_offset, u32 dma_mask,
 			     unsigned long write_complete_offset);
 
+extern void psycho_pbm_init_common(struct pci_pbm_info *pbm,
+				   struct of_device *op,
+				   const char *chip_name, int chip_type);
+
 #endif /* _PSYCHO_COMMON_H */
-- 
1.5.6.5.GIT

