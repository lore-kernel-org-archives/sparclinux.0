From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 23 Oct 2007 07:40:26 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <1193125226.6745.185.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
	<1192670843.6681.10.camel@concordia>
	<20071018190939.GE29903@austin.ibm.com>
	<1193125016.20274.4.camel@concordia>
In-Reply-To: <1193125016.20274.4.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael@ellerman.id.au
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>


> So Ben suggested what we really want is two routines,
> of_get_pci_dev_node() and of_peek_pci_dev_node() - the former returning
> a refcounted copy and the latter allowing you to "peek" at the
> device_node as long as you own the pci_dev.
> 
> I'm not sure it's worth the churn really, so we should probably just
> document that pci_device_to_OF_node() is contrary, and any users that
> need a reference can take one explicitly.

Yeah, I pretty much made the same decision a couple of years ago which
is why it's still the way it is now :-)

Cheers,
Ben.


