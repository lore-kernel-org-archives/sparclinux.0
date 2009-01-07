From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 07 Jan 2009 13:02:13 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090107130213.GB3529@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105135508.GB4190@elte.hu> <20090105.123734.137888898.davem@davemloft.net> <20090106125704.GC20407@elte.hu> <20090106.082913.97432854.davem@davemloft.net>
In-Reply-To: <20090106.082913.97432854.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sam@ravnborg.org, kosaki.motohiro@jp.fujitsu.com, yinghai@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Tue, 6 Jan 2009 13:57:04 +0100
> 
> > Sparc32 on the other hand had a clean IRQ layer long before x86 found its 
> > desire for a clean genirq layer - so genirq is a nuisance for Sparc32 at 
> > best and it deserves none of the not nice actions. What i am hoping for is 
> > that perhaps the Sparc unification changed that equation.
> 
> Not really, the unificiation didn't change much in this area. [...]

Yeah, i mean - "changed the equation" psychologically, the same way it did 
it on x86.

There's now two files close to each other in the namespace:

 earth4:~/tip> ls -l arch/sparc/kernel/irq*.c
 -rw-rw-r-- 1 mingo mingo 16122 2009-01-07 13:50 arch/sparc/kernel/irq_32.c
 -rw-rw-r-- 1 mingo mingo 26556 2009-01-07 12:34 arch/sparc/kernel/irq_64.c

Each of them crying out loud to be unified. Every time you open irq_64.c 
you'll think "why that ugly _64.c postfix, shouldnt this be irq.c 
instead?" ;-)

That kind of gentle pressure to unify comes straight from the fact that 
there's _32.c and _64.c postfixes around and the postfixes mess up command 
completion when those files are opened, so we notice the non-unified-ness 
again and again.

At least this was what drove many of the x86 unifications. (Mind you, 
irq_32/irq_64.c is still not fully unified on x86 ;)

> [...] That doesn't change the fact that I do intend to genirq'ify 
> sparc32 some time soon. :-)

Cool! :-)

	Ingo
