From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2007 03:03:54 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <20071217.190354.200414687.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47112797.7060003@s5r6.in-berlin.de>
	<47670BDF.80409@s5r6.in-berlin.de>
	<Pine.LNX.4.60.0712180255450.10484@mailgate.netunix.com>
In-Reply-To: <Pine.LNX.4.60.0712180255450.10484@mailgate.netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: crn@netunix.com
Cc: stefanr@s5r6.in-berlin.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

From: Chris Newport <crn@netunix.com>
Date: Tue, 18 Dec 2007 02:58:29 +0000 (GMT)

> On Tue, 18 Dec 2007, Stefan Richter wrote:
> 
> > It's a 100% reproducible oops on Sparc (with FireWire controller) for
> > 2.6.23 and 2.6.24 kernels, but not 2.6.22.  The reporter confirmed that
> > the bug also happens
> 
> How do you achieve a sparc system with firewire ?
> AFAIK there is no SBUS firewire card.

He means sparc64, which have PCI firewire onboard many
systems.
