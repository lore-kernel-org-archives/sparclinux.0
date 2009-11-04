From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2009 16:36:02 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091104.083602.123028127.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 04 Nov 2009 16:50:36 +0100

> Yeah I know. The leon3_dma_ops are copied from the pci32_dma_ops.
> I think only unmap_page was added basically. Why is there no
> pci32_unmap_page by the way? Maybe I can just add that and use
> them as is.

Basically because they are buggy and don't get much usage.

They are the worst thing to use as a model for your purposes
since that code gets the least amount of testing,  the SBUS
ones on the other hand get pretty much all of the sparc32
testing.

> The SBUS routines look quite different though. I will use the
> pci32_dma_ops.

I suggested the SBUS ones because they inherit the OpenFirmware
device node name into the resource.  They have also been cleaned
up substantially, the PCI ones are very messy still.

