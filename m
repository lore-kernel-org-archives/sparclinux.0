From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 04 May 2017 21:19:11 +0000
Subject: Re: [PATCH 09/13] PCI: Check pref compatible bit for mem64 resource of PCIe device
Message-Id: <20170504211910.GA9648@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-10-yinghai@kernel.org>
In-Reply-To: <20170421050500.13957-10-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Apr 20, 2017 at 10:04:56PM -0700, Yinghai Lu wrote:
> We still get "no compatible bridge window" warning on sparc T5-8
> after we add support for 64bit resource parsing for root bus.
> 
>  PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
>  PCI: Claiming 0000:00:01.0: Resource 15: 0000800100000000..00008004afffffff [220c]
>  PCI: Claiming 0000:01:00.0: Resource 15: 0000800100000000..00008004afffffff [220c]
>  PCI: Claiming 0000:02:04.0: Resource 15: 0000800100000000..000080012fffffff [220c]
>  PCI: Claiming 0000:03:00.0: Resource 15: 0000800100000000..000080012fffffff [220c]
>  PCI: Claiming 0000:04:06.0: Resource 14: 0000800100000000..000080010fffffff [220c]
>  PCI: Claiming 0000:05:00.0: Resource 0: 0000800100000000..0000800100001fff [204]
>  pci 0000:05:00.0: can't claim BAR 0 [mem 0x800100000000-0x800100001fff]: no compatible bridge window
> 
> All the bridges 64-bit resource have pref bit, but the device resource does not
> have pref set, then we can not find parent for the device resource,
> as we can not put non-pref mmio under pref mmio.
> 
> According to pcie spec errta
> https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
> page 13, in some case it is ok to mark some as pref.

This link is broken.  The text is included as an implementation note
in the PCIe r3.1 spec, sec 7.5.2.1.  If you cite that, I don't think
we need the link.  Please also fix the broken link in the patch below.

This changelog needs to recap the conditions in that implementation
note, i.e., entire path is PCIe, no conventional PCI or PCI-X devices
perform peer-to-peer, no byte merging, etc.  And we need something
about why we believe these conditions all hold.

In particular, I'm a little concerned about the peer-to-peer question
and the TH bit.  There are peer-to-peer patches being discussed,
though I don't know whether they include conventional PCI and PCI-X.

I don't think Linux currently does anything with the TH bit, but if we
do in the future, or if BIOS enabled TH via the TPH Requester
Capability (PCIe r3.1, sec 7.26) it seems like we could break
something.  Maybe we need to check for TPH being enabled?  I'm
interested in your opinion here.  The changelog should show that
you've considered the issue.

If we support peer-to-peer, I guess that if we do put a
non-prefetchable BAR in a prefetchable window, we would have to
prevent any device in the hierarchy from enabling TPH?

I have no idea how we know whether the BAR could be a target of a
speculative Memory Read.  I guess maybe the CPU ioremap properties are
such that speculative reads are prohibited for MMIO apertures?  Maybe
you could investigate that and include the results?

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5548044..676b55f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1920,6 +1920,36 @@ static void pci_dma_configure(struct pci_dev *dev)
>  	pci_put_host_bridge_device(bridge);
>  }
>  
> +static bool pci_up_path_over_pcie(struct pci_bus *bus)
> +{
> +	if (pci_is_root_bus(bus))
> +		return true;
> +
> +	if (bus->self && !pci_is_pcie(bus->self))
> +		return false;
> +
> +	return pci_up_path_over_pcie(bus->parent);
> +}
> +
> +/*
> + * According to
> + * https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
> + * page 13, system firmware could put some 64bit non-pref under 64bit pref,
> + * on some cases.
> + * Let's mark if entire path from the host to the adapter is over PCI
> + * Express. later will use that compute pref compaitable bit.
> + */
> +static void pci_set_on_all_pcie_path(struct pci_dev *dev)
> +{
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	if (!pci_up_path_over_pcie(dev->bus))
> +		return;
> +
> +	dev->on_all_pcie_path = 1;

I think this can be set more simply as:

  if (pci_is_pcie(dev)) {
    if (pci_is_root_bus(dev->bus))
      dev->pcie_path = 1;
    else if (dev->bus->self && dev->bus->self->pcie_path)
      dev->pcie_path = 1;
  }

How about if you just put this code in set_pcie_port_type() so you
don't have to add another function and worry about whether it's called
after pcie_cap is assigned?  Then you wouldn't need the pci_is_pcie()
test either.

> +}
> +
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  {
>  	int ret;
> @@ -1950,6 +1980,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	/* Initialize various capabilities */
>  	pci_init_capabilities(dev);
>  
> +	/* After pcie_cap is assigned */
> +	pci_set_on_all_pcie_path(dev);
> +
>  	/*
>  	 * Add the device to our list of discovered devices
>  	 * and the bus list for fixup functions, etc.
