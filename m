From: David Miller <davem@davemloft.net>
Date: Thu, 02 Jun 2011 21:36:06 +0000
Subject: Re: [PATCH 0/2 v3] sparc32,leon: PCI patches
Message-Id: <20110602.143606.148771700669358059.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 24 May 2011 09:02:02 +0200

> I have tried to cleanup the patches as Sam/Julian suggested, I have
> added a PCIC_PCI and a LEON_PCI Kconfig setting which depend on PCI
> and (!)SPARC_LEON. Before pci_leon.h was included from pci_32.h, now
> the pci related stuff is declared inside of pci_32.h instead. The LEON
> host controller implementation specific stuff was moved into
> leon_pci.h in the same manner as the AMBA bus implementation on LEON
> in leon_amba.h.

All applied, thanks.
