From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2008 10:35:56 +0000
Subject: Re: [PATCH] sparc64: fix up bus_id changes in sparc core code
Message-Id: <20080703.033556.167121752.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080702153651.GB30318@kroah.com>
In-Reply-To: <20080702153651.GB30318@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@suse.de
Cc: davem@daveloft.net, kay.sievers@vrfy.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>
Date: Wed, 2 Jul 2008 08:36:51 -0700

> --- a/arch/sparc64/kernel/pci.c
> +++ b/arch/sparc64/kernel/pci.c
> @@ -408,7 +408,7 @@ struct pci_dev *of_create_pci_dev(struct
>  	dev->class = class >> 8;
>  	dev->revision = class & 0xff;
>  
> -	sprintf(dev->dev.bus_id, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
> +	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(bus),
>  		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));
>  
>  	if (ofpci_verbose)

Those lines read:

	sprintf(pci_name(dev), "%04x:%02x:%02x.%d", pci_domain_nr(bus),
		dev->bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn));

in Linus's current tree.

What are you patching against?  That first argument is not
dev->dev.bus_id in any tree I have sitting here, it's always
pci_name() :-)
