From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 06:18:46 +0000
Subject: Re: generic IRQs for sparc32
Message-Id: <20080902.231846.253015672.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080902.010944.25269623.davem@davemloft.net>
In-Reply-To: <20080902.010944.25269623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Tue, 02 Sep 2008 23:48:39 -0400

> David Miller wrote:
> > Here is a debugging patch against sparc-next-2.6 that might help debug
> > this:
> >
> >   
> I recompiled a new kernel from scratch starting out with a default config.
> I had to compile for size so it fit in memory.  I'm booting off a SunSwift
> sbus card if that helps.
> 
> ESP: Mapped regs at fd016000
> ESP: In esp_get_revision(), regs at fd016000
> ESP: In esp_get_revision(), about to read ESP_CFG2, regs now at fd016000
> Unable to handle kernel paging request at virtual address fd016000

It's even more mysterious now. :(

A write to the register at that address works, but a read fails.

Strange :-/
