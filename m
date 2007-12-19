From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Dec 2007 21:07:20 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <1198098440.31714.0.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/>
	 <47112797.7060003@s5r6.in-berlin.de> <47670BDF.80409@s5r6.in-berlin.de>
	 <20071217.165032.41424988.davem@davemloft.net>
In-Reply-To: <20071217.165032.41424988.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: stefanr@s5r6.in-berlin.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net


On Mon, 2007-12-17 at 16:50 -0800, David Miller wrote:

> The problem is likely what device struct you are passing to
> dma_sync_single_for_device(), it has to be a real pci_dev or similar
> that has it's dev_archdata properly initialized.
> 
> I bet dev_archdata in whatever "struct device" is being passed in has
> a NULL iommu pointer or something like that.
> 
> Oh yeah, I see what you're doing, that won't work, please pass in
> the correct device struct pointer.  Please pass in the &pci_dev->dev
> not this ohci->card.device thing.

Yup, this would crash on powerpc 64 bits as well for the same reason.

Ben.


