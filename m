From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Oct 2007 11:36:30 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <1192620990.11899.168.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017.042229.95059231.davem@davemloft.net>
In-Reply-To: <20071017.042229.95059231.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au


> I find it ironic that you add of_get_pci_dev_node() as a function
> which gets the node and grabs a reference to it, and then the very
> first usage you make of it doesn't drop the reference at all.
> 
> That reference grabbing aspect of the new interface is obviously very
> useful! :-)
> 
> Kidding aside (I realize that in this case probably the driver never
> unregisters and therefore the reference never needs to be released)
> it's really much nicer to add facilities when you have patches in hand
> that actually use them.

I think in this case, it's mostly a matter of consistency... pretty much
everything that returns a device_node grabs a reference... except
pci_device_to_OF_node :-)

I think Michael is trying to address that, and axon-msi happens to be
something he wrote so a good candidate for an initial conversion :-)

Cheers,
Ben.


