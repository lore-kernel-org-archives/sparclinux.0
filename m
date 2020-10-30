From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 30 Oct 2020 09:39:11 +0000
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
Message-Id: <87blgknjcw.fsf@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com> <87pn50ob0s.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pn50ob0s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>, linux-sparc <sparclinux@vger.kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org

On Fri, Oct 30 2020 at 00:41, Thomas Gleixner wrote:
> On Thu, Oct 29 2020 at 16:11, Linus Torvalds wrote:
> No, you're not misreading it, but doing it conditionally would be a
> complete semantical disaster. kmap_atomic*() also disables preemption
> and pagefaults unconditionaly.  If that wouldn't be the case then every
> caller would have to have conditionals like 'if (CONFIG_HIGHMEM)' or
> worse 'if (PageHighMem(page)'.
>
> Let's not go there.
>
> Migrate disable is a less horrible plague than preempt and pagefault
> disable even if the scheduler people disagree due to the lack of theory
> backing that up :)
>
> The charm of the new interface is that users still can rely on per
> cpuness independent of being on a highmem plagued system. For non
> highmem systems the extra migrate disable/enable is really a minor
> nuissance.

thinking about it some more after having sleep and coffee, we actually
could hide the migrate disable in the actual highmem part.

But then we really should not name it kmap_local. 'local' suggests
locality, think local_irq*, local_bh* ... kmap_task would be more
accurate then.

Toughts?

        tglx
