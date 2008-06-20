From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 21:20:34 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <20080620.142034.30884440.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
	<20080620.102601.06998427.davem@davemloft.net>
	<Pine.LNX.4.64.0806201707270.8990@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806201707270.8990@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 17:14:41 -0400 (EDT)

> Are you sure? What about this:
> ide-io.c:ide_intr
>          if (drive->unmask)
>                  local_irq_enable_in_hardirq();
> 
> or this:
> kernel/irq/handle.c:handle_IRQ_event
>          if (!(action->flags & IRQF_DISABLED))
>                  local_irq_enable_in_hardirq();
> 
> 
> --- how is number of nested interrupts here supposed to be limited?
> 
> If these things are not limited, you get at most as many nested handlers 
> as there are hardware interrupts, which means crash.

It means i386 and every other platform potentially has the same exact
problem.

What point wrt. sparc64 are you trying to make here? :-)


