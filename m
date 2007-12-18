From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2007 22:29:56 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <20071218.142956.26529678.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <47670BDF.80409@s5r6.in-berlin.de>
	<20071217.165032.41424988.davem@davemloft.net>
	<4767A323.7090205@s5r6.in-berlin.de>
In-Reply-To: <4767A323.7090205@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stefanr@s5r6.in-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Tue, 18 Dec 2007 11:38:27 +0100

> Also note:
>   - The very same code did not oops at this point in 2.6.22.  It only
>     started doing so in 2.6.23.

2.6.23 is when the sparc64 IOMMU code started relying upon
the dev_archdata bits being correct.
