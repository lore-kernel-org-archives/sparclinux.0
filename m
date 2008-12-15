From: David Miller <davem@davemloft.net>
Date: Mon, 15 Dec 2008 22:52:46 +0000
Subject: Re: [RFC PATCH] use sparc64 version of of_device.c
Message-Id: <20081215.145246.180504639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4945AE56.2040503@earthlink.net>
In-Reply-To: <4945AE56.2040503@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 15 Dec 2008 19:52:41 +0100

> Sorry to be negative here. But this hurt readability too much.
> I will try to give some specific comments below.
> 
> That said I really like to see these two files merged.
> When merged the iffedery really show the minimal differences that
> is actually present.
> 
> Consider doing this as two steps.
> First steps prepare of_device_64.c for the unification - which in some
> cases may add otherwise pointless changes (such as moving a function
> or a variable definition.
> 
> And the second step where you do the unification.

That's my feeling as well, it needs treatment similar to
how prom.c was handled.

However in this case I think more unification is possible.

All of those OF device tree matching things can be merged
and compiled in both cases.  For example, keeping the
"pcie" string test in there in generic not-ifdeffed code
on sparc32 is fine because there will never be PCI-E busses
on sparc32.

Yes, it will eat some space on sparc32 but the alternative
is code duplication or messy ifdefs.

The truly different aspects which need platform specific code
is the resource layout and ioremap handling.  On sparc32
we store some of the I/O physical address in the resource
flags so that the resource start and end can stay 32-bit
(sun4m and sun4d have 36-bit physical addresses).

I may take a stab at this work, but feel free to beat me to
it :-)

