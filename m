From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 05 Jan 2011 10:20:19 +0000
Subject: Re: LEON SMP
Message-Id: <4D2445E3.5070901@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CC714EC.2050001@gaisler.com>
In-Reply-To: <4CC714EC.2050001@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Hellstrom wrote:

> David Miller wrote:
>
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> Date: Tue, 26 Oct 2010 19:50:36 +0200
>>
>>  
>>
>>> The LEON do not have internal timers as some CPUs does, it has
>>> one/multiple General Purpose TIMERs on the Processor Local Bus. On
>>> single-CPU/SMP systems the first Timer is used for System Clock, and
>>> on SMP systems timer two is also used to generate a simultaneous IRQ
>>> on all CPUs for profiling etc. (leon_percpu_timer_interrupt()). On the
>>> quad-core SMP system I discovered that since the per-cpu timer is
>>> generated at the same frequency (and almost simultaneously) as the
>>> System Clock Timer. I have made a patch that uses only one Timer for
>>> SMP systems, the Timer generates a per-cpu tick as before, however on
>>> CPU0 the handler_irq() is also called after profiling has been done,
>>> this is to handle the System Clock Tick. I seems to work successfully,
>>> and it saves me HZ interrupts per second and a Timer instance. What is
>>> you opinion about that? Is it possible to use the same timer for
>>> System Clock and for per-cpu profiling etc.?
>>>   
>>
>>
>> You only need to generate one timer interrupt per-cpu, and the kernel
>> generically decides to run the global timer actions (jiffies update,
>> etc.) on a choosen cpu, transparently, in the per-cpu periodic timer
>> code.
>>
>>  
>>
> That is interesting, I didn't even think about that. So then I can 
> even remove the extra call to handler_irq() from within the per-cpu 
> timer IRQ handler, and I will probably have to fix some code in the 
> System Clock Timer setup as well. I will have to investigate this 
> further then.
>
> So actually it is bad to make 5 timer IRQs per tick on a quad core 
> system, and one of them is calling handler_irq. But I can see that the 
> system clock is progressing in the correct pace, unless my watch is 
> bad :) I will get back to this issue later on.


I have started working on this timer patch again...

I tried looking a sun4d and sun4m to get an example of how to implement 
this in a better way, however they seem to implement the per-cpu ticker 
using hardcoded IRQ number 14 and a custom trap handler for the per-cpu 
timer ticker (see bottom of kernel/sun4m_irq.c: sun4m_init_timers()). 
The system clock is implemented using the time-tick at IRQ10. I'm not 
sure why the time-tick timer is used at all, unless the hardware 
requires it (the per-cpu timer perhaps can not get the time or limits HZ).

The LEON port mimics this behaviour, however the LEON CPU does not have 
a "per-cpu" timer. The new patch uses only one timer to generate one IRQ 
on each CPU simultaneously, and only CPU0 will call handler_irq() to 
handle the standard system clock tick interrupt handler. Please see the 
patch I will submit to the list soon as reference.

This patch is bad if one would want the system clock tick to run at a 
different rate than the profiling per-cpu ticks, or if the system clock 
tick is turned off/on as it will affect the profiling, however I have 
not seen code indicating such a behaviour.

Thanks for applying the other patches,

Daniel
