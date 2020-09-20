From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 20 Sep 2020 06:41:02 +0000
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
Message-Id: <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
 <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-sparc <sparclinux@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

On Sat, Sep 19 2020 at 10:18, Linus Torvalds wrote:
> On Sat, Sep 19, 2020 at 2:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> this provides a preemptible variant of kmap_atomic & related
>> interfaces. This is achieved by:
>
> Ack. This looks really nice, even apart from the new capability.
>
> The only thing I really reacted to is that the name doesn't make sense
> to me: "kmap_temporary()" seems a bit odd.

Yeah. Couldn't come up with something useful.

> Particularly for an interface that really is basically meant as a
> better replacement of "kmap_atomic()" (but is perhaps also a better
> replacement for "kmap()").
>
> I think I understand how the name came about: I think the "temporary"
> is there as a distinction from the "longterm" regular kmap(). So I
> think it makes some sense from an internal implementation angle, but I
> don't think it makes a lot of sense from an interface name.
>
> I don't know what might be a better name, but if we want to emphasize
> that it's thread-private and a one-off, maybe "local" would be a
> better naming, and make it distinct from the "global" nature of the
> old kmap() interface?

Right, _local or _thread would be more intuitive.

> However, another solution might be to just use this new preemptible
> "local" kmap(), and remove the old global one entirely. Yes, the old
> global one caches the page table mapping and that sounds really
> efficient and nice. But it's actually horribly horribly bad, because
> it means that we need to use locking for them. Your new "temporary"
> implementation seems to be fundamentally better locking-wise, and only
> need preemption disabling as locking (and is equally fast for the
> non-highmem case).
>
> So I wonder if the single-page TLB flush isn't a better model, and
> whether it wouldn't be a lot simpler to just get rid of the old
> complex kmap() entirely, and replace it with this?
>
> I agree we can't replace the kmap_atomic() version, because maybe
> people depend on the preemption disabling it also implied. But what
> about replacing the non-atomic kmap()?
>
> Maybe I've missed something.  Is it because the new interface still
> does "pagefault_disable()" perhaps?
>
> But does it even need the pagefault_disable() at all? Yes, the
> *atomic* one obviously needed it. But why does this new one need to
> disable page faults?

It disables pagefaults because it can be called from atomic and
non-atomic context. That was the point to get rid of

         if (preeemptible())
         	kmap();
         else
                kmap_atomic();

If it does not disable pagefaults, then it's just a lightweight variant
of kmap() for short lived mappings.

> But apart from that question about naming (and perhaps replacing
> kmap() entirely), I very much like it.

I thought about it, but then I figured that kmap pointers can be
handed to other contexts from the thread which sets up the mapping
because it's 'permanent'.

I'm not sure whether that actually happens, so we'd need to audit all
kmap() users to be sure. If there is no such use case, then we surely
can get of rid of kmap() completely. It's only 300+ instances to stare
at and quite some of them are wrapped into other functions.

Highmem sucks no matter what and the only sane solution is to remove it
completely.

Thanks,

        tglx
