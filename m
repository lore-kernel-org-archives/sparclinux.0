From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 21:44:24 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080620.144424.168785883.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806201707270.8990@engineering.redhat.com>
	<20080620.142034.30884440.davem@davemloft.net>
	<Pine.LNX.4.64.0806201723120.14221@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806201723120.14221@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 17:25:26 -0400 (EDT)

> On Fri, 20 Jun 2008, David Miller wrote:
> 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Date: Fri, 20 Jun 2008 17:14:41 -0400 (EDT)
> >
> > It means i386 and every other platform potentially has the same exact
> > problem.
> >
> > What point wrt. sparc64 are you trying to make here? :-)
> 
> The difference is that i386 takes minimum 4 bytes per stack frame and 
> sparc64 192 bytes per stack frame. So this problem will kill sparc64 
> sooner.
> 
> But yes, it is general problem and should be solved in arch-independent 
> code.

I agree on both counts.  Although I'm curious what the average stack
frame sizes look like on x86_64 and i386, and also how this area
appears on powerpc.

One mitigating factor on sparc64 is that typically when there are lots
of devices with interrupts there are also lots of cpus, and we evenly
distribute the IRQ targetting amongst the available cpus on sparc64.

This is probably why, in practice, these problems tend to not surface
often.

In any event, with the work you've accomplished and my implementation
of IRQ stacks for sparc64 we should be able to get things in much
better shape.
