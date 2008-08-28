From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:23:09 +0000
Subject: [PATCH 0/49]: Kill SBUS device layer.
Message-Id: <20080827.212309.29520193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


[ Stephen, I'm only going to CC: on this email not the
  rest of the patch bomb, as I figured you'd have some
  at least cursory interest in this work.  Thanks. ]

A long time ago in a galaxy far far away we had no generic
device layer and generic OF device driver infrastructure.
Thus I created a bunch of ad-hoc interfaces and datastructures
to support SBUS device drivers.

Those days are gone but the rotting corpose of the SBUS
device layer stays with us.  It's time to end that :)

This patch series follows roughly the following sequence:

1) Kill ad-hoc SBUS DVMA driver, only ESP and SUNLANCE
   use this and they can do so with local code.

2) Make dma_map_*() work for SBUS devices.

3) Make SBUS drivers use dma_*() instead of sbus_*().

4) Convert SBUS drivers to use OF device driver style
   probing.  This is probably the bulk of the patch
   series.

5) Add local IOMMU controller initialization and a
   OF node propagator helper routine so that the
   device->archdata.FOO fields get set on all child
   devices of a given bus where an IOMMU is discovered
   setup.

6) rm arch/sparc/include/sbus*.h drivers/sbus/*.c

7) Profit.

All of my testing was done on an Ultra2 with ESP, SUNHME, CS4231
audio, and an SBUS Flash device.

I plan to do the same for the EBUS bus layer as well.
The only tricky case there is the CS4231 sound driver
as it supports both EBUS and SBUS devices, but I have
a plan to sort that out cleanly.

This work will also make converting sparc32 over to
the generic IRQ layer much easier as well.

Anyways, after this sits for review for a day or two
I'll push this into the sparc-next-2.6 tree.

Enjoy.
