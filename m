From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 28 Oct 2004 00:55:24 +0000
Subject: Re: Would a JTAG port help with sun4d SMP work?
Message-Id: <20041027175524.1ec2f579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <b476569a041027060861767e78@mail.gmail.com>
In-Reply-To: <b476569a041027060861767e78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 27 Oct 2004 10:56:12 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> The use of the JTAG would allow rather immediate and enormous advances
> if we had any notion of how to use it. I suspect this is not an entirely
> uncommon state of affairs, as I've heard that e.g. Exy00's all have open
> JTAG ports, none of which we have any notion of how to use AFAIK.

THe Ex000 JTAG's are driven by the registers mapped by
the arch/sparc64/kernel/central.c driver code.

The specific registers are defined in asm-sparc64/fhc.h

But that's where the information stops, sorry :-)

One thing I do remember is that only one board can be
declared as the JTAG master and do chain scans.

Each board type (CPU+MEM, SBUS, PCI, etc.) has different
layout and meanings of the scan chains.

You actually have to use this stuff to hotplug boards.  OBP
is supposed to take care of it via special OBP prom calls but
some of those are buggy so you have to jumpstart the board
by hand using JTAG commands.

I would not be surprised if the sun4d JTAG programming is similar.
The UltraSPARC main bus, interrupt, streaming cache, and IOMMU
architecture is largely derived from the sun4d stuff.
