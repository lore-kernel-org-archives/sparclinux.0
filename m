From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 08:20:05 +0000
Subject: [PATCH 11/11] of: unify phandle name in struct device_node
Message-Id: <20091124081957.6216.74456.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua>
In-Reply-To: <20091124081316.6216.66310.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, benh@kernel.crashing.org, sfr@canb.auug.org.au, dave

In struct device_node, the phandle is named 'linux_phandle' for PowerPC
and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
difference, it is just an artifact of the code diverging over a couple
of years.  This patch renames .node to .linux_phandle for SPARC.

Note: the .node also existed in PowerPC/MicroBlaze, but the only user
seems to be arch/powerpc/platforms/powermac/pfunc_core.c.  It doesn't
look like the assignment between .linux_phandle and .node is
significantly different enough to warrant the separate code paths
unless ibm,phandle properties actually appear in Apple device trees.

I think it is safe to eliminate the old .node property and use
linux_phandle everywhere.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/powermac/pfunc_core.c |    2 +-
 arch/sparc/kernel/devices.c                  |    2 +-
 arch/sparc/kernel/of_device_32.c             |    2 +-
 arch/sparc/kernel/of_device_64.c             |    2 +-
 arch/sparc/kernel/prom_common.c              |    8 ++++----
 arch/sparc/kernel/smp_64.c                   |    2 +-
 drivers/of/fdt.c                             |    3 +--
 drivers/sbus/char/openprom.c                 |   10 +++++-----
 drivers/video/aty/atyfb_base.c               |    2 +-
 include/linux/of.h                           |    3 ---
 10 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 96d5ce5..2004b19 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -842,7 +842,7 @@ struct pmf_function *__pmf_find_function(struct device_node *target,
 	list_for_each_entry(func, &dev->functions, link) {
 		if (name && strcmp(name, func->name))
 			continue;
-		if (func->phandle && target->node != func->phandle)
+		if (func->phandle && target->linux_phandle != func->phandle)
 			continue;
 		if ((func->flags & flags) = 0)
 			continue;
diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index b171ae8..2196e71 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -59,7 +59,7 @@ static int __cpu_find_by(int (*compare)(int, int, void *), void *compare_arg,
 
 	cur_inst = 0;
 	for_each_node_by_type(dp, "cpu") {
-		int err = check_cpu_node(dp->node, &cur_inst,
+		int err = check_cpu_node(dp->linux_phandle, &cur_inst,
 					 compare, compare_arg,
 					 prom_node, mid);
 		if (!err) {
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4c26eb5..27f4c2e 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -433,7 +433,7 @@ build_resources:
 	if (!parent)
 		dev_set_name(&op->dev, "root");
 	else
-		dev_set_name(&op->dev, "%08x", dp->node);
+		dev_set_name(&op->dev, "%08x", dp->linux_phandle);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 881947e..9a6245d 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -666,7 +666,7 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 	if (!parent)
 		dev_set_name(&op->dev, "root");
 	else
-		dev_set_name(&op->dev, "%08x", dp->node);
+		dev_set_name(&op->dev, "%08x", dp->linux_phandle);
 
 	if (of_device_register(op)) {
 		printk("%s: Could not register of device.\n",
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index d80a65d..2a3e302 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -42,7 +42,7 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 	struct device_node *np;
 
 	for (np = allnodes; np; np = np->allnext)
-		if (np->node = handle)
+		if (np->linux_phandle = handle)
 			break;
 
 	return np;
@@ -89,7 +89,7 @@ int of_set_property(struct device_node *dp, const char *name, void *val, int len
 			void *old_val = prop->value;
 			int ret;
 
-			ret = prom_setprop(dp->node, name, val, len);
+			ret = prom_setprop(dp->linux_phandle, name, val, len);
 
 			err = -EINVAL;
 			if (ret >= 0) {
@@ -236,7 +236,7 @@ static struct device_node * __init prom_create_node(phandle node,
 
 	dp->name = get_one_property(node, "name");
 	dp->type = get_one_property(node, "device_type");
-	dp->node = node;
+	dp->linux_phandle = node;
 
 	dp->properties = build_prop_list(node);
 
@@ -313,7 +313,7 @@ void __init prom_build_devicetree(void)
 
 	nextp = &allnodes->allnext;
 	allnodes->child = prom_build_tree(allnodes,
-					  prom_getchild(allnodes->node),
+					  prom_getchild(allnodes->linux_phandle),
 					  &nextp);
 	of_console_init();
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index aa36223..9222700 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -370,7 +370,7 @@ static int __cpuinit smp_boot_one_cpu(unsigned int cpu)
 	} else {
 		struct device_node *dp = of_find_node_by_cpuid(cpu);
 
-		prom_startcpu(dp->node, entry, cookie);
+		prom_startcpu(dp->linux_phandle, entry, cookie);
 	}
 
 	for (timeout = 0; timeout < 50000; timeout++) {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6164781..07ae161 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -315,9 +315,8 @@ unsigned long __init unflatten_dt_node(unsigned long mem,
 					__alignof__(struct property));
 		if (allnextpp) {
 			if (strcmp(pname, "linux,phandle") = 0) {
-				np->node = *((u32 *)*p);
 				if (np->linux_phandle = 0)
-					np->linux_phandle = np->node;
+					np->linux_phandle = *((u32 *)*p);
 			}
 			if (strcmp(pname, "ibm,phandle") = 0)
 				np->linux_phandle = *((u32 *)*p);
diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 75ac19b..a776e65 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -233,7 +233,7 @@ static int opromnext(void __user *argp, unsigned int cmd, struct device_node *dp
 
 	ph = 0;
 	if (dp)
-		ph = dp->node;
+		ph = dp->linux_phandle;
 
 	data->current_node = dp;
 	*((int *) op->oprom_array) = ph;
@@ -256,7 +256,7 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 
 		dp = pci_device_to_OF_node(pdev);
 		data->current_node = dp;
-		*((int *)op->oprom_array) = dp->node;
+		*((int *)op->oprom_array) = dp->linux_phandle;
 		op->oprom_size = sizeof(int);
 		err = copyout(argp, op, bufsize + sizeof(int));
 
@@ -273,7 +273,7 @@ static int oprompath2node(void __user *argp, struct device_node *dp, struct open
 
 	dp = of_find_node_by_path(op->oprom_array);
 	if (dp)
-		ph = dp->node;
+		ph = dp->linux_phandle;
 	data->current_node = dp;
 	*((int *)op->oprom_array) = ph;
 	op->oprom_size = sizeof(int);
@@ -540,7 +540,7 @@ static int opiocgetnext(unsigned int cmd, void __user *argp)
 		}
 	}
 	if (dp)
-		nd = dp->node;
+		nd = dp->linux_phandle;
 	if (copy_to_user(argp, &nd, sizeof(phandle)))
 		return -EFAULT;
 
@@ -570,7 +570,7 @@ static int openprom_bsd_ioctl(struct inode * inode, struct file * file,
 	case OPIOCGETOPTNODE:
 		BUILD_BUG_ON(sizeof(phandle) != sizeof(int));
 
-		if (copy_to_user(argp, &options_node->node, sizeof(phandle)))
+		if (copy_to_user(argp, &options_node->linux_phandle, sizeof(phandle)))
 			return -EFAULT;
 
 		return 0;
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 913b4a4..8357927 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3104,7 +3104,7 @@ static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
 	}
 
 	dp = pci_device_to_OF_node(pdev);
-	if (node = dp->node) {
+	if (node = dp->linux_phandle) {
 		struct fb_var_screeninfo *var = &default_var;
 		unsigned int N, P, Q, M, T, R;
 		u32 v_total, h_total;
diff --git a/include/linux/of.h b/include/linux/of.h
index 0a51742..0ddd985 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -39,10 +39,7 @@ struct of_irq_controller;
 struct device_node {
 	const char *name;
 	const char *type;
-	phandle	node;
-#if !defined(CONFIG_SPARC)
 	phandle linux_phandle;
-#endif
 	char	*full_name;
 
 	struct	property *properties;

