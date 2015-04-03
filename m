From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 03 Apr 2015 20:46:08 +0000
Subject: Re: [PATCH 2/3] sparc/PCI: Add mem64 resource parsing for root bus
Message-Id: <20150403204608.GE10892@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1427857069-6789-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

[+cc Ben, linuxppc-dev, Grant, Rob, devicetree]

On Tue, Mar 31, 2015 at 07:57:48PM -0700, Yinghai Lu wrote:
> Found "no compatible bridge window" warning in boot log from T5-8.
> 
> pci 0000:00:01.0: can't claim BAR 15 [mem 0x100000000-0x4afffffff pref]: no compatible bridge window
> 
> That resource is above 4G, but does not get offset correctly as
> root bus only report io and mem32.
> 
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> Add mem64 handling in pci_common for sparc, so we can have 64bit resource
> registered for root bus at first.
> 
> After patch, will have:
> pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
> pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
> pci_bus 0000:00: root bus resource [mem 0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
> pci_bus 0000:00: root bus resource [bus 00-77]
> 
> Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
> Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
> Reported-by: David Ahern <david.ahern@oracle.com>
> Tested-by: David Ahern <david.ahern@oracle.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: <stable@vger.kernel.org> #3.19
> ---
>  arch/sparc/kernel/pci.c        |  7 ++++++-
>  arch/sparc/kernel/pci_common.c | 15 +++++++++++++--
>  arch/sparc/kernel/pci_impl.h   |  1 +
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 9ce5afe..04ce3ac 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -185,8 +185,10 @@ static unsigned long pci_parse_of_flags(u32 addr0)
>  
>  	if (addr0 & 0x02000000) {
>  		flags = IORESOURCE_MEM | PCI_BASE_ADDRESS_SPACE_MEMORY;
> -		flags |= (addr0 >> 22) & PCI_BASE_ADDRESS_MEM_TYPE_64;
>  		flags |= (addr0 >> 28) & PCI_BASE_ADDRESS_MEM_TYPE_1M;
> +		if (addr0 & 0x01000000)
> +			flags |= IORESOURCE_MEM_64
> +				 | PCI_BASE_ADDRESS_MEM_TYPE_64;
>  		if (addr0 & 0x40000000)
>  			flags |= IORESOURCE_PREFETCH
>  				 | PCI_BASE_ADDRESS_MEM_PREFETCH;

This function is very similar to these:

  drivers/of/address.c			of_bus_pci_get_flags()
  arch/powerpc/kernel/pci_of_scan.c	pci_parse_of_flags()
  arch/sparc/kernel/of_device_32.c	of_bus_pci_get_flags()
  arch/sparc/kernel/of_device_64.c	of_bus_pci_get_flags()

Should they get a similar change?  They're all so similar that it would be
nice to consolidate them, but I think that would be out of scope for this
patch.

> @@ -663,6 +665,9 @@ struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
>  				pbm->io_space.start);
>  	pci_add_resource_offset(&resources, &pbm->mem_space,
>  				pbm->mem_space.start);
> +	if (pbm->mem64_space.flags)
> +		pci_add_resource_offset(&resources, &pbm->mem64_space,
> +					pbm->mem_space.start);
>  	pbm->busn.start = pbm->pci_first_busno;
>  	pbm->busn.end	= pbm->pci_last_busno;
>  	pbm->busn.flags	= IORESOURCE_BUS;
> diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
> index 944a065..a859a86 100644
> --- a/arch/sparc/kernel/pci_common.c
> +++ b/arch/sparc/kernel/pci_common.c
> @@ -406,6 +406,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  	}
>  
>  	num_pbm_ranges = i / sizeof(*pbm_ranges);
> +	memset(&pbm->mem64_space, 0, sizeof(struct resource));
>  
>  	for (i = 0; i < num_pbm_ranges; i++) {
>  		const struct linux_prom_pci_ranges *pr = &pbm_ranges[i];
> @@ -451,7 +452,11 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  			break;
>  
>  		case 3:
> -			/* XXX 64-bit MEM handling XXX */
> +			/* 64-bit MEM handling */
> +			pbm->mem64_space.start = a;
> +			pbm->mem64_space.end = a + size - 1UL;
> +			pbm->mem64_space.flags = IORESOURCE_MEM;
> +			break;
>  
>  		default:
>  			break;
> @@ -465,15 +470,21 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
>  		prom_halt();
>  	}
>  
> -	printk("%s: PCI IO[%llx] MEM[%llx]\n",
> +	printk("%s: PCI IO[%llx] MEM[%llx]",
>  	       pbm->name,
>  	       pbm->io_space.start,
>  	       pbm->mem_space.start);
> +	if (pbm->mem64_space.flags)
> +		printk(" MEM64[%llx]",
> +		       pbm->mem64_space.start);
> +	printk("\n");
>  
>  	pbm->io_space.name = pbm->mem_space.name = pbm->name;
>  
>  	request_resource(&ioport_resource, &pbm->io_space);
>  	request_resource(&iomem_resource, &pbm->mem_space);
> +	if (pbm->mem64_space.flags)
> +		request_resource(&iomem_resource, &pbm->mem64_space);
>  
>  	pci_register_legacy_regions(&pbm->io_space,
>  				    &pbm->mem_space);
> diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
> index 75803c7..37222ca 100644
> --- a/arch/sparc/kernel/pci_impl.h
> +++ b/arch/sparc/kernel/pci_impl.h
> @@ -97,6 +97,7 @@ struct pci_pbm_info {
>  	/* PBM I/O and Memory space resources. */
>  	struct resource			io_space;
>  	struct resource			mem_space;
> +	struct resource			mem64_space;
>  	struct resource			busn;
>  
>  	/* Base of PCI Config space, can be per-PBM or shared. */
> -- 
> 1.8.4.5
> 
