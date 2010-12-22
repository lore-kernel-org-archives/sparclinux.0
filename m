From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 22 Dec 2010 12:27:45 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <4D11FBCF.1060305@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Thu, 16 Dec 2010 15:24:02 +0100
>
>  
>
>>Why is IRQ15, the non-maskable IRQ, used for cross calls? Would it not
>>be safer to use IRQ14?
>>
>>Since IRQ15 is non-maskable it will even interrupt spin_lock_irqsave()
>>protected reqions. I assume it is safe as long as the cross call
>>function run in IRQ context does not try to take the same spinlock,
>>for that would create a dead lock I believe. For example atomic_add()
>>on SPARC32 below is implemented using one of four global spinlocks,
>>does that mean that we can not use atomic functions at all from within
>>a cross call function?
>>    
>>
>
>We don't want operations like TLB and cache flushes to be blocked
>by IRQ disabling.
>
>For other operations, we should reschedule it to a software interrupt
>at a lower level than 15, but nobody has done the work to implement
>this yet.
>
>
>  
>
Thank you for your answer.

I will try to create a patch for the atomic layer for SMP LEON systems 
since they have the CASA instruction.

Thanks,
Daniel

