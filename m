From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Oct 2020 20:28:24 +0000
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
Message-Id: <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blgknjcw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, linux-sparc <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org

On Fri, Oct 30, 2020 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But then we really should not name it kmap_local. 'local' suggests
> locality, think local_irq*, local_bh* ... kmap_task would be more
> accurate then.

So the main reason I'd like to see it is because I think on a
non-highmem machine, the new kmap should be a complete no-op. IOW,
we'd make sure that there are no costs, no need to increment any
"restrict migration" counts etc.

It's been a bit of a pain to have kmap_atomic() have magical side
semantics that people might then depend on.

I think "local" could still work as a name, because it would have to
be thread-local (and maybe we'd want a debug mode where that gets
verified, as actual HIGHMEM machines are getting rare).

I'd avoid "task", because that implies (to me, at least) that it
wouldn't be good for interrupts etc that don't have a task context.

I think the main issue is that it has to be released in the same
context as it was created (ie no passing those things around to other
contexts). I think "local" is fine for that, but I could imagine other
names. The ones that come to mind are somewhat cumbersome, though
("shortterm" or "local_ctx" or something along those lines).

I dunno.

              Linus
