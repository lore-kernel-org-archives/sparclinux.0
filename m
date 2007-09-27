From: David Miller <davem@davemloft.net>
Date: Thu, 27 Sep 2007 20:15:49 +0000
Subject: Re: [PATCH] Add irqflags.h to sparc32 and use it from generic code.
Message-Id: <20070927.131549.38080418.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Fri, 24 Aug 2007 19:56:30 -0400

> Added asm-sparc/irqflags.h and moved irq related code from system.h to it.
> Renamed local_irq functions to raw_local_irq in irq.c.
> Modified system.h to include linux/irqflags.h which includes asm/irqflags.h.
> Added TRACE_IRQFLAGS_SUPPORT to Kconfig.debug.
> 
> This is the first step in adding IRQ-flags state tracing as outlined in
> Documentation/irqflags-tracing.txt.  These changes should be harmless
> because they just move things around and rename them.
> 
> The next step is making the lowlevel entry code modifications which
> to be honest are beyond my capabilities at this point.
> 
> Boot tested on an ss20 running an SMP kernel.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

I've queued this up for 2.6.24, thanks!
