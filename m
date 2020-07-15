From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 15 Jul 2020 04:18:47 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <CAOSf1CEviMYySQhyQGks8hHjST-85wGpxEBasuxwSX_homBJ2A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a3NWSZw6678k1O2eJ6-c5GuW7484PRvEzU9MEPPrCD-yw@mail.gmail.com>
 <20200714184550.GA397277@bjorn-Precision-5520>
 <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci <linux-pci@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Christoph Hellwig <hch@lst.de>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Kevin Hilman <khilman@baylibre.com>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <helgaas@kernel.org>, Ray Jui <rjui@broadcom.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Keith Busch <kbusch@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Jul 15, 2020 at 8:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> - Most error checking is static: PCIBIOS_BAD_REGISTER_NUMBER
>   only happens if you pass an invalid register number, but most
>   callers pass a compile-time constant register number that is
>   known to be correct, or the driver would never work. Similarly,
>   PCIBIOS_DEVICE_NOT_FOUND wouldn't normally happen
>   since you pass a valid pci_device pointer that was already
>   probed.

Having some feedback about obvious programming errors is still useful
when doing driver development. Reporting those via printk() would
probably be more useful to those who care though.

> - config space accesses are very rare compared to memory
>   space access and on the hardware side the error handling
>   would be similar, but readl/writel don't return errors, they just
>   access wrong registers or return 0xffffffff.
>   arch/powerpc/kernel/eeh.c has a ton extra code written to
>   deal with it, but no other architectures do.

TBH the EEH MMIO hooks were probably a mistake to begin with. Errors
detected via MMIO are almost always asynchronous to the error itself
so you usually just wind up with a misleading stack trace rather than
any kind of useful synchronous error reporting. It seems like most
drivers don't bother checking for 0xFFs either and rely on the
asynchronous reporting via .error_detected() instead, so I have to
wonder what the point is. I've been thinking of removing the MMIO
hooks and using a background poller to check for errors on each PHB
periodically (assuming we don't have an EEH interrupt) instead. That
would remove the requirement for eeh_dev_check_failure() to be
interrupt safe too, so it might even let us fix all the godawful races
in EEH.

> - If we add code to detect errors in pci_read_config_*
>   and do some of the stuff from powerpc's
>   eeh_dev_check_failure(), we are more likely to catch
>   intermittent failures when drivers don't check, or bugs
>   with invalid arguments in device drivers than relying on
>   drivers to get their error handling right when those code
>   paths don't ever get covered in normal testing.

Adding some kind of error detection to the generic config accessors
wouldn't hurt, but detection is only half the problem. The main job of
eeh_dev_check_failure() is waking up the EEH recovery thread which
actually handles notifying drivers, device resets, etc and you'd want
something in the PCI core. Right now there's two implementations of
that reporting logic: one for EEH in arch/powerpc/eeh_driver.c and one
for AER/DPC in drivers/pci/pcie/err.c. I think the latter could be
moved into the PCI core easily enough since there's not much about it
that's really specific to PCIe. Ideally we could drop the EEH specific
one too, but I'm not sure how to implement that without it devolving
into callback spaghetti.

Oliver
