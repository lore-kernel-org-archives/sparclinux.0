From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 03 Jan 2011 14:19:52 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <4D21E80D.8040009@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

crn@pop3.netunix.com wrote:

>>From: Kjetil Oftedal <oftedal@gmail.com>
>>Date: Sun, 26 Dec 2010 13:34:56 +0100
>>
>>    
>>
>>>On 22 December 2010 23:28, David Miller <davem@davemloft.net> wrote:
>>>      
>>>
>>>>From: Daniel Hellstrom <daniel@gaisler.com>
>>>>Date: Wed, 22 Dec 2010 14:23:27 +0100
>>>>
>>>>        
>>>>
>>>>>I will try to create a patch for the atomic layer for SMP LEON systems
>>>>>since they have the CASA instruction.
>>>>>          
>>>>>
>>>>But see my other posting, you still have to fix the irq15 problem.
>>>>
>>>>Merely switching to CASA doesn't mean you don't still have a problem
>>>>because spin_lock_irqsave() and other similar pieces of code expect
>>>>they will not be interrupted by smp_call_function() calls.
>>>>        
>>>>
>>>Was SPARC32 SMP in 2.4 also implemented using IRQ15/NMI ?
>>>      
>>>
>>Yes, it's essentially always had this problem.
>>
>>It was less important back then because smp_call_function() was
>>really not used much by generic code.  Now it's used everywhere.
>>    
>>
>
>Maybe this could be why I could never get a sun4d SS1000E with 8
>processors to stay up for more than a few minutes without locking solid.
>OTOH it could be irrelevant.
>  
>
It might very well be due to this problem. The boot up process and much 
other stuff work every time, however after some minutes of more CPU-load 
the system tend to hang. That is the behaviour which we have seen so far.

Daniel

>
>--
>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>  
>

