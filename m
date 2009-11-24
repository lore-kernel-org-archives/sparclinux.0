From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 22:01:14 +0000
Subject: [PATCH v2 11/11] of: unify phandle name in struct device_node
Message-Id: <20091124215908.559.23998.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

In struct device_node, the phandle is named 'linux_phandle' for PowerPC
and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
difference, it is just an artifact of the code diverging over a couple
of years.  This patch renames both to simply .phandle.

Note: the .node also existed in PowerPC/MicroBlaze, but the only user
seems to be arch/powerpc/platforms/powermac/pfunc_core.c.  It doesn't
look like the assignment between .linux_phandle and .node is
significantly different enough to warrant the separate code paths
unless ibm,phandle properties actually appear in Apple device trees.

I think it is safe to eliminate the old .node property and use
linux_phandle everywhere.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/microblaze/kernel/of_platform.c         |    2 +-
 arch/microblaze/kernel/prom.c                |    2 +-
 arch/powerpc/kernel/of_platform.c            |    2 +-
 arch/powerpc/kernel/prom.c                   |    6 +++---
 arch/powerpc/platforms/cell/spu_manage.c     |    6 +++---
 arch/powerpc/platforms/powermac/pfunc_core.c |    2 +-
 arch/sparc/kernel/devices.c                  |    2 +-
 arch/sparc/kernel/of_device_32.c             |    2 +-
 arch/sparc/kernel/of_device_64.c             |    2 +-
 arch/sparc/kernel/prom_common.c              |    8 ++++----
 arch/sparc/kernel/smp_64.c                   |    2 +-
 drivers/of/fdt.c                             |    7 +++----
 drivers/sbus/char/openprom.c                 |   10 +++++-----
 drivers/video/aty/atyfb_base.c               |    2 +-
 include/linux/of.h                           |    5 +----
 sound/aoa/fabrics/layout.c                   |    2 +-
 16 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/arch/microblaze/kernel/of_platform.c b/arch/microblaze/kernel/of_platform.c
index acf4574..1c6d684 100644
--- a/arch/microblaze/kernel/of_platform.c
+++ b/arch/microblaze/kernel/of_platform.c
@@ -185,7 +185,7 @@ EXPORT_SYMBOL(of_find_device_by_node);
 static int of_dev_phandle_match(struct device *dev, void *data)
 {
 	phandle *ph = data;
-	return to_of_device(dev)->node->linux_phandle = *ph;
+	return to_of_device(dev)->node->phandle = *ph;
 }
 
 struct of_device *of_find_device_by_phandle(phandle ph)
diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 1f79e4d..9b4a20b 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -251,7 +251,7 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 
 	read_lock(&devtree_lock);
 	for (np = allnodes; np != NULL; np = np->allnext)
-		if (np->linux_phandle = handle)
+		if (np->phandle = handle)
 			break;
 	of_node_get(np);
 	read_unlock(&devtree_lock);
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 1a4fc0d..666d08d 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(of_find_device_by_node);
 static int of_dev_phandle_match(struct device *dev, void *data)
 {
 	phandle *ph = data;
-	return to_of_device(dev)->node->linux_phandle = *ph;
+	return to_of_device(dev)->node->phandle = *ph;
 }
 
 struct of_device *of_find_device_by_phandle(phandle ph)
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 7d0beeb..d3ce311 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -701,7 +701,7 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 
 	read_lock(&devtree_lock);
 	for (np = allnodes; np != 0; np = np->allnext)
-		if (np->linux_phandle = handle)
+		if (np->phandle = handle)
 			break;
 	of_node_get(np);
 	read_unlock(&devtree_lock);
@@ -771,9 +771,9 @@ static int of_finish_dynamic_node(struct device_node *node)
 	if (machine_is(powermac))
 		return -ENODEV;
 
-	/* fix up new node's linux_phandle field */
+	/* fix up new node's phandle field */
 	if ((ibm_phandle = of_get_property(node, "ibm,phandle", NULL)))
-		node->linux_phandle = *ibm_phandle;
+		node->phandle = *ibm_phandle;
 
 out:
 	of_node_put(parent);
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 4c506c1..891f18e 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -457,7 +457,7 @@ neighbour_spu(int cbe, struct device_node *target, struct device_node *avoid)
 			continue;
 		vic_handles = of_get_property(spu_dn, "vicinity", &lenp);
 		for (i=0; i < (lenp / sizeof(phandle)); i++) {
-			if (vic_handles[i] = target->linux_phandle)
+			if (vic_handles[i] = target->phandle)
 				return spu;
 		}
 	}
@@ -499,7 +499,7 @@ static void init_affinity_node(int cbe)
 
 			if (strcmp(name, "spe") = 0) {
 				spu = devnode_spu(cbe, vic_dn);
-				avoid_ph = last_spu_dn->linux_phandle;
+				avoid_ph = last_spu_dn->phandle;
 			} else {
 				/*
 				 * "mic-tm" and "bif0" nodes do not have
@@ -514,7 +514,7 @@ static void init_affinity_node(int cbe)
 					last_spu->has_mem_affinity = 1;
 					spu->has_mem_affinity = 1;
 				}
-				avoid_ph = vic_dn->linux_phandle;
+				avoid_ph = vic_dn->phandle;
 			}
 
 			list_add_tail(&spu->aff_list, &last_spu->aff_list);
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 96d5ce5..ede49e7 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -842,7 +842,7 @@ struct pmf_function *__pmf_find_function(struct device_node *target,
 	list_for_each_entry(func, &dev->functions, link) {
 		if (name && strcmp(name, func->name))
 			continue;
-		if (func->phandle && target->node != func->phandle)
+		if (func->phandle && target->phandle != func->phandle)
 			continue;
 		if ((func->flags & flags) = 0)
 			continue;
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index b171ae8..b062de9 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -59,7 +59,7 @@ static int __cpu_find_by(int (*compare)(int, int, void *), void *compare_arg,
 
 	cur_inst = 0;
 	for_each_node_by_type(dp, "cpu") {
-		int err = check_cpu_node(dp->node, &cur_inst,
+		int err = check_cpu_node(dp->phandle, &cur_inst,
 					 compare, compare_arg,
 					 prom_node, mid);
 		if (!err) {
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4c26eb5..09138d4 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -433,7 +433,7 @@ build_resources:
 	if (!parent)
 		dev_set_name(&op->dev, "root");
 	else
-		dev_set_name(&op->dev, "%08x", dp->node);
+		dev_set_name(&op->dev, "%08x", dp->phandle);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 881947e..036f18a 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -666,7 +666,7 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 	if (!parent)
 		dev_set_name(&op->dev, "root");
 	else
-		dev_set_name(&op->dev, "%08x", dp->node);
+		dev_set_name(&op->dev, "%08x", dp->phandle);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d80a65d..5832e13 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -42,7 +42,7 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 	struct device_node *np;
 
 	for (np = allnodes; np; np = np->allnext)
-		if (np->node = handle)
+		if (np->phandle = handle)
 			break;
 
 	return np;
@@ -89,7 +89,7 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 			void *old_val = prop->value;
 			int ret;
 
-			ret = prom_setprop(dp->node, name, val, len);
+			ret = prom_setprop(dp->phandle, name, val, len);
 
 			err = -EINVAL;
 			if (ret >= 0) {
@@ -236,7 +236,7 @@ static struct device_node * __init prom_create_node(phandle node,
 
 	dp->name = get_one_property(node, "name");
 	dp->type = get_one_property(node, "device_type");
-	dp->node = node;
+	dp->phandle = node;
 
 	dp->properties = build_prop_list(node);
 
@@ -313,7 +313,7 @@ void __init prom_build_devicetree(void)
 
 	nextp = &allnodes->allnext;
 	allnodes->child = prom_build_tree(allnodes,
-					  prom_getchild(allnodes->node),
+					  prom_getchild(allnodes->phandle),
 					  &nextp);
 	of_console_init();
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index aa36223..eb14844 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -370,7 +370,7 @@ static int __cpuinit smp_boot_one_cpu(unsigned int cpu)
 	} else {
 		struct device_node *dp = of_find_node_by_cpuid(cpu);
 
-		prom_startcpu(dp->node, entry, cookie);
+		prom_startcpu(dp->phandle, entry, cookie);
 	}
 
 	for (timeout = 0; timeout < 50000; timeout++) {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6164781..13c69e0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -315,12 +315,11 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 					__alignof__(struct property));
 		if (allnextpp) {
 			if (strcmp(pname, "linux,phandle") = 0) {
-				np->node = *((u32 *)*p);
-				if (np->linux_phandle = 0)
-					np->linux_phandle = np->node;
+				if (np->phandle = 0)
+					np->phandle = *((u32 *)*p);
 			}
 			if (strcmp(pname, "ibm,phandle") = 0)
-				np->linux_phandle = *((u32 *)*p);
+				np->phandle = *((u32 *)*p);
 			pp->name = pname;
 			pp->length = sz;
 			pp->value = (void *)*p;
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 75ac19b..fc2f676 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -233,7 +233,7 @@ static int opromnext(void __user *argp, unsigned int cmd, struct device_node *dp
 
 	ph = 0;
 	if (dp)
-		ph = dp->node;
+		ph = dp->phandle;
 
 	data->current_node = dp;
 	*((int *) op->oprom_array) = ph;
@@ -256,7 +256,7 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 
 		dp = pci_device_to_OF_node(pdev);
 		data->current_node = dp;
-		*((int *)op->oprom_array) = dp->node;
+		*((int *)op->oprom_array) = dp->phandle;
 		op->oprom_size = sizeof(int);
 		err = copyout(argp, op, bufsize + sizeof(int));
 
@@ -273,7 +273,7 @@ static int oprompath2node(void __user *argp, struct device_node *dp, struct open
 
 	dp = of_find_node_by_path(op->oprom_array);
 	if (dp)
-		ph = dp->node;
+		ph = dp->phandle;
 	data->current_node = dp;
 	*((int *)op->oprom_array) = ph;
 	op->oprom_size = sizeof(int);
@@ -540,7 +540,7 @@ static int opiocgetnext(unsigned int cmd, void __user *argp)
 		}
 	}
 	if (dp)
-		nd = dp->node;
+		nd = dp->phandle;
 	if (copy_to_user(argp, &nd, sizeof(phandle)))
 		return -EFAULT;
 
@@ -570,7 +570,7 @@ static int openprom_bsd_ioctl(struct inode * inode, struct file * file,
 	case OPIOCGETOPTNODE:
 		BUILD_BUG_ON(sizeof(phandle) != sizeof(int));
 
-		if (copy_to_user(argp, &options_node->node, sizeof(phandle)))
+		if (copy_to_user(argp, &options_node->phandle, sizeof(phandle)))
 			return -EFAULT;
 
 		return 0;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 913b4a4..bb20987 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3104,7 +3104,7 @@ static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
 	}
 
 	dp = pci_device_to_OF_node(pdev);
-	if (node = dp->node) {
+	if (node = dp->phandle) {
 		struct fb_var_screeninfo *var = &default_var;
 		unsigned int N, P, Q, M, T, R;
 		u32 v_total, h_total;
diff --git a/include/linux/of.h b/include/linux/of.h
index 0a51742..bbf0e58 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -39,10 +39,7 @@ struct of_irq_controller;
 struct device_node {
 	const char *name;
 	const char *type;
-	phandle	node;
-#if !defined(CONFIG_SPARC)
-	phandle linux_phandle;
-#endif
+	phandle phandle;
 	char	*full_name;
 
 	struct	property *properties;
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 586965f..7a437da 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -768,7 +768,7 @@ static int check_codec(struct aoa_codec *codec,
 				"required property %s not present\n", propname);
 			return -ENODEV;
 		}
-		if (*ref != codec->node->linux_phandle) {
+		if (*ref != codec->node->phandle) {
 			printk(KERN_INFO "snd-aoa-fabric-layout: "
 				"%s doesn't match!\n", propname);
 			return -ENODEV;

