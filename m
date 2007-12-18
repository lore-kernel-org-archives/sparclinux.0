From: David Miller <davem@davemloft.net>
Date: Tue, 18 Dec 2007 22:30:26 +0000
Subject: Re: No dma_sync_* during pci_probe? (Sparc, post 2.6.22 regression)
Message-Id: <20071218.143026.78772130.davem@davemloft.net>
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

>   - There has been no other report of this kind for any other
>     architecture yet.  I would expect e.g. the PPC64 folks to report
>     bugs in our dma mappings eventually.

Irrelevant fact, powerpc handles it's dev_archdata differently
from sparc64.
