From: David Miller <davem@davemloft.net>
Date: Fri, 19 May 2017 19:15:53 +0000
Subject: Re: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Message-Id: <20170519.151553.928484900690074462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
        <20170518.223113.1783186374793423172.davem@davemloft.net>
        <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
In-Reply-To: <20170519090302.ph6jnqzlxxqzrvnu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: babu.moger@oracle.com, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 19 May 2017 11:03:02 +0200

> On Thu, May 18, 2017 at 10:31:13PM -0400, David Miller wrote:
>> From: Babu Moger <babu.moger@oracle.com>
>> Date: Thu, 18 May 2017 18:36:08 -0600
>> 
>> > @@ -82,6 +82,7 @@ config SPARC64
>> >  	select HAVE_ARCH_AUDITSYSCALL
>> >  	select ARCH_SUPPORTS_ATOMIC_RMW
>> >  	select HAVE_NMI
>> > +	select ARCH_USE_QUEUED_RWLOCKS
>> >  
>> 
>> If you are selecting this on SPARC64 all the time, then:
>> 
>> > @@ -94,6 +94,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
>> >  	: "memory");
>> >  }
>> >  
>> > +#ifndef CONFIG_QUEUED_RWLOCKS
>> >  /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
>> 
>> You can remove this segment of ifdef'd code altogether since it is in
>> a sparc64 specific header file.
> 
> 
> So IIRC Sparc v8 only has that single byte load-and-set (or swap)
> instruction, right? That means you can only make test-and-set spinlocks
> and then have to build the world on top of that.
> 
> I don't see qrwlock -- which assumes the spinlock implementation is fair
> -- making much sense for that.
> 
> Also, IIRC Sparc-v8 didn't really have very big SMP systems, those came
> with v9. And qspinlock only really makes sense on the bigger systems
> (not to mention that building the qspinlock on top of atomic operations
> build on test-and-set spinlocks just seems extremely dysfunctional).
> 
> 
> In any case, I think what I'm saying is that it makes sense to make this
> a Sparcv9 only feature.

I agree with you, there is no reason to try and support
queued locks on 32-bit sparc.

However, I don't see what any of this has to do with the feedback
I was giving the patch author :-)
