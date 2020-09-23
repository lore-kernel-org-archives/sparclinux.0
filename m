From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 23 Sep 2020 21:12:34 +0000
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
Message-Id: <20200923171234.0001402d@oasis.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
 <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
 <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
 <87eemwcpnq.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
 <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
 <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
 <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
 <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
 <20200923115251.7cc63a7e@oasis.local.home>
 <874kno9pr9.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kno9pr9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-sparc <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Greentime Hu <green.hu@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Wed, 23 Sep 2020 22:55:54 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > Perhaps make migrate_disable() an anonymous local_lock()?
> >
> > This should lower the SHC in theory, if you can't have stacked migrate
> > disables on the same CPU.  
> 
> I'm pretty sure this ends up in locking hell pretty fast and aside of
> that it's not working for scenarios like:
> 
>      kmap_local();
>        migrate_disable();
>        ...
> 
>      copy_from_user()
>         -> #PF
>            -> schedule()  
> 
> which brought us into that discussion in the first place. You would stop
> any other migrate disable user from running until the page fault is
> resolved...

Then scratch the idea of having anonymous local_lock() and just bring
local_lock in directly? Then have a kmap local lock, which would only
block those that need to do a kmap.

Now as for migration disabled nesting, at least now we would have
groupings of this, and perhaps the theorists can handle that. I mean,
how is this much different that having a bunch of tasks blocked on a
mutex with the owner is pinned on a CPU?

migrate_disable() is a BKL of pinning affinity. If we only have
local_lock() available (even on !RT), then it makes the blocking in
groups. At least this way you could grep for all the different
local_locks in the system and plug that into the algorithm for WCS,
just like one would with a bunch of mutexes.

-- Steve
