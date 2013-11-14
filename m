From: David Miller <davem@davemloft.net>
Date: Thu, 14 Nov 2013 22:55:14 +0000
Subject: Re: [PATCH] sparc: PCI: Fix incorrect address calculation of PCI Bridge windows on Simba-bridges
Message-Id: <20131114.175514.1577904943002318814.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 18 Oct 2013 22:28:29 +0200 (CEST)

> The SIMBA APB Bridges lacks the 'ranges' of-property describing the 
> PCI I/O and memory areas located beneath the bridge. Faking this 
> information has been performed by reading range registers in the 
> APB bridge, and calculating the corresponding areas.
> 
> In commit 01f94c4a6ced476ce69b895426fc29bfc48c69bd 
> ("Fix sabre pci controllers with new probing scheme.") a bug was 
> introduced into this calculation, causing the PCI memory areas 
> to be calculated incorrectly: The shift size was set to be 
> identical for I/O and MEM ranges, which is incorrect.
> 
> This patch set the shift size of the MEM range back to the 
> value used before 01f94c4a6ced476ce69b895426fc29bfc48c69bd.
> 
> Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>

Applied and queued up for -stable, thanks for fixing this.
