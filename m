From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2020 02:19:46 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <2629240c07af7fec5989127ed6da405e12cf77a3.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200714234625.GA428442@bjorn-Precision-5520>
In-Reply-To: <20200714234625.GA428442@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Kjetil Oftedal <oftedal@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Tue, 2020-07-14 at 18:46 -0500, Bjorn Helgaas wrote:
> Yes.  I have no problem with that.  There are a few cases where it's
> important to check for errors, e.g., we read a status register and do
> something based on a bit being set.  A failure will return all bits
> set, and we may do the wrong thing.  But most of the errors we care
> about will be on MMIO reads, not config reads, so we can probably
> ignore most config read errors.

And in both cases, we don't have the plumbing to provide accurate
and reliable error returns for all platforms anyways (esp. not for
MMIO).

I think it makes sense to stick to the good old "if all 1's, then go
out of line" including for config space.

 ../..

> Yep, except for things like device removal or other PCI errors.

A whole bunch of these are reported asynchronously, esp for writes (and
yes, including config writes, they are supposed to be non-posted but
more often than not, the path  from the CPU to the PCI bridge remains
posted for writes including config ones).

> So maybe a good place to start is by removing some of the useless
> error checking for pci_read_config_*() and pci_write_config_*().
> That's a decent-sized but not impractical project that could be done
> per subsystem or something:
> 
>   git grep -E "(if|return|=).*\<pci_(read|write)_config" drivers
> 
> finds about 400 matches.
> 
> Some of those callers probably really *do* want to check for errors,
> and I guess we'd have to identify them and do them separately as you
> mentioned.

I'd be curious about these considering how unreliable our error return
is accross the board.

Cheers,
Ben.
