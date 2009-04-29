From: David Miller <davem@davemloft.net>
Date: Wed, 29 Apr 2009 22:04:08 +0000
Subject: Re: interrupt problem with multiple vnet devices
Message-Id: <20090429.150408.80765835.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200904292141.n3TLfmn16267@elf.torek.net>
In-Reply-To: <200904292141.n3TLfmn16267@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Wed, 29 Apr 2009 15:41:48 -0600

> When configured this way, Linux does not boot properly, as
> it winds up perpetually servicing vnet interrupts.
> 
> The fix he sent me is below, but I am very suspicious about
> this as it essentially removes the linked-list of buckets
> that the irq code runs.
> 
> I think the real problem is that, when multiple vnet devices are
> on the same vswitch, the interrupts get re-enabled "too soon" so
> that the sun4v_ivec.S code ends up making the linked list become
> circular (by queueing work for a vnet cookie that is already queued).

Older versions of the hypervisor have a bug in it's LDOM code
wherein interrupt vectors from virtual devices can be sent
twice before an intervening CLEAR event.

But we should be working around that properly.  This check in
sun4v_irq_eoi() and sun4v_virq_eoi():

	if (unlikely(desc->status & (IRQ_DISABLED|IRQ_INPROGRESS)))
		return;

Should prevent any problems due to that bug.
