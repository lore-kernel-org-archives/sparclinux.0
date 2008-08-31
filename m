From: David Miller <davem@davemloft.net>
Date: Sun, 31 Aug 2008 08:35:29 +0000
Subject: [PATCH]: sparc64: Simplify error handling in PCI controller
Message-Id: <20080831.013529.206637768.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Stephen mentioned to me that kfree(NULL) is allowed and this
could simplify the PCI controller error handling.

But I instead opted to clean this up by using the usual
"unwind the stack of allocations" set of C label scheme
since we know at each goto exactly what bits have been
allocated and thus need to be freed up.

Pushed to sparc-next-2.6

sparc64: Simplify error handling in PCI controller probing.

Based upon suggestions from Stephen Rothwell.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_fire.c   |   21 ++++++++++-----------
 arch/sparc64/kernel/pci_psycho.c |   21 +++++++++++----------
 arch/sparc64/kernel/pci_sabre.c  |   25 +++++++++++++------------
 arch/sparc64/kernel/pci_schizo.c |   32 ++++++++++++++++++--------------
 arch/sparc64/kernel/pci_sun4v.c  |   31 ++++++++++++++++---------------
 5 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/arch/sparc64/kernel/pci_fire.c b/arch/sparc64/kernel/pci_fire.c
index 477928a..4fb1ef9 100644
--- a/arch/sparc64/kernel/pci_fire.c
+++ b/arch/sparc64/kernel/pci_fire.c
@@ -515,13 +515,13 @@ static int __devinit fire_probe(struct of_device *op,
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
-		goto out_free;
+		goto out_err;
 	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
-		goto out_free;
+		goto out_free_controller;
 	}
 
 	p->pbm_A.iommu = iommu;
@@ -529,21 +529,20 @@ static int __devinit fire_probe(struct of_device *op,
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
-		goto out_free;
+		goto out_free_iommu_A;
 	}
 
 	p->pbm_B.iommu = iommu;
 
 	return pci_fire_pbm_init(p, dp, portid);
 
-out_free:
-	if (p) {
-		if (p->pbm_A.iommu)
-			kfree(p->pbm_A.iommu);
-		if (p->pbm_B.iommu)
-			kfree(p->pbm_B.iommu);
-		kfree(p);
-	}
+out_free_iommu_A:
+	kfree(p->pbm_A.iommu);
+			
+out_free_controller:
+	kfree(p);
+
+out_err:
 	return err;
 }
 
diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 708212a..5ee84c5 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -1051,13 +1051,13 @@ static int __devinit psycho_probe(struct of_device *op,
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
-		goto out_free;
+		goto out_err;
 	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
-		goto out_free;
+		goto out_free_controller;
 	}
 
 	p->pbm_A.iommu = p->pbm_B.iommu = iommu;
@@ -1069,7 +1069,7 @@ static int __devinit psycho_probe(struct of_device *op,
 	err = -ENODEV;
 	if (!pr_regs) {
 		printk(KERN_ERR PFX "No reg property.\n");
-		goto out_free;
+		goto out_free_iommu;
 	}
 
 	p->pbm_A.controller_regs = pr_regs[2].phys_addr;
@@ -1082,7 +1082,7 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	err = psycho_iommu_init(&p->pbm_A);
 	if (err)
-		goto out_free;
+		goto out_free_iommu;
 
 	is_pbm_a = ((pr_regs[0].phys_addr & 0x6000) = 0x2000);
 
@@ -1090,12 +1090,13 @@ static int __devinit psycho_probe(struct of_device *op,
 
 	return 0;
 
-out_free:
-	if (p) {
-		if (p->pbm_A.iommu)
-			kfree(p->pbm_A.iommu);
-		kfree(p);
-	}
+out_free_iommu:
+	kfree(p->pbm_A.iommu);
+
+out_free_controller:
+	kfree(p);
+
+out_err:
 	return err;
 }
 
diff --git a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
index cc476e9..eee8fdc 100644
--- a/arch/sparc64/kernel/pci_sabre.c
+++ b/arch/sparc64/kernel/pci_sabre.c
@@ -786,13 +786,13 @@ static int __devinit sabre_probe(struct of_device *op,
 	p = kzalloc(sizeof(*p), GFP_ATOMIC);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
-		goto out_free;
+		goto out_err;
 	}
 
 	iommu = kzalloc(sizeof(*iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM iommu.\n");
-		goto out_free;
+		goto out_free_controller;
 	}
 
 	pbm = &p->pbm_A;
@@ -813,7 +813,7 @@ static int __devinit sabre_probe(struct of_device *op,
 	err = -ENODEV;
 	if (!pr_regs) {
 		printk(KERN_ERR PFX "No reg property\n");
-		goto out_free;
+		goto out_free_iommu;
 	}
 
 	/*
@@ -843,7 +843,7 @@ static int __devinit sabre_probe(struct of_device *op,
 	vdma = of_get_property(dp, "virtual-dma", NULL);
 	if (!vdma) {
 		printk(KERN_ERR PFX "No virtual-dma property\n");
-		goto out_free;
+		goto out_free_iommu;
 	}
 
 	dma_mask = vdma[0];
@@ -863,12 +863,12 @@ static int __devinit sabre_probe(struct of_device *op,
 			break;
 		default:
 			printk(KERN_ERR PFX "Strange virtual-dma size.\n");
-			goto out_free;
+			goto out_free_iommu;
 	}
 
 	err = sabre_iommu_init(pbm, tsbsize, vdma[0], dma_mask);
 	if (err)
-		goto out_free;
+		goto out_free_iommu;
 
 	/*
 	 * Look for APB underneath.
@@ -876,12 +876,13 @@ static int __devinit sabre_probe(struct of_device *op,
 	sabre_pbm_init(p, pbm, dp);
 	return 0;
 
-out_free:
-	if (p) {
-		if (p->pbm_A.iommu)
-			kfree(p->pbm_A.iommu);
-		kfree(p);
-	}
+out_free_iommu:
+	kfree(p->pbm_A.iommu);
+
+out_free_controller:
+	kfree(p);
+
+out_err:
 	return err;
 }
 
diff --git a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
index 18fdd88..bd7612a 100644
--- a/arch/sparc64/kernel/pci_schizo.c
+++ b/arch/sparc64/kernel/pci_schizo.c
@@ -1443,14 +1443,16 @@ static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_ty
 	struct pci_pbm_info *pbm;
 	struct iommu *iommu;
 	u32 portid;
+	int err;
 
 	portid = of_getintprop_default(dp, "portid", 0xff);
 
+	err = -ENOMEM;
 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next) {
 		if (portid_compare(pbm->portid, portid, chip_type)) {
 			if (schizo_pbm_init(pbm->parent, dp,
 					    portid, chip_type))
-				return -ENOMEM;
+				goto out_err;
 			return 0;
 		}
 	}
@@ -1458,13 +1460,13 @@ static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_ty
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p) {
 		printk(KERN_ERR PFX "Cannot allocate controller info.\n");
-		goto out_free;
+		goto out_err;
 	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM A iommu.\n");
-		goto out_free;
+		goto out_free_controller;
 	}
 
 	p->pbm_A.iommu = iommu;
@@ -1472,25 +1474,27 @@ static int __devinit __schizo_init(struct device_node *dp, unsigned long chip_ty
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Cannot allocate PBM B iommu.\n");
-		goto out_free;
+		goto out_free_iommu_A;
 	}
 
 	p->pbm_B.iommu = iommu;
 
 	if (schizo_pbm_init(p, dp, portid, chip_type))
-		goto out_free;
+		goto out_free_iommu_B;
 
 	return 0;
 
-out_free:
-	if (p) {
-		if (p->pbm_A.iommu)
-			kfree(p->pbm_A.iommu);
-		if (p->pbm_B.iommu)
-			kfree(p->pbm_B.iommu);
-		kfree(p);
-	}
-	return -ENOMEM;
+out_free_iommu_B:
+	kfree(p->pbm_B.iommu);
+
+out_free_iommu_A:
+	kfree(p->pbm_A.iommu);
+
+out_free_controller:
+	kfree(p);
+
+out_err:
+	return err;
 }
 
 static int __devinit schizo_probe(struct of_device *op,
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index fea51a0..21864f0 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -949,7 +949,7 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	struct device_node *dp;
 	struct iommu *iommu;
 	u32 devhandle;
-	int i;
+	int i, err;
 
 	dp = op->node;
 
@@ -970,9 +970,10 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	}
 
 	regs = of_get_property(dp, "reg", NULL);
+	err = -ENODEV;
 	if (!regs) {
 		printk(KERN_ERR PFX "Could not find config registers\n");
-		return -ENODEV;
+		goto out_err;
 	}
 	devhandle = (regs->phys_addr >> 32UL) & 0x0fffffff;
 
@@ -982,11 +983,12 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 		}
 	}
 
+	err = -ENOMEM;
 	for_each_possible_cpu(i) {
 		unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
 		if (!page)
-			return -ENOMEM;
+			goto out_err;
 
 		per_cpu(iommu_batch, i).pglist = (u64 *) page;
 	}
@@ -994,13 +996,13 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p) {
 		printk(KERN_ERR PFX "Could not allocate pci_controller_info\n");
-		goto out_free;
+		goto out_err;
 	}
 
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Could not allocate pbm A iommu\n");
-		goto out_free;
+		goto out_free_controller;
 	}
 
 	p->pbm_A.iommu = iommu;
@@ -1008,22 +1010,21 @@ static int __devinit pci_sun4v_probe(struct of_device *op,
 	iommu = kzalloc(sizeof(struct iommu), GFP_ATOMIC);
 	if (!iommu) {
 		printk(KERN_ERR PFX "Could not allocate pbm B iommu\n");
-		goto out_free;
+		goto out_free_iommu_A;
 	}
 
 	p->pbm_B.iommu = iommu;
 
 	return pci_sun4v_pbm_init(p, dp, devhandle);
 
-out_free:
-	if (p) {
-		if (p->pbm_A.iommu)
-			kfree(p->pbm_A.iommu);
-		if (p->pbm_B.iommu)
-			kfree(p->pbm_B.iommu);
-		kfree(p);
-	}
-	return -ENOMEM;
+out_free_iommu_A:
+	kfree(p->pbm_A.iommu);
+
+out_free_controller:
+	kfree(p);
+
+out_err:
+	return err;
 }
 
 static struct of_device_id __initdata pci_sun4v_match[] = {
-- 
1.5.6.5.GIT

