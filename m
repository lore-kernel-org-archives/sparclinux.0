From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 24 Sep 2020 13:58:05 +0000
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
Message-Id: <20200924135805.GN2628@hirez.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
 <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
 <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
 <20200923115251.7cc63a7e@oasis.local.home>
 <874kno9pr9.fsf@nanos.tec.linutronix.de>
 <20200923171234.0001402d@oasis.local.home>
 <871riracgf.fsf@nanos.tec.linutronix.de>
 <20200924083241.314f2102@gandalf.local.home>
 <20200924124241.GK2628@hirez.programming.kicks-ass.net>
 <20200924095138.5318d242@oasis.local.home>
In-Reply-To: <20200924095138.5318d242@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, David Airlie <airlied@linux.ie>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-sparc <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Mel Gorman <mgorman@suse.de>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Greentime Hu <green.hu@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@synopsys.com>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 24, 2020 at 09:51:38AM -0400, Steven Rostedt wrote:

> > It turns out, that getting selected for pull-balance is exactly that
> > condition, and clearly a migrate_disable() task cannot be pulled, but we
> > can use that signal to try and pull away the running task that's in the
> > way.
> 
> Unless of course that running task is in a migrate disable section
> itself ;-)

See my ramblings here:

  https://lkml.kernel.org/r/20200924082717.GA1362448@hirez.programming.kicks-ass.net

My plan was to have the migrate_enable() of the running task trigger the
migration in that case.
