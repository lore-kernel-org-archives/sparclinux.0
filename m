From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Aug 2010 13:44:16 +0000
Subject: Re: 64-bit ppc rwsem
Message-Id: <201008231544.16422.arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1282107803.22370.173.camel@pasglop>
	<1282195403.22370.296.camel@pasglop>
	<20100818.222925.233689776.davem@davemloft.net>
In-Reply-To: <20100818.222925.233689776.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>

On Thursday 19 August 2010, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 19 Aug 2010 15:23:23 +1000
> 
> > Similar here, but using atomic_long_t instead so it works for 32-bit too
> > for me. I suppose we could make that part common indeed.
> > 
> > What about asm-generic/rwsem-atomic.h  or rwsem-cmpxchg.h ?
> 
> Using rwsem-cmpxchg.h sounds best I guess.

The implementation looks good for asm-generic, but there is now an asymmetry
between the spinlock and the atomic_long_t based version.

Maybe we can make them both do the same thing, either of

1. create include/linux/rwsem-cmpxchg.h and add an
   #elif defined(CONFIG_RWSEM_GENERIC_ATOMIC) to include/linux/rwsem.h

2. move include/linux/rwsem-spinlock.h to include/asm-generic/ and
   include that from all architectures that want the spinlock based version.

Further comments:

* Alpha has an optimization for the uniprocessor case, where the atomic
instructions get turned into nonatomic additions. The spinlock based
version uses no locks on UP but disables interrupts for reasons I don't
understand (nothing running at interrupt time should try to access an rwsem).
Should the generic version do the same as Alpha?

* Is there any architecture that would still benefit from having a separate
rwsem implementation? AFAICT all the remaining ones are just variations of
the same concept of using cmpxchg (or xadd in case of x86), which is what
atomics typically end up doing anyway.

	Arnd
