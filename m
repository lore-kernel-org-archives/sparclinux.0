From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 15 Jul 2020 22:12:30 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <20200715221230.GA563957@bjorn-Precision-5520>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <1e2ae69a55f542faa18988a49e9b9491@AcuMS.aculab.com>
References: <20200714184550.GA397277@bjorn-Precision-5520>
In-Reply-To: <20200714184550.GA397277@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@ACULAB.COM>
Cc: linux-pci <linux-pci@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Christoph Hellwig <hch@lst.de>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Keith Busch <kbusch@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, 'Oliver O'Halloran' <oohall@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Jul 15, 2020 at 02:38:29PM +0000, David Laight wrote:
> From: Oliver O'Halloran
> > Sent: 15 July 2020 05:19
> > 
> > On Wed, Jul 15, 2020 at 8:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
> ...
> > > - config space accesses are very rare compared to memory
> > >   space access and on the hardware side the error handling
> > >   would be similar, but readl/writel don't return errors, they just
> > >   access wrong registers or return 0xffffffff.
> > >   arch/powerpc/kernel/eeh.c has a ton extra code written to
> > >   deal with it, but no other architectures do.
> > 
> > TBH the EEH MMIO hooks were probably a mistake to begin with. Errors
> > detected via MMIO are almost always asynchronous to the error itself
> > so you usually just wind up with a misleading stack trace rather than
> > any kind of useful synchronous error reporting. It seems like most
> > drivers don't bother checking for 0xFFs either and rely on the
> > asynchronous reporting via .error_detected() instead, so I have to
> > wonder what the point is. I've been thinking of removing the MMIO
> > hooks and using a background poller to check for errors on each PHB
> > periodically (assuming we don't have an EEH interrupt) instead. That
> > would remove the requirement for eeh_dev_check_failure() to be
> > interrupt safe too, so it might even let us fix all the godawful races
> > in EEH.
> 
> I've 'played' with PCIe error handling - without much success.
> What might be useful is for a driver that has just read ~0u to
> be able to ask 'has there been an error signalled for this device?'.

In many cases a driver will know that ~0 is not a valid value for the
register it's reading.  But if ~0 *could* be valid, an interface like
you suggest could be useful.  I don't think we have anything like that
today, but maybe we could.  It would certainly be nice if the PCI core
noticed, logged, and cleared errors.  We have some of that for AER,
but that's an optional feature, and support for the error bits in the
garden-variety PCI_STATUS register is pretty haphazard.  As you note
below, this sort of SERR/PERR reporting is frequently hard-wired in
ways that takes it out of our purview.

Bjorn
