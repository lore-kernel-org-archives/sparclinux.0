From: David Miller <davem@davemloft.net>
Date: Sun, 25 Jun 2006 20:44:35 +0000
Subject: Re: Sparc32 Netboot - Build Errors - 2.6.17.1
Message-Id: <20060625.134435.104035826.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <449ED79C.3030101@jg555.com>
In-Reply-To: <449ED79C.3030101@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Sun, 25 Jun 2006 11:36:12 -0700

> Hey all trying to make a sparc netboot image for 32 bit. Ran the make 
> tftpboot.img and got the following errors. This is just a 10 lines or so 
> of the error, there are about 10 pages of errors. Before I attempted to 
> fix, anyone already talked this one?

The PCI iomap infrastructure was simply never written for
sparc32, simply copying over the sparc64 implementation with
minor tweaks is good enough.

But trying to build drivers such as the sym2 scsi driver is
quite questionable on sparc32.

sparc32 PCI capable machines are so incredibly limited in scope
and only a tiny handful of PCI drivers will ever be relevant
on those machines, and sym2 is not on that list.  They don't have
PCI slots and you therefore can't stick arbitrary PCI cards in
them.

So adding the pci_iomap stuff just to satisfy the sym2 build on
sparc32 is on the dubious side.
