From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 10 Apr 2018 17:34:37 +0000
Subject: Re: sparc64 PCI BAR allocation is still problematic
Message-Id: <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
In-Reply-To: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, Apr 08, 2018 at 09:44:57PM +0300, Meelis Roos wrote:
> This is a followup on the thread https://lkml.org/lkml/2015/10/7/135 and 
> corresponding https://bugzilla.kernel.org/show_bug.cgi?id7191 entry.
> 
> I saw some sparc64 PCI allocation changes in yesterdays git and compiled 
> 4.16.0-10242-gf605ba9 on most of my sparc64 machines to test if the PCI 
> BAR allocation problems introduced in 4.3 were fixed on some of them. 
> Alas, no change at all - of the test machines, none showed any changes 
> in the error messages in "dmesg | grep BAR".
> 
> There was one test machine, T1000 with no addon cards, that did not 
> encounter any problem, before or after the recent patch. All the other 
> test machines tried still have the BAR allocation problems.
> 
> The errors seem to cluster into 3 categories:
> 
> 1. many devices fail BAR allocations
> 2. one of the Davicom Ethernet devices fails BAR allocation
> 3. Uli ISA bridge fails BAR allocation.

Thank you very much for all the data you've collected, and I apologize
for the fact that this has lingered so long.  Yinghai started fixing
some of these a year ago, but the conversation petered out before it
got completed.

There are several unrelated problems here, so I'm looking at one at a
time.

Below is a test patch (based on fd3b36d27566) for the "conflict with
Video RAM" messages.  Could you try this on one of the machines that
complains about that?  I'm interested in the dmesg and /proc/iomem
contents.  You already attached the lspci output, and I don't think
this patch will affect that.

It looks like everything except T2000 and V245 has this problem (it's
dependent on whether the box has a VGA device and whether firmware has
assigned the VGA framebuffer area to some non-VGA device).  Most of
your machines have other problems as well, and I'll look at those
next.

Bjorn


commit bc270e0028cd0856d5689cab38f0071f0d07b3be
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Apr 10 08:47:34 2018 -0500

    sparc/PCI: Request legacy VGA framebuffer only for VGA devices
    
    Previously we unconditionally requested the legacy VGA framebuffer (bus
    address 0xa0000-0xbffff) before we even know what PCI devices are present,
    in these paths:
    
      pci_fire_pbm_init, schizo_pbm_init, pci_sun4v_pbm_init, psycho_pbm_init_common
        pci_determine_mem_io_space
          pci_register_legacy_regions
            p->start = mem_res->start + 0xa0000
            request_resource(mem_res, p)    # claim VGA framebuffer
        pci_scan_one_pbm
          pci_of_scan_bus                   # scan DT for PCI devices
          pci_claim_bus_resources           # claim PCI device BARs
    
    If we found a PCI device with a BAR that overlapped the framebuffer area,
    we complained about not being able to claim the BAR, e.g.,
    
      pci_bus 0002:00: root bus resource [mem 0x7ff00000000-0x7ffffffffff] (bus address [0x00000000-0xffffffff])
      pci 0002:00:07.0: can't claim BAR 1 [mem 0x7ff00000000-0x7ff000fffff]: address conflict with Video RAM area [??? 0x7ff000a0000-0x7ff000bffff flags 0x80000000]
    
    If there is no VGA device in the same PCI segment, there's no reason to
    reserve the framebuffer and there's no conflict.
    
    If there *is* a VGA device in the same segment, both the VGA device and the
    device with an overlapping BAR may respond to the framebuffer addresses,
    which may cause bus errors.
    
    Request the legacy framebuffer area only when we actually find a VGA
    device.  This is not sparc-specific and could be made more generic in the
    PCI core eventually.
    
    Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id7191
    Reported-by: Meelis Roos <mroos@linux.ee>

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 41b20edb427d..e2b4f2e44dd3 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -624,6 +624,44 @@ static void pci_bus_register_of_sysfs(struct pci_bus *bus)
 		pci_bus_register_of_sysfs(child_bus);
 }
 
+static void pci_claim_legacy_resources(struct pci_dev *dev)
+{
+	struct pci_bus_region region;
+	struct resource *p, *root, *conflict;
+
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
+	pcibios_bus_to_resource(bus, p, &region);
+
+	root = pci_find_parent_resource(dev, p);
+	if (!root) {
+		pci_info(dev, "can't claim VGA legacy %pR: no compatible bridge window\n", p);
+		goto err;
+	}
+
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
@@ -648,6 +686,8 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 
 			pci_claim_resource(dev, i);
 		}
+
+		pci_claim_legacy_resources(dev);
 	}
 
 	list_for_each_entry(child_bus, &bus->children, node)
@@ -687,6 +727,7 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
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
 
