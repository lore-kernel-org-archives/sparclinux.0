From: David Miller <davem@davemloft.net>
Date: Sat, 12 Sep 2009 00:18:18 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090911.171818.149360025.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 01:04:16 +0200

> In my case, I didn't seem to have any problems when I just turned it off
> in pcr_arch_init().

Yeah, that's usually what cures this.

> I added some poor man's debugging and got:
> 
> calling  pcr_arch_init+0x0/0x13c @ 1
> Most of pcr_arch_init() is done, going for nmi_init()...
> This is start_watchdog(), writing picl_value(nmi_hz)=-17214228922368000 into pic...
> This is start_watchdog(), writing picl_value(nmi_hz)=-17214228922368000 into pic...
> This
> 
> That last line was a printk() right after the on_each_cpu(start_watchdog,
> NULL, 1); call. Again exactly four characters into the printk.

Yeah, that's when it's going to take the first NMI.

> Could this consistency be of any significance, maybe the printk
> functions are somehow problematic... so I fiddled with them some more, but
> it looks more like they just waste time until something kicks in and somehow
> kills the kernel without a trace. That doesn't sound like perfctr_irq() and
> die_nmi(), but then I don't really any idea how exactly all that works :)

You can't put debugging print statements in the NMI irq handlers like
perfctr_irq(), that will almost always cause a lockup or crash.
