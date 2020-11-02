From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 02 Nov 2020 01:08:23 +0000
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
Message-Id: <87k0v48t14.fsf@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de>
In-Reply-To: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Matthew Wilcox <willy@infradead.org>

On Thu, Oct 29 2020 at 23:18, Thomas Gleixner wrote:
>
> There is also a still to be investigated question from Linus on the initial
> posting versus the per cpu / per task mapping stack depth which might need
> to be made larger due to the ability to take page faults within a mapping
> region.

I looked deeper into that and we have a stack depth of 20. That's plenty
and I couldn't find a way to get above 10 nested ones including faults,
interrupts, softirqs. With some stress testing I was not able to get over
a maximum of 6 according to the traceprintk I added.

For some obscure reason when CONFIG_DEBUG_HIGHMEM is enabled the stack
depth is increased from 20 to 41. But the only thing DEBUG_HIGHMEM does
is to enable a few BUG_ON()'s in the mapping code.

That's a leftover from the historical mapping code which had fixed
entries for various purposes. DEBUG_HIGHMEM inserted guard mappings
between the map types. But that got all ditched when kmap_atomic()
switched to a stack based map management. Though the WITH_KM_FENCE magic
survived without being functional. All the thing does today is to
increase the stack depth.

I just made that functional again by keeping the stack depth increase
and utilizing every second slot. That should catch Willy's mapping
problem nicely if he bothers to test on 32bit :)

Thanks,

        tglx
