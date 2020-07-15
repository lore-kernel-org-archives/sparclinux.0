From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2020 02:14:09 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <a565aef087e8c1b39c5eebd7f3f9575fe3cdee5f.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
 <20200714184550.GA397277@bjorn-Precision-5520>
 <CALMQjD9OVTbLVPGX-9+GDekZ02Wsqdz57-k1uCBMXC7cT3K_7w@mail.gmail.com>
In-Reply-To: <CALMQjD9OVTbLVPGX-9+GDekZ02Wsqdz57-k1uCBMXC7cT3K_7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kjetil Oftedal <oftedal@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Greg Ungerer <gerg@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Tue, 2020-07-14 at 23:02 +0200, Kjetil Oftedal wrote:
> > 
> > > For b), it might be nice to also change other aspects of the
> > > interface, e.g. passing a pci_host_bridge pointer plus bus number
> > > instead of a pci_bus pointer, or having the callback in the
> > > pci_host_bridge structure.
> > 
> > I like this idea a lot, too.  I think the fact that
> > pci_bus_read_config_word() requires a pci_bus * complicates things in
> > a few places.
> > 
> > I think it's completely separate, as you say, and we should defer it
> > for now because even part a) is a lot of work.  I added it to my list
> > of possible future projects.
> > 
> 
> What about strange PCI devices such as Non-Transparent bridges?
> They will require their own PCI Config space accessors that is not
> connected to a host bridge if one wants to do some sort of
> punch-through enumeration.
> I guess the kernel doesn't care much about them?

Well, today they would require a pci_bus anyway.. . so if you want to do
that sort of funny trick you may as well create a "virtual" host bridge.

Cheers,
Ben.
