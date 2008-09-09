From: David Miller <davem@davemloft.net>
Date: Tue, 09 Sep 2008 19:57:14 +0000
Subject: Re: [PATCH] prevent sparc64 from invoking irq handlers on offline
Message-Id: <20080909.125714.35737132.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903154217.GA6807@linux.vnet.ibm.com>
	<20080908.171708.43575256.davem@davemloft.net>
	<48C6C520.5070103@colorfullife.com>
In-Reply-To: <48C6C520.5070103@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: manfred@colorfullife.com
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, akpm@linux-foundation.org

From: Manfred Spraul <manfred@colorfullife.com>
Date: Tue, 09 Sep 2008 20:49:04 +0200

> David Miller wrote:
> > And IPI handler runs in HW irq context, therefore such an IPI-creates-an-IPI
> > should not be allowed, at least not directly.
> >
> > Actually the restriction seems to be that an IPI cannot be sent when
> > "irqs_disabled()", hmmm...
> >
> >   
> Does this apply to smp_send_reschedule() as well?
> A [rare] codepath in the current rcu code does to trigger quiescent states on remote cpus.

It does work on sparc64.  Such an IPI doesn't do a wait so there would
be no deadlock issues either.

