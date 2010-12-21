From: Jiri Gaisler <jiri@gaisler.com>
Date: Tue, 21 Dec 2010 22:44:44 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <4D112DDC.6050408@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We are thinking of switching the LEON port to use CASA (compare and swap),
just like in the sparc64 port. Most newer leon3/4 processors implement CASA,
even if the instruction belongs to sparc V9 and not V8. Would a patch like
that be accepted (for the LEON port only)? This will not fix the SMP for
general sparc32 (which really is broken), but it would fix it for LEON.

Jiri.

David Miller wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
> Date: Thu, 16 Dec 2010 15:24:02 +0100
> 
>> Why is IRQ15, the non-maskable IRQ, used for cross calls? Would it not
>> be safer to use IRQ14?
>>
>> Since IRQ15 is non-maskable it will even interrupt spin_lock_irqsave()
>> protected reqions. I assume it is safe as long as the cross call
>> function run in IRQ context does not try to take the same spinlock,
>> for that would create a dead lock I believe. For example atomic_add()
>> on SPARC32 below is implemented using one of four global spinlocks,
>> does that mean that we can not use atomic functions at all from within
>> a cross call function?
> 
> We don't want operations like TLB and cache flushes to be blocked
> by IRQ disabling.
> 
> For other operations, we should reschedule it to a software interrupt
> at a lower level than 15, but nobody has done the work to implement
> this yet.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
