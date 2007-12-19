From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Dec 2007 21:08:13 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <1198098493.31714.2.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-9160-4803@http.bugzilla.kernel.org/>
	 <47112797.7060003@s5r6.in-berlin.de>	<47670BDF.80409@s5r6.in-berlin.de>
	 <20071217.165032.41424988.davem@davemloft.net>
	 <4767A323.7090205@s5r6.in-berlin.de>
In-Reply-To: <4767A323.7090205@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@suse.de, krh@bitplanet.net, linux1394-devel@lists.sourceforge.net


On Tue, 2007-12-18 at 11:38 +0100, Stefan Richter wrote:
> So, ohci->card.device is in fact &pci_dev->dev.
> 
> Also note:
>   - The very same code did not oops at this point in 2.6.22.  It only
>     started doing so in 2.6.23.
>   - There has been no other report of this kind for any other
>     architecture yet.  I would expect e.g. the PPC64 folks to report
>     bugs in our dma mappings eventually.

Ignore my previous message... if you are indeed passing &pci_dev->dev,
it should work.

Ben.


