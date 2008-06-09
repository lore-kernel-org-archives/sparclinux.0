From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jun 2008 22:08:56 +0000
Subject: Re: [panic] "Cheetah error trap taken" with Debian 2.6.24 kernel
Message-Id: <20080609.150856.01907496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806100003.54269.elendil@planet.nl>
In-Reply-To: <200806100003.54269.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Tue, 10 Jun 2008 00:03:53 +0200

> Cheetah error trap taken afsr[0010080005000000] afar [000007f900800000]
> TPC[553f94] TNPC[553f98] O7[554274] TSTATE[9980001606]
> TPC<pci_get_rom_size+0x18/0xc4>

pci_get_rom_size() is being called with an I/O address that
isn't responding.  It is being called via pci_map_rom() because
I see no drivers directly calling pci_get_rom_size().

Find out what device driver is calling this routine.
