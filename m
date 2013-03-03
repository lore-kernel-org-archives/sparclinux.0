From: David Miller <davem@davemloft.net>
Date: Sun, 03 Mar 2013 06:36:38 +0000
Subject: Re: [PATCH] sparc,leon: fix GRPCI2 device0 PCI config space access
Message-Id: <20130303.013638.1049506509351650677.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 28 Feb 2013 15:31:55 +0100

> bus=0 slot=0 (device0) was used internally by the PCI host driver
> to access the PCI host controller itself, however that had the
> effect that PCI device0 was never accessible, which is wrong
> when the motherboard has connected PCI AD16 signal to a slot.
> A special case for accessing the PCI host controller itself is
> added with this patch, by setting bus to TGT.
> 
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Applied, thanks.
