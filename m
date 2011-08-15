From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 15 Aug 2011 14:32:49 +0000
Subject: Re: [PATCH,SPARC] make sparc32 arch_write_unlock() match the
Message-Id: <20041.11793.565236.115039@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <20040.65109.439941.444670@pilspetsen.it.uu.se>
	<20110815133116.GA20563@entuzijast.net>
In-Reply-To: <20110815133116.GA20563@entuzijast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josip Rodin <joy@entuzijast.net>
Cc: Mikael Pettersson <mikpe@it.uu.se>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Josip Rodin writes:
 > On Mon, Aug 15, 2011 at 01:09:09PM +0200, Mikael Pettersson wrote:
 > > The sparc32 version of arch_write_unlock() is just a plain assignment.
 > > Unfortunately this allows the compiler to schedule side-effects in a
 > > protected region to occur after the HW-level unlock, which is broken.
 > > E.g., the following trivial test case gets miscompiled:
 > > 
 > > 	#include <linux/spinlock.h>
 > > 	rwlock_t lock;
 > > 	int counter;
 > > 	void foo(void) { write_lock(&lock); ++counter; write_unlock(&lock); }
 > > 
 > > Fixed by adding a compiler memory barrier to arch_write_unlock().  The
 > > sparc64 version combines the barrier and assignment into a single asm(),
 > > so that's what I did here as well.
 > > 
 > > Compiled-tested with a sparc32 SMP kernel.
 > > 
 > > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
 > > ---
 > > --- linux-3.1-rc2/arch/sparc/include/asm/spinlock_32.h.~1~	2011-07-22 12:01:08.000000000 +0200
 > > +++ linux-3.1-rc2/arch/sparc/include/asm/spinlock_32.h	2011-08-15 11:43:49.000000000 +0200
 > > @@ -131,6 +131,15 @@ static inline void arch_write_lock(arch_
 > >  	*(volatile __u32 *)&lp->lock = ~0U;
 > >  }
 > >  
 > > +static void inline arch_write_unlock(arch_rwlock_t *lock)
 > > +{
 > > +	__asm__ __volatile__(
 > > +"	st		%%g0, [%0]"
 > > +	: /* no outputs */
 > > +	: "r" (lock)
 > > +	: "memory");
 > > +}
 > > +
 > >  static inline int arch_write_trylock(arch_rwlock_t *rw)
 > >  {
 > >  	unsigned int val;
 > > @@ -175,7 +184,7 @@ static inline int __arch_read_trylock(ar
 > >  	res; \
 > >  })
 > >  
 > > -#define arch_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
 > > +#define arch_write_unlock(rw)	arch_write_unlock(rw)
 > >  
 > >  #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 > >  #define arch_read_lock_flags(rw, flags)   arch_read_lock(rw)
 > 
 > Why keep the tautological define? Just wondering.

Only because sparc64 does it that way.  I now see that no other
arch has the #define, so perhaps that bit should be deleted (from
both sparc64 and sparc32).
