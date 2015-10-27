From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2015 22:22:29 +0000
Subject: Re: [PATCH 4/7 v2] pseries/iommu: implement DDW-aware dma_get_page_shift
Message-Id: <20151027222229.GE7716@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151023205925.GF10197@linux.vnet.ibm.com>
 <562F11FA.9090805@ozlabs.ru>
In-Reply-To: <562F11FA.9090805@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 27.10.2015 [16:56:10 +1100], Alexey Kardashevskiy wrote:
> On 10/24/2015 07:59 AM, Nishanth Aravamudan wrote:
> >When DDW (Dynamic DMA Windows) are present for a device, we have stored
> >the TCE (Translation Control Entry) size in a special device tree
> >property. Check if we have enabled DDW for the device and return the TCE
> >size from that property if present. If the property isn't present,
> >fallback to looking the value up in struct iommu_table. If we don't find
> >a iommu_table, fallback to the kernel's page size.
> >
> >Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> >---
> >  arch/powerpc/platforms/pseries/iommu.c | 36 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> >diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> >index 0946b98..1bf6471 100644
> >--- a/arch/powerpc/platforms/pseries/iommu.c
> >+++ b/arch/powerpc/platforms/pseries/iommu.c
> >@@ -1292,6 +1292,40 @@ static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
> >  	return dma_iommu_ops.get_required_mask(dev);
> >  }
> >
> >+static unsigned long dma_get_page_shift_pSeriesLP(struct device *dev)
> >+{
> >+	struct iommu_table *tbl;
> >+
> >+	if (!disable_ddw && dev_is_pci(dev)) {
> >+		struct pci_dev *pdev = to_pci_dev(dev);
> >+		struct device_node *dn;
> >+
> >+		dn = pci_device_to_OF_node(pdev);
> >+
> >+		/* search upwards for ibm,dma-window */
> >+		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
> >+				dn = dn->parent)
> >+			if (of_get_property(dn, "ibm,dma-window", NULL))
> >+				break;
> >+		/*
> >+		 * if there is a DDW configuration, the TCE shift is stored in
> >+		 * the property
> >+		 */
> >+		if (dn && PCI_DN(dn)) {
> >+			const struct dynamic_dma_window_prop *direct64 > >+				of_get_property(dn, DIRECT64_PROPNAME, NULL);
> 
> 
> This DIRECT64_PROPNAME property is only present under pHyp, QEMU/KVM
> does not set it as 64bit windows are dynamic there so something like
> find_existing_ddw() needs to be used here.

DIRECT64_PROPNAME is a Linux thing, not a pHyp or QEMU/KVM thing -- it's
created by the Linux DDW logic and left in the device-tree when we
successfully configure DDW.

You're right, though, that logically find_existing_ddw() would be better
to use here. I'll spin up a new version.

-Nish

