From: David Miller <davem@davemloft.net>
Date: Wed, 28 Jan 2009 06:29:10 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090127.222910.60111568.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 26 Jan 2009 11:04:39 +0100

> [   48.965131] calling  of_bus_driver_init+0x0/0x104
> [   49.021376] Setting up of bus

Strance, here is a patch to get some more information.

Please add this patch on top of what you have so far
and reboot.

Thanks.

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 100ebd5..031efa2 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -853,16 +853,19 @@ static int __init of_bus_driver_init(voi
 
 	printk(KERN_ERR "Setting up of bus\n");
 	err = of_bus_type_init(&of_platform_bus_type, "of");
+	printk(KERN_ERR "of_bus_type_init() returns %d\n", err);
 #ifdef CONFIG_PCI
 	if (!err) {
 		printk(KERN_ERR "Setting up ebus bus\n");
 		err = of_bus_type_init(&ebus_bus_type, "ebus");
+		printk(KERN_ERR "of_bus_type_init() returns %d\n", err);
 	}
 #endif
 #ifdef CONFIG_SBUS
 	if (!err) {
 		printk(KERN_ERR "Setting up sbus bus\n");
 		err = of_bus_type_init(&sbus_bus_type, "sbus");
+		printk(KERN_ERR "of_bus_type_init() returns %d\n", err);
 	}
 #endif
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ef522ae..427f582 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -869,57 +869,77 @@ int bus_register(struct bus_type *bus)
 	int retval;
 	struct bus_type_private *priv;
 
+	printk(KERN_ERR "In bus_register().\n");
 	priv = kzalloc(sizeof(struct bus_type_private), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		printk(KERN_ERR "priv allocation failed\n");
 		return -ENOMEM;
+	}
 
 	priv->bus = bus;
 	bus->p = priv;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&priv->bus_notifier);
 
+	printk(KERN_ERR "Doing kobject_set_name()\n");
 	retval = kobject_set_name(&priv->subsys.kobj, "%s", bus->name);
-	if (retval)
+	if (retval) {
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto out;
+	}
 
 	priv->subsys.kobj.kset = bus_kset;
 	priv->subsys.kobj.ktype = &bus_ktype;
 	priv->drivers_autoprobe = 1;
 
+	printk(KERN_ERR "kset_register()\n");
 	retval = kset_register(&priv->subsys);
-	if (retval)
+	if (retval) {
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto out;
+	}
 
+	printk(KERN_ERR "bus_create_file(bus, &bus_attr_uevent)\n");
 	retval = bus_create_file(bus, &bus_attr_uevent);
-	if (retval)
+	if (retval) {
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto bus_uevent_fail;
-
+	}
+	printk(KERN_ERR "kset_create_and_add(devices)\n");
 	priv->devices_kset = kset_create_and_add("devices", NULL,
 						 &priv->subsys.kobj);
 	if (!priv->devices_kset) {
 		retval = -ENOMEM;
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto bus_devices_fail;
 	}
 
+	printk(KERN_ERR "kset_create_and_add(drivers)\n");
 	priv->drivers_kset = kset_create_and_add("drivers", NULL,
 						 &priv->subsys.kobj);
 	if (!priv->drivers_kset) {
 		retval = -ENOMEM;
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto bus_drivers_fail;
 	}
 
 	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&priv->klist_drivers, NULL, NULL);
 
+	printk(KERN_ERR "add_probe_files()\n");
 	retval = add_probe_files(bus);
-	if (retval)
+	if (retval) {
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto bus_probe_files_fail;
-
+	}
+	printk(KERN_ERR "bus_add_attrs()\n");
 	retval = bus_add_attrs(bus);
-	if (retval)
+	if (retval) {
+		printk(KERN_ERR "Failed with err %d\n", retval);
 		goto bus_attrs_fail;
-
+	}
 	pr_debug("bus: '%s': registered\n", bus->name);
+	printk(KERN_ERR "Success\n");
 	return 0;
 
 bus_attrs_fail:
