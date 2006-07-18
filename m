From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 04:53:04 +0000
Subject: Re: sparc32 git tree
Message-Id: <20060717.215304.124870932.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 17 Jul 2006 22:03:17 -0700 (PDT)

> with the sbus happy I've been following the serial port saga, 
> (the <#4> looks scary)
> 
> zs@1,200000: ttyS0 at MMIO 0x200000 (irq = 12) is a zs
> Console: ttyS0 (SunZilog zs0)
> zs@1,200000: ttyS1 at MMIO 0x200004 (irq = 12) is a zs
> Program terminated
> Type  help  for more information
> <#4> ok
> 
> the result persists despite patches including the last delayed
> initialization you sent. sorry.

It's dumping into the firmware on cpu #4.

Why don't you try a non-SMP kernel while we work out these
device level problems?  This crash here might be related
to the erroneous SLAB patch you put in there.
