From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2020 22:26:40 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <627b214e6fc0624093caa8155d7006de111aacfb.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
 <20200714234625.GA428442@bjorn-Precision-5520>
 <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Kjetil Oftedal <oftedal@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, 2020-07-15 at 08:47 +0200, Arnd Bergmann wrote:
> drivers/misc/cardreader/rts5261.c:      retval > rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);
> 
> That last one is interesting because I think this is a case in which
> we
> actually want to check for errors, as the driver seems to use it
> to ensure that accessing extended config space at offset 0x814
> works before relying on the value. Unfortunately the implementation
> seems buggy as it a) keeps using the possibly uninitialized value
> after
> printing a warning and b) returns the PCIBIOS_* value in place of a
> negative errno and then ignores it in the caller.

In cases like this, usually checking against ~0 is sufficient

Cheers,
Ben.
