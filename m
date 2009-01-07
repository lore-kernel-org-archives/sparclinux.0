From: David Miller <davem@davemloft.net>
Date: Wed, 07 Jan 2009 21:08:36 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090107.130836.128453234.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106125704.GC20407@elte.hu>
	<20090106.082913.97432854.davem@davemloft.net>
	<20090107130213.GB3529@elte.hu>
In-Reply-To: <20090107130213.GB3529@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: sam@ravnborg.org, kosaki.motohiro@jp.fujitsu.com, yinghai@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de

From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 7 Jan 2009 14:02:13 +0100

> Each of them crying out loud to be unified. Every time you open irq_64.c 
> you'll think "why that ugly _64.c postfix, shouldnt this be irq.c 
> instead?" ;-)

Doesn't work very well when you have sun4c_irq.c, sun4m_irq.c,
and sun4d_irq.c sitting right next to them.

Sparc32 is miles away from sparc64 in terms of being easy to make
use generic IRQs.

It's a lot of hard work and testing of which I have to rely upon
helpers to perform.  The sparc arch directory consolidation in no way
makes me want to do that work any more or any less, no matter how many
times I open up irq_64.c :-)

