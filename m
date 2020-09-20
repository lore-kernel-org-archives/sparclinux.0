From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Sep 2020 16:57:40 +0000
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
Message-Id: <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
 <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
 <87k0wode9a.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0wode9a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-sparc <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

On Sun, Sep 20, 2020 at 1:49 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Actually most usage sites of kmap atomic do not need page faults to be
> disabled at all.

Right. I think the pagefault disabling has (almost) nothing at all to
do with the kmap() itself - it comes from the "atomic" part, not the
"kmap" part.

I say *almost*, because there is one issue that needs some thought:
the amount of kmap nesting.

The kmap_atomic() interface - and your local/temporary/whatever
versions of it - depends very much inherently on being strictly
nesting. In fact, it depends so much on it that maybe that should be
part of the new name?

It's very wrong to do

    addr1 = kmap_atomic();
    addr2 = kmap_atomic();
    ..do something with addr 1..
    kunmap_atomic(addr1);
    .. do something with addr 2..
    kunmap_atomic(addr2);

because the way we allocate the slots is by using a percpu-atomic
inc-return (and we deallocate using dec).

So it's fundamentally a stack.

And that's perfectly fine for page faults - if they do any kmaps,
those will obviously nest.

So the only issue with page faults might be that the stack grows
_larger_. And that might need some thought. We already make the kmap
stack bigger for CONFIG_DEBUG_HIGHMEM, and it's possibly that if we
allow page faults we need to make the kmap stack bigger still.

Btw, looking at the stack code, Ithink your new implementation of it
is a bit scary:

   static inline int kmap_atomic_idx_push(void)
   {
  -       int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
  +       int idx = current->kmap_ctrl.idx++;

and now that 'current->kmap_ctrl.idx' is not atomic wrt

 (a) NMI's (this may be ok, maybe we never do kmaps in NMIs, and with
nesting I think it's fine anyway - the NMI will undo whatever it did)

 (b) the prev/next switch

And that (b) part worries me. You do the kmap_switch_temporary() to
switch the entries, but you do that *separately* from actually
switching 'current' to the new value.

So kmap_switch_temporary() looks safe, but I don't think it actually
is. Because while it first unmaps the old entries and then remaps the
new ones, an interrupt can come in, and at that point it matters what
is *CURRENT*.

And regardless of whether 'current' is 'prev' or 'next', that
kmap_switch_temporary() loop may be doing the wrong thing, depending
on which one had the deeper stack. The interrupt will be using
whatever "current->kmap_ctrl.idx" is, but that might overwrite entries
that are in the process of being restored (if current is still 'prev',
but kmap_switch_temporary() is in the "restore @next's kmaps" pgase),
or it might stomp on entries that have been pte_clear()'ed by the
'prev' thing.

I dunno. The latter may be one of those "it works anyway, it
overwrites things we don't care about", but the former will most
definitely not work.

And it will be completely impossible to debug, because it will depend
on an interrupt that uses kmap_local/atomic/whatever() coming in
_just_ at the right point in the scheduler, and only when the
scheduler has been entered with the right number of kmap entries on
the prev/next stack.

And no developer will ever see this with any amount of debug code
enabled, because it will only hit on legacy platforms that do this
kmap anyway.

So honestly, that code scares me. I think it's buggy. And even if it
"happens to work", it does so for all the wrong reasons, and is very
fragile.

So I would suggest:

 - continue to use an actual per-cpu kmap_atomic_idx

 - make the switching code save the old idx, then unmap the old
entries one by one (while doing the proper "pop" action), and then map
the new entries one by one (while doing the proper "push" action).

which would mean that the only index that is actually ever *USED* is
the percpu one, and it's always up-to-date and pushed/popped for
individual entries, rather than this - imho completely bogus -
optimization where you use "p->kmap_ctrl.idx" directly and very very
unsafely.

Alternatively, that process counter would need about a hundred lines
of commentary about exactly why it's safe. Because I don't think it
is.

                   Linus
