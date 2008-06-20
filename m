From: Mikulas Patocka <mpatocka@redhat.com>
Date: Fri, 20 Jun 2008 15:47:12 +0000
Subject: Re: stack overflow on Sparc64
Message-Id: <Pine.LNX.4.64.0806201143110.8789@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806171954060.2560@engineering.redhat.com>
 <20080617.210159.141238856.davem@davemloft.net>
In-Reply-To: <20080617.210159.141238856.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, agk@redhat.com

> It could still be improved a lot, however.
>
>> Long-term consideration: Is it possible to implement interrupt stacks on
>> sparc64? Functions on sparc eat stack much more aggressively than on other
>> architectures (minimum stack size for a function is 192 bytes).
>
> I had a patch but at the time I wrote it (several years ago) I
> couldn't make it stable enough to put mainline, I may resurrect it.
>
> I just did a quick scan and I can't find the last copy I had, and
> things have changed enough that I'd probably work from scratch
> anyways.
>
> But the level of recursion possible by the current device layer is
> excessive and needs to be curtained irrespective of these generic
> wakeup and sparc64 interrupt stack issues.

I took another few traces (to track the whole stack content) and there is 
another problem: nested interrupts. Does Sparc64 limit them somehow?

sys_call_table
timer_interrupt
irq_exit
do_softirq
__do_softirq
run_timer_softirq
_spin_unlock
sys_call_table
handler_irq
handler_fasteoi_irq
handle_irq_event
ide_intr
ide_dma_intr
task_end_request
ide_end_request
__ide_end_request
...

Mikulas
