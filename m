From: David Miller <davem@davemloft.net>
Date: Thu, 30 Apr 2009 00:18:53 +0000
Subject: Re: interrupt problem with multiple vnet devices
Message-Id: <20090429.171853.16961916.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200904292141.n3TLfmn16267@elf.torek.net>
In-Reply-To: <200904292141.n3TLfmn16267@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Wed, 29 Apr 2009 18:06:57 -0600

> Yes, this one is in.  I did (and still do) suspect a hypervisor
> bug.  I think in this case the problem is that this test is not
> sufficent for the "two vnets on one vswitch" case, though,
> because this results in the desc->status not having
> IRQ_INPROGRESS set on the "other" vnet that gets a double
> interrupt.

You can know if it's this hypervisor bug by simply updating
your hypervisor to the latest version available.

> I'm also wondering now if it has something to do with the code we
> added that attempts to redistribute interrupts, so that in the case
> of a double interrupt, the second one goes to a different CPU
> than the CPU already handling the first one.  Although we
> should still see IRQ_INPROGRESS then...

If you're making local changes on that scale, it's irresponsible
to make mention of them when reporting a bug you want this
list to look at :-(
