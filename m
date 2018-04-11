From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 11 Apr 2018 20:01:43 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <20180411200143.GA105104@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
 <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
 <20180410185610.GD24642@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111045330.18432@math.ut.ee>
 <20180411133334.GA91792@bhelgaas-glaptop.roam.corp.google.com>
 <alpine.LRH.2.21.1804111738260.18432@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1804111738260.18432@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

On Wed, Apr 11, 2018 at 05:40:41PM +0300, Meelis Roos wrote:
> > On Wed, Apr 11, 2018 at 10:59:19AM +0300, Meelis Roos wrote:
> > > > Oops, sorry, I can't easily compile test it.  Here's an updated patch:
> > > > 
> > > > commit a9ded309cbf3f57e9979848fd0aa0ffacdf11f1a
> > > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > > Date:   Tue Apr 10 08:47:34 2018 -0500
> > > 
> > > Thanks, this patch compiles and works - Video RAM related BAR allocation 
> > > errors are gone.
> > 
> > Great, thanks!  I didn't mean to take up so much of your time testing
> > *all* of your systems :)
> 
> Well, they compiled in parallel :)
> 
> > > Hera are the /proc/iomem's but unfortunately the physical 
> > > addresses have been censored by security:
> > 
> > If you look at /proc/iomem as root, you should see the actual
> > addresses.
> 
> Yes, that was it.
> 
> > If you have any systems with VGA, it would be useful to test one of
> > them.  
> 
> This is Blade 100, with atyfb frame buffer:
> 
> # cat /proc/iomem 
> 00000000-7effdfff : System RAM
>   00404000-0085aadf : Kernel code
>   0085aae0-009b8a8f : Kernel data
>   009f2000-00a37a37 : Kernel bss
> 7f000000-7fee5fff : System RAM
> 7ff04000-7ff0bfff : System RAM
> 1ff00000000-1ffffffffff : /pci@1f,0
>   1ff00000000-1ff000fffff : 0000:00:07.0
>   1ff00400000-1ff0041ffff : 0000:00:0c.1
>     1ff00400000-1ff0041ffff : sungem
>   1ff00420000-1ff00421fff : 0000:00:0c.2
>   1ff00422000-1ff00423fff : 0000:00:0c.2
>   1ff00424000-1ff00425fff : 0000:00:08.0
>   1ff00426000-1ff00427fff : 0000:00:13.0
>   1ff00440000-1ff0045ffff : 0000:00:13.0

Thanks, this is really interesting.  Would you mind replacing the test
patch with the following (this applies directly on the upstream
kernel, e.g., fd3b36d27566)?

Sorry for the back and forth, but there's a lot going on here that I
don't understand.  

I'd like to see the complete dmesg log, /proc/iomem, and "lspci -vv".


diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 41b20edb427d..ffb9227c1b80 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -166,7 +166,7 @@ void pci_config_write32(u32 *addr, u32 val)
 	spin_unlock_irqrestore(&pci_poke_lock, flags);
 }
 
-static int ofpci_verbose;
+static int ofpci_verbose = 1;
 
 static int __init ofpci_debug(char *str)
 {
@@ -243,6 +243,8 @@ static void pci_parse_of_addrs(struct platform_device *op,
 		res->end = op_res->end;
 		res->flags = flags;
 		res->name = pci_name(dev);
+
+		pci_info(dev, "reg 0x%x: %pR\n", i, res);
 	}
 }
 
@@ -353,6 +355,9 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 			dev->irq = PCI_IRQ_NONE;
 	}
 
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+
 	pci_parse_of_addrs(sd->op, node, dev);
 
 	if (ofpci_verbose)
@@ -624,6 +629,46 @@ static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
+static void pci_claim_legacy_resources(struct pci_dev *dev)
+{
+	struct pci_bus_region region;
+	struct resource *p, *root, *conflict;
+
+	pci_info(dev, "class %#x\n", dev->class);
+	if ((dev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return;
+
+	p->name = "Video RAM area";
+	p->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	region.start = 0xa0000UL;
+	region.end = region.start + 0x1ffffUL;
+	pcibios_bus_to_resource(dev->bus, p, &region);
+
+	root = pci_find_parent_resource(dev, p);
+	if (!root) {
+		pci_info(dev, "can't claim VGA legacy %pR: no compatible bridge window\n", p);
+		goto err;
+	}
+
+	pci_info(dev, "requesting %pR from %s %pR\n", p, root->name, root);
+	conflict = request_resource_conflict(root, p);
+	if (conflict) {
+		pci_info(dev, "can't claim VGA legacy %pR: address conflict with %s %pR\n",
+			 p, conflict->name, conflict);
+		goto err;
+	}
+
+	return;
+
+err:
+	kfree(p);
+}
+
 static void pci_claim_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *child_bus;
@@ -648,6 +693,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 
 			pci_claim_resource(dev, i);
 		}
+
+		pci_claim_legacy_resources(dev);
 	}
 
 	list_for_each_entry(child_bus, &bus->children, node)
@@ -687,6 +734,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
 	pci_bus_register_of_sysfs(bus);
 
 	pci_claim_bus_resources(bus);
+
 	pci_bus_add_devices(bus);
 	return bus;
 }
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 38d46bcc8634..9bb6a192ef3f 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -329,23 +329,6 @@ void pci_get_pbm_props(struct pci_pbm_info *pbm)
 	}
 }
 
-static void pci_register_legacy_regions(struct resource *io_res,
-					struct resource *mem_res)
-{
-	struct resource *p;
-
-	/* VGA Video RAM. */
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return;
-
-	p->name = "Video RAM area";
-	p->start = mem_res->start + 0xa0000UL;
-	p->end = p->start + 0x1ffffUL;
-	p->flags = IORESOURCE_BUSY;
-	request_resource(mem_res, p);
-}
-
 static void pci_register_iommu_region(struct pci_pbm_info *pbm)
 {
 	const u32 *vdma = of_get_property(pbm->op->dev.of_node, "virtual-dma",
@@ -487,8 +470,6 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	if (pbm->mem64_space.flags)
 		request_resource(&iomem_resource, &pbm->mem64_space);
 
-	pci_register_legacy_regions(&pbm->io_space,
-				    &pbm->mem_space);
 	pci_register_iommu_region(pbm);
 }
 
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 1c5e74cb9279..147f8d205fdc 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -643,6 +643,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	 * clear that below if the bridge isn't forwarding
 	 */
 	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	vgaarb_info(&pdev->dev, "command %#06x\n", cmd);
 	if (cmd & PCI_COMMAND_IO)
 		vgadev->owns |= VGA_RSRC_LEGACY_IO;
 	if (cmd & PCI_COMMAND_MEMORY)
@@ -1469,7 +1470,7 @@ static void __init vga_arb_select_default_device(void)
 						  struct vga_device, list);
 		if (vgadev) {
 			struct device *dev = &vgadev->pdev->dev;
-			vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
+			vgaarb_info(dev, "setting as boot device (VGA legacy resources not enabled)\n");
 			vga_set_default_device(vgadev->pdev);
 		}
 	}
