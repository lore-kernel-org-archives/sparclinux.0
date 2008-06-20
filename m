From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 21:14:41 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806201707270.8990@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806171954060.2560@engineering.redhat.com>
 <20080617.210159.141238856.davem@davemloft.net>
 <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
 <20080620.102601.06998427.davem@davemloft.net>
In-Reply-To: <20080620.102601.06998427.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com



On Fri, 20 Jun 2008, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Fri, 20 Jun 2008 11:47:12 -0400 (EDT)
>
>> I took another few traces (to track the whole stack content) and there is
>> another problem: nested interrupts. Does Sparc64 limit them somehow?
>
> Two levels should be the deepest you will ever see, and this is
> equivalent to what you get on other platforms.

Are you sure? What about this:
ide-io.c:ide_intr
         if (drive->unmask)
                 local_irq_enable_in_hardirq();

or this:
kernel/irq/handle.c:handle_IRQ_event
         if (!(action->flags & IRQF_DISABLED))
                 local_irq_enable_in_hardirq();


--- how is number of nested interrupts here supposed to be limited?

If these things are not limited, you get at most as many nested handlers 
as there are hardware interrupts, which means crash.

Mikulas

> That path occurs when softirq processing re-enabled HW interrupts when
> returning from the top-level interrupt.
