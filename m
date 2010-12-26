From: Jiri Gaisler <jiri@gaisler.com>
Date: Sun, 26 Dec 2010 14:44:01 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <4D1754B1.2080406@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Kjetil Oftedal wrote:
> On 22 December 2010 23:28, David Miller <davem@davemloft.net> wrote:
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> Date: Wed, 22 Dec 2010 14:23:27 +0100
>>
>>> I will try to create a patch for the atomic layer for SMP LEON systems
>>> since they have the CASA instruction.
>>
>> But see my other posting, you still have to fix the irq15 problem.
>>
>> Merely switching to CASA doesn't mean you don't still have a problem
>> because spin_lock_irqsave() and other similar pieces of code expect
>> they will not be interrupted by smp_call_function() calls.
> 
> Was SPARC32 SMP in 2.4 also implemented using IRQ15/NMI ?


Don't know about 2.4, but the interesting thing is that sparc32 SMP
does work on 2.6.21.1 and seems to get broken somewhere between 2.6.23
and 2.6.24. So something happened with the irq15 handler such that
it now tries to grab a taken spin-lock and the system dead-locks.
Could also be that the problem has been there all the time, but
not triggered in the pre-2.6.24 kernels ...

I think we first need to understand what root cause is, so that
we fix the right thing. I have confidence that Daniel and Konrad
will hash this out somehow during the coming months...

Jiri.

> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
