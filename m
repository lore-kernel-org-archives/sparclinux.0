From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Tue, 18 Dec 2007 10:38:27 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <4767A323.7090205@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/>	<47112797.7060003@s5r6.in-berlin.de>	<47670BDF.80409@s5r6.in-berlin.de> <20071217.165032.41424988.davem@davemloft.net>
In-Reply-To: <20071217.165032.41424988.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

[As pointed out elsewhere in the thread, this is indeed about sparc64,
not sparc per se.]

David Miller wrote:
> From: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Date: Tue, 18 Dec 2007 00:53:03 +0100
> 
>> The fault happens due to dma_sync_single_for_device() which
>> drivers/firewire/fw-ohci.c calls in ar_context_add_page() when still
>> being in its pci_probe method.  I suspect that --- at least on Sparc and
>> after 2.6.22 --- it is not possible anymore to use dma_sync_* before the
>> pci_device's or device's probe was finished.
>> 
>> Would that be a bug in the Sparc platform code?  Or a bug in driver core
>> code or in PCI code?  Or am I expected to refrain from dma_sync_* calls
>> until after the probe returned?
> 
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

No, the dev argument is alright.  We use it a few lines above in the
same function in a call to dma_map_single().  The dev argument is IMO
correctly obtained here:

static int
pci_probe(struct pci_dev *dev, const struct pci_device_id *ent)
{
	...
	fw_card_initialize(&ohci->card, &ohci_driver, &dev->dev);
	...
}

void
fw_card_initialize(struct fw_card *card, const struct fw_card_driver
*driver, struct device *device)
{
	...
	card->device = device;
	...
}

So, ohci->card.device is in fact &pci_dev->dev.

Also note:
  - The very same code did not oops at this point in 2.6.22.  It only
    started doing so in 2.6.23.
  - There has been no other report of this kind for any other
    architecture yet.  I would expect e.g. the PPC64 folks to report
    bugs in our dma mappings eventually.

-----
Two footnotes:

  - Although the 2.6.22 firewire subsystem does not oops during the
pci_probe like it does in 2.6.23 and 2.6.24, it does lock up sometime
later during actual use.  However this is not surprising, as I found and
fixed some portential DMA mapping issues in the fw-sbp2 highlevel driver
sometime after 2.6.22.  But due to the pci_probe problem, the firewire
subsystem doesn't get as far on sparc64 on 2.6.23 and 2.6.24.

  - One thing which we do slightly wrong in ar_context_add_page() is that we
1.) dma-map the buffer,
2.) continue to write into the buffer from the CPU,
3.) then sync it for the device.
I let the reporter try a patch which inserted a
dma_sync_single_for_cpu() right after the dma_map_single() in order to
be clearly entitled to access the buffer by the CPU, but that didn't fix it.

-- 
Stefan Richter
-===-=-== =-- =--=-
http://arcgraph.de/sr/
