From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jul 2020 06:47:17 +0000
Subject: Re: [RFC PATCH 00/35] Move all PCIBIOS* definitions into arch/x86
Message-Id: <CAK8P3a3OEOosC2VEHb3z7hTA=BjVp0nv9bNxBWzEnmgSDDTX3Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a3EZX8=649R9cYF6_=ivh1Xyrgsc5mUtS=d5yvQ3doZaQ@mail.gmail.com>
 <20200714234625.GA428442@bjorn-Precision-5520>
In-Reply-To: <20200714234625.GA428442@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Keith Busch <kbusch@kernel.org>, Paul Mackerras <paulus@samba.org>, sparclinux <sparclinux@vger.kernel.org>, Toan Le <toan@os.amperecomputing.com>, Kjetil Oftedal <oftedal@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sagi Grimberg <sagi@grimberg.me>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Kevin Hilman <khilman@baylibre.com>, linux-pci <linux-pci@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-kernel-mentees@lists.linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>, Ray Jui <rjui@broadcom.com>, Jens Axboe <axboe@fb.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Scott Branden <sbranden@broadcom.com>, Jingoo Han <jingoohan1@gmail.com>, "Saheed O. Bolarinwa" <refactormyself@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Jul 15, 2020 at 1:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

 So something like:
>
>   void pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
>
> and where we used to return anything non-zero, we just set *val = ~0
> instead?  I think we do that already in most, maybe all, cases.

Right, this is what I had in mind. If we start by removing the handling
of the return code in all files that clearly don't need it, looking at
whatever remains will give a much better idea of what a good interface
should be.

>  git grep -E "(if|return|=).*\<pci_(read|write)_config" drivers
> finds about 400 matches.

Right, and this is some 112 files to look at.

I had a slightly different regex, which found more false-positives, but
also these:

arch/x86/kernel/amd_nb.c:      : pci_read_config_dword(root, 0x64, value));
drivers/i2c/busses/i2c-sis630.c:     pci_write_config_byte(sis630_dev,
SIS630_BIOS_CTL_REG, b | 0x80)) {
drivers/i2c/busses/i2c-viapro.c:     !pci_read_config_word(pdev,
SMBBA2, &vt596_smba) &&
drivers/ide/rz1000.c:     !pci_write_config_word(dev, 0x40, reg & 0xdfff)) {
drivers/net/ethernet/realtek/r8169_main.c:
pci_write_config_byte(pdev, 0x070f, val) = PCIBIOS_SUCCESSFUL)
include/linux/rtsx_pci.h:#define rtsx_pci_read_config_dword(pcr,
where, val) pci_read_config_dword((pcr)->pci, where, val)
include/linux/rtsx_pci.h:#define rtsx_pci_write_config_dword(pcr,
where, val) pci_write_config_dword((pcr)->pci, where, val)
drivers/misc/cardreader/rts5261.c:              retval rtsx_pci_read_config_dword(pcr,
drivers/misc/cardreader/rts5261.c:      retval rtsx_pci_write_config_dword(pcr, PCR_SETTING_REG2, lval);

That last one is interesting because I think this is a case in which we
actually want to check for errors, as the driver seems to use it
to ensure that accessing extended config space at offset 0x814
works before relying on the value. Unfortunately the implementation
seems buggy as it a) keeps using the possibly uninitialized value after
printing a warning and b) returns the PCIBIOS_* value in place of a
negative errno and then ignores it in the caller.

      Arnd
