From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2020 02:12:29 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <fb40545a8de8df8914df40d7d6167752c5244ce6.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200714184550.GA397277@bjorn-Precision-5520>
In-Reply-To: <20200714184550.GA397277@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Greg Ungerer <gerg@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Tue, 2020-07-14 at 13:45 -0500, Bjorn Helgaas wrote:
> 
> > fail for valid arguments on a valid pci_device* ?
> 
> I really like this idea.
> 
> pci_write_config_*() has one return value, and only 100ish of 2500
> callers check for errors.  It's sometimes possible for config
> accessors to detect PCI errors and return failure, e.g., device was
> removed or didn't respond, but most of them don't, and detecting
> these
> errors is not really that valuable.
> 
> pci_read_config_*() is much more interesting because it returns two
> things, the function return value and the value read from the PCI
> device, and it's complicated to check both. 

  .../...

I agree. It's a mess at the moment.

We have separate mechanism to convey PCI errors (among other things the
channel state) which should apply to config space when detection is
possible.

I think returning all 1's is the right thing to do here and avoids odd
duplicate error detection logic which I bet you is never properly
tested.

> > For b), it might be nice to also change other aspects of the
> > interface, e.g. passing a pci_host_bridge pointer plus bus number
> > instead of a pci_bus pointer, or having the callback in the
> > pci_host_bridge structure.
> 
> I like this idea a lot, too.  I think the fact that
> pci_bus_read_config_word() requires a pci_bus * complicates things in
> a few places.
> 
> I think it's completely separate, as you say, and we should defer it
> for now because even part a) is a lot of work.  I added it to my list
> of possible future projects.

Agreed on both points.

Cheers,
Ben.
