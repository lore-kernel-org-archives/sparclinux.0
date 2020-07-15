From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2020 22:49:21 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <5d4b3a716f85017c17c52a85915fba9e19509e81.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200715221230.GA563957@bjorn-Precision-5520>
In-Reply-To: <20200715221230.GA563957@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>, David Laight <David.Laight@ACULAB.COM>
Cc: linux-pci <linux-pci@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Christoph Hellwig <hch@lst.de>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Keith Busch <kbusch@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, 'Oliver O'Halloran' <oohall@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, 2020-07-15 at 17:12 -0500, Bjorn Helgaas wrote:
> > I've 'played' with PCIe error handling - without much success.
> > What might be useful is for a driver that has just read ~0u to
> > be able to ask 'has there been an error signalled for this device?'.
> 
> In many cases a driver will know that ~0 is not a valid value for the
> register it's reading.  But if ~0 *could* be valid, an interface like
> you suggest could be useful.  I don't think we have anything like that
> today, but maybe we could.  It would certainly be nice if the PCI core
> noticed, logged, and cleared errors.  We have some of that for AER,
> but that's an optional feature, and support for the error bits in the
> garden-variety PCI_STATUS register is pretty haphazard.  As you note
> below, this sort of SERR/PERR reporting is frequently hard-wired in
> ways that takes it out of our purview.

We do have pci_channel_state (via pci_channel_offline()) which covers
the cases where the underlying error handling (such as EEH or unplug)
results in the device being offlined though this tend to be
asynchronous so it might take a few ~0's before you get it.

It's typically used to break potentially infinite loops in some
drivers.

There is no interface to check whether *an* error happened though for
the most cases it will be captured in the status register, which is
harvested (and cleared ?) by some EDAC drivers iirc... 

All this lacks coordination, I agree.

Cheers,
Ben.
