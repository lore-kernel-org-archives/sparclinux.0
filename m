From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2007 00:50:32 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <20071217.165032.41424988.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/>
	<47112797.7060003@s5r6.in-berlin.de>
	<47670BDF.80409@s5r6.in-berlin.de>
In-Reply-To: <47670BDF.80409@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stefanr@s5r6.in-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Tue, 18 Dec 2007 00:53:03 +0100

> The fault happens due to dma_sync_single_for_device() which
> drivers/firewire/fw-ohci.c calls in ar_context_add_page() when still
> being in its pci_probe method.  I suspect that --- at least on Sparc and
> after 2.6.22 --- it is not possible anymore to use dma_sync_* before the
> pci_device's or device's probe was finished.
> 
> Would that be a bug in the Sparc platform code?  Or a bug in driver core
> code or in PCI code?  Or am I expected to refrain from dma_sync_* calls
> until after the probe returned?

The problem is likely what device struct you are passing to
dma_sync_single_for_device(), it has to be a real pci_dev or similar
that has it's dev_archdata properly initialized.

I bet dev_archdata in whatever "struct device" is being passed in has
a NULL iommu pointer or something like that.

Oh yeah, I see what you're doing, that won't work, please pass in
the correct device struct pointer.  Please pass in the &pci_dev->dev
not this ohci->card.device thing.
