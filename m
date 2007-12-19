From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2007 23:06:22 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <20071219.150622.158580703.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4767A323.7090205@s5r6.in-berlin.de>
	<20071218.142956.26529678.davem@davemloft.net>
	<476947C1.2010405@s5r6.in-berlin.de>
In-Reply-To: <476947C1.2010405@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stefanr@s5r6.in-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Wed, 19 Dec 2007 17:33:05 +0100

> drivers/firewire/fw_ohci.c needs them for dma_map_single() +
> dma_sync_single_for_device() in the pci_driver.probe(), sometime after
> it called pci_enable_device(), before finishing the probe.

I'll take a look at this and try to figure out exactly
what might be going wrong.

The dev_archdata should be fully setup at this time.
