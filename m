From: peterz@infradead.org
Date: Wed, 23 Sep 2020 08:40:32 +0000
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
Message-Id: <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
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
In-Reply-To: <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, David Airlie <airlied@linux.ie>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-sparc <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Mel Gorman <mgorman@suse.de>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

On Mon, Sep 21, 2020 at 09:27:57PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 21 2020 at 09:24, Linus Torvalds wrote:
> > On Mon, Sep 21, 2020 at 12:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> If a task is migrated to a different CPU then the mapping address will
> >> change which will explode in colourful ways.
> >
> > Right you are.
> >
> > Maybe we really *could* call this new kmap functionality something
> > like "kmap_percpu()" (or maybe "local" is good enough), and make it
> > act like your RT code does for spinlocks - not disable preemption, but
> > only disabling CPU migration.
> 
> I"m all for it, but the scheduler people have opinions :)

Right, so I'm concerned. migrate_disable() wrecks pretty much all
Real-Time scheduler theory we have, and PREEMPRT_RT bringing it in is
somewhat ironic.

Yes, it allows breaking up non-preemptible regions of non-deterministic
duration, and thereby both reduce and bound the scheduling latency, the
cost for doing that is that the theory on CPU utilization/bandwidth go
out the window.

To easily see this consider an SMP system with a number of tasks equal
to the number of CPUs. On a regular (preempt_disable) kernel we can
always run each task, by virtue of always having an idle CPU to take the
task.

However, with migrate_disable() we can have each task preempted in a
migrate_disable() region, worse we can stack them all on the _same_ CPU
(super ridiculous odds, sure). And then we end up only able to run one
task, with the rest of the CPUs picking their nose.

The end result is that, like with unbounded latency, we will still miss
our deadline, simply because we got starved for CPU.


Now, while we could (with a _lot_ of work) rework the kernel to not rely
on the implicit per-cpu ness of things like spinlock_t, the moment we
bring in basic primitives that rely on migrate_disable() we're stuck
with it.


The problem is; afaict there's been no research into this problem. There
might be scheduling (read: balancing) schemes that can mitigate/solve
this problem, or it might prove to be a 'hard' problem, I just don't
know. But once we start down this road, it's going to be hell to get rid
of it.

That's why I've been arguing (for many years) to strictly limit this to
PREEMPT_RT and only as a gap-stop, not a fundamental primitive to build
on.
