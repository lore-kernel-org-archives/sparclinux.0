From: David Miller <davem@davemloft.net>
Date: Thu, 12 Apr 2007 21:11:15 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070412.141115.116376098.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Emanuele Rocca <ema@debian.org>
Date: Fri, 9 Mar 2007 00:21:57 +0100

> * David Miller <davem@davemloft.net>, [2007-03-08 15:08 -0800]:
> >  Ok.  Let me think about how to debug this.
> >  
> >  Can you build test kernels if I give you a patch?
> 
> Sure. 
> 
> config of my last build attached, maybe it gives you some helpful info.

Please add this debugging patch and boot, let me know what ends up
in your kernel log.

Thanks.

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index d7627fc..b7cca23 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3476,15 +3476,18 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	struct atyfb_par *par;
 	int i, rc = -ENOMEM;
 
+	printk("atyfb_pci_probe: Invoked\n");
 	for (i = ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
 		if (pdev->device = aty_chips[i].pci_id)
 			break;
 
-	if (i < 0)
+	if (i < 0) {
+		printk("atyfb_pci_probe: Cannot match in pci table\n");
 		return -ENODEV;
-
+	}
 	/* Enable device in PCI config */
 	if (pci_enable_device(pdev)) {
+		printk("atyfb_pci_probe: Cannot enable device\n");
 		PRINTKE("Cannot enable PCI device\n");
 		return -ENXIO;
 	}
@@ -3494,18 +3497,21 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	if (rp->flags & IORESOURCE_IO)
 		rp = &pdev->resource[1];
 	addr = rp->start;
-	if (!addr)
+	if (!addr) {
+		printk("atyfb_pci_probe: Resource start is zero\n");
 		return -ENXIO;
-
+	}
 	/* Reserve space */
 	res_start = rp->start;
 	res_size = rp->end - rp->start + 1;
-	if (!request_mem_region (res_start, res_size, "atyfb"))
+	if (!request_mem_region (res_start, res_size, "atyfb")) {
+		printk("atyfb_pci_probe: request_mem_region() fails\n");
 		return -EBUSY;
-
+	}
         /* Allocate framebuffer */
 	info = framebuffer_alloc(sizeof(struct atyfb_par), &pdev->dev);
 	if (!info) {
+		printk("atyfb_pci_probe: framebuffer_alloc() fails\n");
 		PRINTKE("atyfb_pci_probe() can't alloc fb_info\n");
 		return -ENOMEM;
 	}
@@ -3524,14 +3530,18 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 #else
 	rc = atyfb_setup_generic(pdev, info, addr);
 #endif
-	if (rc)
+	if (rc) {
+		printk("atyfb_pci_probe: atyfb_setup_foo() fails %d\n", rc);
 		goto err_release_mem;
+	}
 
 	pci_set_drvdata(pdev, info);
 
 	/* Init chip & register framebuffer */
-	if (aty_init(info))
+	if (aty_init(info)) {
+		printk("atyfb_pci_probe: atyfb_init() fails\n");
 		goto err_release_io;
+	}
 
 #ifdef __sparc__
 	if (!prom_palette)
@@ -3552,6 +3562,7 @@ static int __devinit atyfb_pci_probe(struct pci_dev *pdev, const struct pci_devi
 	par->mmap_map[1].prot_flag = _PAGE_E;
 #endif /* __sparc__ */
 
+	printk("atyfb_pci_probe: success\n");
 	return 0;
 
 err_release_io:
@@ -3820,12 +3831,14 @@ static int __init atyfb_init(void)
 #ifndef MODULE
     char *option = NULL;
 
+    printk("atyfb_init: Invoked\n");
     if (fb_get_options("atyfb", &option))
 	return -ENODEV;
     atyfb_setup(option);
 #endif
 
 #ifdef CONFIG_PCI
+    printk("atyfb_init: Registering PCI device\n");
     err1 = pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
