From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jan 2009 02:30:23 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090125.183023.179806550.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 22 Jan 2009 14:29:34 +0100

> Compiled 2.6.27.12 today without the CON_BOOT flag and booted with the
> options above. The hang seems to be in of_bus_driver_init, see
> console output below.

I wonder what's getting tripped up in there :-)

Please add this patch and get the new console output, thanks!

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 100ebd5..fefd415 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -818,10 +818,16 @@ static struct of_device * __init scan_one_device(struct device_node *dp,
 static void __init scan_tree(struct device_node *dp, struct device *parent)
 {
 	while (dp) {
-		struct of_device *op = scan_one_device(dp, parent);
-
-		if (op)
+		struct of_device *op;
+
+		printk(KERN_ERR "scan_tree: Scanning device %p:[%s]\n",
+		       dp, (dp ? dp->full_name : "<NULL>"));
+		op = scan_one_device(dp, parent);
+		if (op) {
+			printk(KERN_ERR "scan_tree: Recursing to child %p\n",
+			       dp->child);
 			scan_tree(dp->child, &op->dev);
+		}
 
 		dp = dp->sibling;
 	}
@@ -832,10 +838,12 @@ static void __init scan_of_devices(void)
 	struct device_node *root = of_find_node_by_path("/");
 	struct of_device *parent;
 
+	printk(KERN_ERR "Building root from %p\n", root);
 	parent = scan_one_device(root, NULL);
 	if (!parent)
 		return;
 
+	printk(KERN_ERR "Scanning tree...\n");
 	scan_tree(root->child, &parent->dev);
 }
 
@@ -843,18 +851,26 @@ static int __init of_bus_driver_init(void)
 {
 	int err;
 
+	printk(KERN_ERR "Setting up of bus\n");
 	err = of_bus_type_init(&of_platform_bus_type, "of");
 #ifdef CONFIG_PCI
-	if (!err)
+	if (!err) {
+		printk(KERN_ERR "Setting up ebus bus\n");
 		err = of_bus_type_init(&ebus_bus_type, "ebus");
+	}
 #endif
 #ifdef CONFIG_SBUS
-	if (!err)
+	if (!err) {
+		printk(KERN_ERR "Setting up sbus bus\n");
 		err = of_bus_type_init(&sbus_bus_type, "sbus");
+	}
 #endif
 
-	if (!err)
+	if (!err) {
+		printk(KERN_ERR "scan_of_devices()\n");
 		scan_of_devices();
+		printk(KERN_ERR "Done with scan_of_devices()\n");
+	}
 
 	return err;
 }
