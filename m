From: David Miller <davem@davemloft.net>
Date: Wed, 17 Oct 2007 11:23:45 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <20071017.042345.108116673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017.042229.95059231.davem@davemloft.net>
In-Reply-To: <20071017.042229.95059231.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael@ellerman.id.au
Cc: sparclinux@vger.kernel.org, sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org

From: David Miller <davem@davemloft.net>
Date: Wed, 17 Oct 2007 04:22:29 -0700 (PDT)

> From: Michael Ellerman <michael@ellerman.id.au>
> Date: Wed, 17 Oct 2007 17:12:27 +1000 (EST)
> 
> > Use of_get_pci_dev_node() in axon_msi.c. Switch to including <linux/of.h>
> > so we get the prototype.
> > 
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> 
> I find it ironic that you add of_get_pci_dev_node() as a function
> which gets the node and grabs a reference to it, and then the very
> first usage you make of it doesn't drop the reference at all.

Ignore this poor attempt at humor, I misread your patch :)
