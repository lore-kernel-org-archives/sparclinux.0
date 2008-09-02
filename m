From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 08:05:34 +0000
Subject: [PATCH 1/3]: pci_psycho: Use of_getintprop_default().
Message-Id: <20080902.010534.51787757.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


pci_psycho: Use of_getintprop_default().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_psycho.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 47db875..0be850e 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -975,7 +975,6 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 				   struct of_device *op, int is_pbm_a)
 {
 	struct device_node *dp = op->node;
-	struct property *prop;
 	struct pci_pbm_info *pbm;
 
 	if (is_pbm_a)
@@ -994,14 +993,8 @@ static void __init psycho_pbm_init(struct pci_controller_info *p,
 	pbm->index = pci_num_pbms++;
 
 	pbm->chip_type = PBM_CHIP_TYPE_PSYCHO;
-	pbm->chip_version = 0;
-	prop = of_find_property(dp, "version#", NULL);
-	if (prop)
-		pbm->chip_version = *(int *) prop->value;
-	pbm->chip_revision = 0;
-	prop = of_find_property(dp, "module-revision#", NULL);
-	if (prop)
-		pbm->chip_revision = *(int *) prop->value;
+	pbm->chip_version = of_getintprop_default(dp, "version#", 0);
+	pbm->chip_revision = of_getintprop_default(dp, "module-revision#", 0);
 
 	pbm->parent = p;
 	pbm->prom_node = dp;
@@ -1031,13 +1024,9 @@ static int __devinit psycho_probe(struct of_device *op,
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
 	int is_pbm_a, err;
-	const u32 *p32;
 	u32 upa_portid;
 
-	upa_portid = 0xff;
-	p32 = of_get_property(dp, "upa-portid", NULL);
-	if (p32)
-		upa_portid = *p32;
+	upa_portid = of_getintprop_default(dp, "upa-portid", 0xff);
 
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		struct pci_controller_info *p = pbm->parent;
-- 
1.5.6.5.GIT

